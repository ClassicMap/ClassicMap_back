-- 샤를 쾨클랭 작품을 MusicBrainz 작품 구조로 다시 짠다(4차 자동). 작품 110개(묶음 37, 다악장 41, 낱곡 32),
-- 새 작품 4개, part 498개, 그 아래 84개.
-- seed 115개 중 106개를 작품·part 에 잇고, 9개를 숨기고, 0개는 그대로 둔다.
--
-- 4차는 사람·에이전트 판단 없이 규칙으로 만들었다. 자료와 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/(auto_catalog.py, <작곡가>/catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고 편곡·다른 판·
--     발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고, 못 읽으면 원제를 둔다
--     (MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을 쥐고 있으면
--     그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 목록에 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면(제목이 전혀 다름)
--     잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다(식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.

-- Op. 188 15개의 연습곡 Op. 188

UPDATE pieces piece
SET piece.title = '15개의 연습곡 Op. 188', piece.title_en = '15 Études for Saxophone and Piano, op. 188',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '188',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23575 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pour les traits rapides', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 1. Pour les traits rapides',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2013f6cc-c824-4ca6-8506-c4df1e8fb310' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2013f6cc-c824-4ca6-8506-c4df1e8fb310', 1, NULL, 'Pour les traits rapides', '15 Études for Saxophone and Piano, op. 188: No. 1. Pour les traits rapides', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2013f6cc-c824-4ca6-8506-c4df1e8fb310'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pour les sons liés et le charme de la sonorité', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 2. Pour les sons liés et le charme de la sonorité',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ce9adc2e-e4a3-41c1-a55f-4331bc1a820f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ce9adc2e-e4a3-41c1-a55f-4331bc1a820f', 2, NULL, 'Pour les sons liés et le charme de la sonorité', '15 Études for Saxophone and Piano, op. 188: No. 2. Pour les sons liés et le charme de la sonorité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce9adc2e-e4a3-41c1-a55f-4331bc1a820f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pour les arpèges', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 3. Pour les arpèges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b747c243-4cbd-4d19-b509-7a7409729b4a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b747c243-4cbd-4d19-b509-7a7409729b4a', 3, NULL, 'Pour les arpèges', '15 Études for Saxophone and Piano, op. 188: No. 3. Pour les arpèges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b747c243-4cbd-4d19-b509-7a7409729b4a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Pour la douceur des attaques', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 4. Pour la douceur des attaques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8e79f54c-728d-4f88-a646-cfbd82fba0b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e79f54c-728d-4f88-a646-cfbd82fba0b0', 4, NULL, 'Pour la douceur des attaques', '15 Études for Saxophone and Piano, op. 188: No. 4. Pour la douceur des attaques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e79f54c-728d-4f88-a646-cfbd82fba0b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Pour le charme du son dans un mouvement vif', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 5. Pour le charme du son dans un mouvement vif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dcb49929-4013-409a-89b5-aa37b31f6046' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcb49929-4013-409a-89b5-aa37b31f6046', 5, NULL, 'Pour le charme du son dans un mouvement vif', '15 Études for Saxophone and Piano, op. 188: No. 5. Pour le charme du son dans un mouvement vif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcb49929-4013-409a-89b5-aa37b31f6046'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Pour le style soutenu et doux en sons liés', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 6. Pour le style soutenu et doux en sons liés',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:70c02657-3f98-45be-98e1-97f471faddbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70c02657-3f98-45be-98e1-97f471faddbf', 6, NULL, 'Pour le style soutenu et doux en sons liés', '15 Études for Saxophone and Piano, op. 188: No. 6. Pour le style soutenu et doux en sons liés', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70c02657-3f98-45be-98e1-97f471faddbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pour les sons liés et le charme de la sonorité', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 7. Pour les sons liés et le charme de la sonorité',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:67deb717-ad9f-4c1c-8428-9b5649a81ebf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67deb717-ad9f-4c1c-8428-9b5649a81ebf', 7, NULL, 'Pour les sons liés et le charme de la sonorité', '15 Études for Saxophone and Piano, op. 188: No. 7. Pour les sons liés et le charme de la sonorité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67deb717-ad9f-4c1c-8428-9b5649a81ebf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Pour les notes en staccato et le mélange de legato et staccato', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 8. Pour les notes en staccato et le mélange de legato et staccato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e1c929a6-7884-420b-a73e-a2d9c483ebea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1c929a6-7884-420b-a73e-a2d9c483ebea', 8, NULL, 'Pour les notes en staccato et le mélange de legato et staccato', '15 Études for Saxophone and Piano, op. 188: No. 8. Pour les notes en staccato et le mélange de legato et staccato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1c929a6-7884-420b-a73e-a2d9c483ebea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Pour la longeur de la respiration et l''égalité du son', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 9. Pour la longeur de la respiration et l''égalité du son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:47d0a56a-8491-4b93-aeb2-a19f771b533d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47d0a56a-8491-4b93-aeb2-a19f771b533d', 9, NULL, 'Pour la longeur de la respiration et l''égalité du son', '15 Études for Saxophone and Piano, op. 188: No. 9. Pour la longeur de la respiration et l''égalité du son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47d0a56a-8491-4b93-aeb2-a19f771b533d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Pour la qualité du son dans un style soutenu et pour les nuances', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 10. Pour la qualité du son dans un style soutenu et pour les nuances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6d58e886-effe-4510-b4ce-2d6237b6d60e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6d58e886-effe-4510-b4ce-2d6237b6d60e', 10, NULL, 'Pour la qualité du son dans un style soutenu et pour les nuances', '15 Études for Saxophone and Piano, op. 188: No. 10. Pour la qualité du son dans un style soutenu et pour les nuances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6d58e886-effe-4510-b4ce-2d6237b6d60e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Pour la solidité du rythme', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 11. Pour la solidité du rythme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:618df090-b92e-4af0-805e-2ec9e41ce021' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:618df090-b92e-4af0-805e-2ec9e41ce021', 11, NULL, 'Pour la solidité du rythme', '15 Études for Saxophone and Piano, op. 188: No. 11. Pour la solidité du rythme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:618df090-b92e-4af0-805e-2ec9e41ce021'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Pour l''égalité du son et pour les nuances', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 12. Pour l''égalité du son et pour les nuances',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6865d9b3-57b5-417e-935d-771fafc0a9ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6865d9b3-57b5-417e-935d-771fafc0a9ef', 12, NULL, 'Pour l''égalité du son et pour les nuances', '15 Études for Saxophone and Piano, op. 188: No. 12. Pour l''égalité du son et pour les nuances', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6865d9b3-57b5-417e-935d-771fafc0a9ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Pour la légèreté du son', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 13. Pour la légèreté du son',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6167c36e-b4b2-42d9-859a-006a107befe4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6167c36e-b4b2-42d9-859a-006a107befe4', 13, NULL, 'Pour la légèreté du son', '15 Études for Saxophone and Piano, op. 188: No. 13. Pour la légèreté du son', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6167c36e-b4b2-42d9-859a-006a107befe4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Pour une sonorité soutenue et expressive, pour la douceur du grave et de l''aigue', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 14. Pour une sonorité soutenue et expressive, pour la douceur du grave et de l''aigue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4e47a843-2564-4470-8975-9b7a2640489e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e47a843-2564-4470-8975-9b7a2640489e', 14, NULL, 'Pour une sonorité soutenue et expressive, pour la douceur du grave et de l''aigue', '15 Études for Saxophone and Piano, op. 188: No. 14. Pour une sonorité soutenue et expressive, pour la douceur du grave et de l''aigue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e47a843-2564-4470-8975-9b7a2640489e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Pour les accents qui doivent donner le rythme de la phrase', part.name_en = '15 Études for Saxophone and Piano, op. 188: No. 15. Pour les accents qui doivent donner le rythme de la phrase',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23575 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e92760d8-a78d-48da-9976-3d55c01988ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e92760d8-a78d-48da-9976-3d55c01988ec', 15, NULL, 'Pour les accents qui doivent donner le rythme de la phrase', '15 Études for Saxophone and Piano, op. 188: No. 15. Pour les accents qui doivent donner le rythme de la phrase', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23575 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e92760d8-a78d-48da-9976-3d55c01988ec'
);


-- Op. 23 2 Poèmes d'André Chénier Op. 23

UPDATE pieces piece
SET piece.title = '2 Poèmes d''André Chénier Op. 23', piece.title_en = '2 Poèmes d''André Chénier, op. 23',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '23',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24469 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Jeune Tarentine, op. 23 no. 1', part.name_en = 'La Jeune Tarentine, op. 23 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24469 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5012443c-ca55-4d74-932e-6495305c72c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5012443c-ca55-4d74-932e-6495305c72c4', 1, NULL, 'La Jeune Tarentine, op. 23 no. 1', 'La Jeune Tarentine, op. 23 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24469 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5012443c-ca55-4d74-932e-6495305c72c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Néère, op. 23 no. 2', part.name_en = 'Néère, op. 23 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24469 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a34ab5c2-73b4-4981-823b-2f3db36bffda' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a34ab5c2-73b4-4981-823b-2f3db36bffda', 2, NULL, 'Néère, op. 23 no. 2', 'Néère, op. 23 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24469 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a34ab5c2-73b4-4981-823b-2f3db36bffda'
);


-- None 3 Chansons populaires de la Vendée

UPDATE pieces piece
SET piece.title = '3 Chansons populaires de la Vendée', piece.title_en = '3 Chansons populaires de la Vendée',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24381 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Mon père a fait un champ de poes', part.name_en = '3 Chansons populaires de la Vendée: No. 3. Mon père a fait un champ de poes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24381 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:65205784-7855-4ed7-ab9f-bdb6e207a017' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:65205784-7855-4ed7-ab9f-bdb6e207a017', 1, NULL, 'Mon père a fait un champ de poes', '3 Chansons populaires de la Vendée: No. 3. Mon père a fait un champ de poes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24381 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:65205784-7855-4ed7-ab9f-bdb6e207a017'
);


-- Op. 87 4 Nouvelles sonatines Op. 87

UPDATE pieces piece
SET piece.title = '4 Nouvelles sonatines Op. 87', piece.title_en = '4 Nouvelles sonatines, op. 87',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '87',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23539 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonatine, op. 87 n° 1', part.name_en = 'Sonatine, op. 87 n° 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418', 1, NULL, 'Sonatine, op. 87 n° 1', 'Sonatine, op. 87 n° 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moderato, sans lenteur', part.name_en = 'Sonatine, op. 87 n° 1: I. Moderato, sans lenteur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:759306e7-2f43-4bb9-bcaf-5d1217ffb3c4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:759306e7-2f43-4bb9-bcaf-5d1217ffb3c4', 1, NULL, 'Moderato, sans lenteur', 'Sonatine, op. 87 n° 1: I. Moderato, sans lenteur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:759306e7-2f43-4bb9-bcaf-5d1217ffb3c4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante moderato', part.name_en = 'Sonatine, op. 87 n° 1: II. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d43df152-b91a-40ba-bc4e-0bf54aa89698' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d43df152-b91a-40ba-bc4e-0bf54aa89698', 2, NULL, 'Andante moderato', 'Sonatine, op. 87 n° 1: II. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d43df152-b91a-40ba-bc4e-0bf54aa89698'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Bien allant, gai et doux', part.name_en = 'Sonatine, op. 87 n° 1: III. Bien allant, gai et doux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5fcab6f0-5bb8-497d-aa87-8e9991bb4370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5fcab6f0-5bb8-497d-aa87-8e9991bb4370', 3, NULL, 'Bien allant, gai et doux', 'Sonatine, op. 87 n° 1: III. Bien allant, gai et doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fcab6f0-5bb8-497d-aa87-8e9991bb4370'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Final: allegro con moto', part.name_en = 'Sonatine, op. 87 n° 1: IV. Final: allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:29d449b7-eebd-4a28-9f79-1a5c66a99233' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:29d449b7-eebd-4a28-9f79-1a5c66a99233', 4, NULL, 'Final: allegro con moto', 'Sonatine, op. 87 n° 1: IV. Final: allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:dba75d09-8e63-4731-82a0-72f01e2eb418'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29d449b7-eebd-4a28-9f79-1a5c66a99233'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonatine, op. 87 n° 2', part.name_en = 'Sonatine, op. 87 n° 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea', 2, NULL, 'Sonatine, op. 87 n° 2', 'Sonatine, op. 87 n° 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Sonatine, op. 87 n° 2: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5862c91f-d4e2-4277-8036-336b562a864e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5862c91f-d4e2-4277-8036-336b562a864e', 1, NULL, 'Andante', 'Sonatine, op. 87 n° 2: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5862c91f-d4e2-4277-8036-336b562a864e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante espressivo', part.name_en = 'Sonatine, op. 87 n° 2: II. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4ba0c2c9-821a-43a4-9035-39c8bc6cee9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ba0c2c9-821a-43a4-9035-39c8bc6cee9d', 2, NULL, 'Andante espressivo', 'Sonatine, op. 87 n° 2: II. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ba0c2c9-821a-43a4-9035-39c8bc6cee9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Menuet', part.name_en = 'Sonatine, op. 87 n° 2: III. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c9547e90-9601-4c04-aa13-9e42e5f94168' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c9547e90-9601-4c04-aa13-9e42e5f94168', 3, NULL, 'Menuet', 'Sonatine, op. 87 n° 2: III. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c9547e90-9601-4c04-aa13-9e42e5f94168'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Allegro', part.name_en = 'Sonatine, op. 87 n° 2: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a1aa787c-2a31-4c84-bee8-a5d7470b561a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a1aa787c-2a31-4c84-bee8-a5d7470b561a', 4, NULL, 'Allegro', 'Sonatine, op. 87 n° 2: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:f34ca026-bf13-4b0c-8907-8ff2bd949eea'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1aa787c-2a31-4c84-bee8-a5d7470b561a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonatine, op. 87 n° 3', part.name_en = 'Sonatine, op. 87 n° 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35', 3, NULL, 'Sonatine, op. 87 n° 3', 'Sonatine, op. 87 n° 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scherzando molto moderato', part.name_en = 'Sonatine, op. 87 n° 3: I. Scherzando molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:75642291-3208-40a9-b55c-de59b9567ded' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:75642291-3208-40a9-b55c-de59b9567ded', 1, NULL, 'Scherzando molto moderato', 'Sonatine, op. 87 n° 3: I. Scherzando molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75642291-3208-40a9-b55c-de59b9567ded'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Mouvement de sicilienne', part.name_en = 'Sonatine, op. 87 n° 3: II. Mouvement de sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:95d4388d-e42d-4b05-ad37-79fe34c83756' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:95d4388d-e42d-4b05-ad37-79fe34c83756', 2, NULL, 'Mouvement de sicilienne', 'Sonatine, op. 87 n° 3: II. Mouvement de sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:95d4388d-e42d-4b05-ad37-79fe34c83756'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonatine, op. 87 n° 3: III. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:96805b2c-8061-436b-9430-c66d5c6757e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:96805b2c-8061-436b-9430-c66d5c6757e3', 3, NULL, 'Allegro moderato', 'Sonatine, op. 87 n° 3: III. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ea5f1716-efbc-4f6e-82e1-8d7aa00f4c35'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:96805b2c-8061-436b-9430-c66d5c6757e3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sonatine, op. 87 n° 4', part.name_en = 'Sonatine, op. 87 n° 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c', 4, NULL, 'Sonatine, op. 87 n° 4', 'Sonatine, op. 87 n° 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Animé', part.name_en = 'Sonatine, op. 87 n° 4: I. Animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0ec46fbc-2a6c-4f4f-ad3e-2c023b0d714f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0ec46fbc-2a6c-4f4f-ad3e-2c023b0d714f', 1, NULL, 'Animé', 'Sonatine, op. 87 n° 4: I. Animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec46fbc-2a6c-4f4f-ad3e-2c023b0d714f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Scherzando moderato', part.name_en = 'Sonatine, op. 87 n° 4: II. Scherzando moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9617af40-6b28-4d00-b0dc-386d1c30c401' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9617af40-6b28-4d00-b0dc-386d1c30c401', 2, NULL, 'Scherzando moderato', 'Sonatine, op. 87 n° 4: II. Scherzando moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9617af40-6b28-4d00-b0dc-386d1c30c401'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Assez lent', part.name_en = 'Sonatine, op. 87 n° 4: III. Assez lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:71610867-145b-4ab3-af69-f44def180835' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:71610867-145b-4ab3-af69-f44def180835', 3, NULL, 'Assez lent', 'Sonatine, op. 87 n° 4: III. Assez lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:71610867-145b-4ab3-af69-f44def180835'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Final: Allegro con moto', part.name_en = 'Sonatine, op. 87 n° 4: IV. Final: Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23539 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fab1667c-50d1-4284-b057-a2716eb861d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fab1667c-50d1-4284-b057-a2716eb861d8', 4, NULL, 'Final: Allegro con moto', 'Sonatine, op. 87 n° 4: IV. Final: Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:611a1d58-a053-4330-8862-76c424cf272c'
WHERE p.id = 23539 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fab1667c-50d1-4284-b057-a2716eb861d8'
);


-- Op. 22 4 mélodies Op. 22

UPDATE pieces piece
SET piece.title = '4 mélodies Op. 22', piece.title_en = '4 mélodies, op. 22',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '22',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24043 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Chanson des ingénues, op. 22 no. 1', part.name_en = 'La Chanson des ingénues, op. 22 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24043 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:42b60f7d-149d-4dc2-a10d-92c1ecdbe70c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42b60f7d-149d-4dc2-a10d-92c1ecdbe70c', 1, NULL, 'La Chanson des ingénues, op. 22 no. 1', 'La Chanson des ingénues, op. 22 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24043 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42b60f7d-149d-4dc2-a10d-92c1ecdbe70c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Novembre, op. 22 no. 2', part.name_en = 'Novembre, op. 22 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24043 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:91f881a4-e3b4-41b1-91cf-52fc4331876e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91f881a4-e3b4-41b1-91cf-52fc4331876e', 2, NULL, 'Novembre, op. 22 no. 2', 'Novembre, op. 22 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24043 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91f881a4-e3b4-41b1-91cf-52fc4331876e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Mon rêve familier, op. 22 no. 3', part.name_en = 'Mon rêve familier, op. 22 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24043 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:58203ceb-d554-458b-b257-40bb779c1056' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:58203ceb-d554-458b-b257-40bb779c1056', 3, NULL, 'Mon rêve familier, op. 22 no. 3', 'Mon rêve familier, op. 22 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24043 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:58203ceb-d554-458b-b257-40bb779c1056'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Il pleure dans mon cœur, op. 22 no. 4', part.name_en = 'Il pleure dans mon cœur, op. 22 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24043 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:395cf12c-4bbb-4a1c-af8c-f1a1155b9ae7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:395cf12c-4bbb-4a1c-af8c-f1a1155b9ae7', 4, NULL, 'Il pleure dans mon cœur, op. 22 no. 4', 'Il pleure dans mon cœur, op. 22 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24043 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:395cf12c-4bbb-4a1c-af8c-f1a1155b9ae7'
);


-- Op. 60 4 sonatines françaises Op. 60

UPDATE pieces piece
SET piece.title = '4 sonatines françaises Op. 60', piece.title_en = '4 sonatines françaises, op. 60',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '60',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25585 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonatine française, op. 60 no. 1', part.name_en = 'Sonatine française, op. 60 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d', 1, NULL, 'Sonatine française, op. 60 no. 1', 'Sonatine française, op. 60 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canons', part.name_en = 'Sonatine française, op. 60 no. 1: I. Canons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d6d7c110-6ee6-434f-b496-e918ba5d34ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d6d7c110-6ee6-434f-b496-e918ba5d34ea', 1, NULL, 'Canons', 'Sonatine française, op. 60 no. 1: I. Canons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d6d7c110-6ee6-434f-b496-e918ba5d34ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Sonatine française, op. 60 no. 1: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4c855cb9-4060-4e80-8fe8-9da16632e8f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4c855cb9-4060-4e80-8fe8-9da16632e8f9', 2, NULL, 'Allegretto', 'Sonatine française, op. 60 no. 1: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c855cb9-4060-4e80-8fe8-9da16632e8f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Intermezzo', part.name_en = 'Sonatine française, op. 60 no. 1: III. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:55c12c65-f156-489b-a983-12521021e8fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:55c12c65-f156-489b-a983-12521021e8fd', 3, NULL, 'Intermezzo', 'Sonatine française, op. 60 no. 1: III. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:55c12c65-f156-489b-a983-12521021e8fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Dans les vergers de Normandie', part.name_en = 'Sonatine française, op. 60 no. 1: IV. Dans les vergers de Normandie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2ebc8d53-4ca9-49a3-b44a-5bc5cbcfef76' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ebc8d53-4ca9-49a3-b44a-5bc5cbcfef76', 4, NULL, 'Dans les vergers de Normandie', 'Sonatine française, op. 60 no. 1: IV. Dans les vergers de Normandie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:0ec50da8-b99e-4681-964b-e662642c154d'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ebc8d53-4ca9-49a3-b44a-5bc5cbcfef76'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonatine française, op. 60 no. 2', part.name_en = 'Sonatine française, op. 60 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554', 2, NULL, 'Sonatine française, op. 60 no. 2', 'Sonatine française, op. 60 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pastorale', part.name_en = 'Sonatine française, op. 60 no. 2: I. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7cf7c510-9c76-4115-8408-d45a6ce709c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7cf7c510-9c76-4115-8408-d45a6ce709c8', 1, NULL, 'Pastorale', 'Sonatine française, op. 60 no. 2: I. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7cf7c510-9c76-4115-8408-d45a6ce709c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L''Apothéose des petits fauves', part.name_en = 'Sonatine française, op. 60 no. 2: II. L''Apothéose des petits fauves',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ee3a453b-5a55-413b-9174-bd489f132435' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ee3a453b-5a55-413b-9174-bd489f132435', 2, NULL, 'L''Apothéose des petits fauves', 'Sonatine française, op. 60 no. 2: II. L''Apothéose des petits fauves', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee3a453b-5a55-413b-9174-bd489f132435'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chant du soir', part.name_en = 'Sonatine française, op. 60 no. 2: III. Chant du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5a7512d2-02ee-4cdb-9884-46bf0be9dd22' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a7512d2-02ee-4cdb-9884-46bf0be9dd22', 3, NULL, 'Chant du soir', 'Sonatine française, op. 60 no. 2: III. Chant du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a7512d2-02ee-4cdb-9884-46bf0be9dd22'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Menuet', part.name_en = 'Sonatine française, op. 60 no. 2: IV. Menuet',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:408d7510-663a-43c9-9d72-4c5bece5ab84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:408d7510-663a-43c9-9d72-4c5bece5ab84', 4, NULL, 'Menuet', 'Sonatine française, op. 60 no. 2: IV. Menuet', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:408d7510-663a-43c9-9d72-4c5bece5ab84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Final', part.name_en = 'Sonatine française, op. 60 no. 2: V. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c31e0fed-b1c8-4a6c-ac53-ccefed2471f7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c31e0fed-b1c8-4a6c-ac53-ccefed2471f7', 5, NULL, 'Final', 'Sonatine française, op. 60 no. 2: V. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b266440e-982c-4171-b91b-7c14a2d2a554'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c31e0fed-b1c8-4a6c-ac53-ccefed2471f7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonatine française, op. 60 no. 3', part.name_en = 'Sonatine française, op. 60 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a', 3, NULL, 'Sonatine française, op. 60 no. 3', 'Sonatine française, op. 60 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Scherzando', part.name_en = 'Sonatine française, op. 60 no. 3: I. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b977a0e1-0ab5-4815-bb6a-c145c87fc9c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b977a0e1-0ab5-4815-bb6a-c145c87fc9c2', 1, NULL, 'Scherzando', 'Sonatine française, op. 60 no. 3: I. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b977a0e1-0ab5-4815-bb6a-c145c87fc9c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Chant du soir', part.name_en = 'Sonatine française, op. 60 no. 3: II. Chant du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2c6ee370-8176-41dd-88b8-6de4338231ca' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2c6ee370-8176-41dd-88b8-6de4338231ca', 2, NULL, 'Chant du soir', 'Sonatine française, op. 60 no. 3: II. Chant du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c6ee370-8176-41dd-88b8-6de4338231ca'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Ronde des vendanges', part.name_en = 'Sonatine française, op. 60 no. 3: III. Ronde des vendanges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:763d9245-c05c-458c-a4e0-c749867a2e84' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:763d9245-c05c-458c-a4e0-c749867a2e84', 3, NULL, 'Ronde des vendanges', 'Sonatine française, op. 60 no. 3: III. Ronde des vendanges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:937c9d66-1c9b-42d1-a8e8-3767c2eec16a'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:763d9245-c05c-458c-a4e0-c749867a2e84'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Sonatine française, op. 60 no. 4', part.name_en = 'Sonatine française, op. 60 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88', 4, NULL, 'Sonatine française, op. 60 no. 4', 'Sonatine française, op. 60 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Romance', part.name_en = 'Sonatine française, op. 60 no. 4: I. Romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4ebf3966-6bba-46ad-8a41-8eaf7bd5216f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4ebf3966-6bba-46ad-8a41-8eaf7bd5216f', 1, NULL, 'Romance', 'Sonatine française, op. 60 no. 4: I. Romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ebf3966-6bba-46ad-8a41-8eaf7bd5216f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Autre romance', part.name_en = 'Sonatine française, op. 60 no. 4: II. Autre romance',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f3a32834-8d3e-445d-bc93-5ba324687f17' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:f3a32834-8d3e-445d-bc93-5ba324687f17', 2, NULL, 'Autre romance', 'Sonatine française, op. 60 no. 4: II. Autre romance', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3a32834-8d3e-445d-bc93-5ba324687f17'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Final (homme à Monsieur Dumollet)', part.name_en = 'Sonatine française, op. 60 no. 4: III. Final (homme à Monsieur Dumollet)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25585 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0f8c133a-d8f5-4241-b7e7-11a534e1c251' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f8c133a-d8f5-4241-b7e7-11a534e1c251', 3, NULL, 'Final (homme à Monsieur Dumollet)', 'Sonatine française, op. 60 no. 4: III. Final (homme à Monsieur Dumollet)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:a18bdd6f-7982-4195-bc99-1ceabab63e88'
WHERE p.id = 25585 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f8c133a-d8f5-4241-b7e7-11a534e1c251'
);


-- Op. 59 5개의 피아노 소나티네 Op. 59

UPDATE pieces piece
SET piece.title = '5개의 피아노 소나티네 Op. 59', piece.title_en = '5 Piano Sonatinas, op. 59',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '59',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25434 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonatine, op. 59 n° 2', part.name_en = 'Sonatine, op. 59 n° 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd', 1, NULL, 'Sonatine, op. 59 n° 2', 'Sonatine, op. 59 n° 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Molto moderato', part.name_en = 'Sonatine, op. 59 n° 2: I. Molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8bae8d60-8de9-4ea0-b522-edda62b6c3ac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8bae8d60-8de9-4ea0-b522-edda62b6c3ac', 1, NULL, 'Molto moderato', 'Sonatine, op. 59 n° 2: I. Molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bae8d60-8de9-4ea0-b522-edda62b6c3ac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sicilienne', part.name_en = 'Sonatine, op. 59 n° 2: II. Sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:06349c78-e868-49cf-8d8f-23487594fd75' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:06349c78-e868-49cf-8d8f-23487594fd75', 2, NULL, 'Sicilienne', 'Sonatine, op. 59 n° 2: II. Sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06349c78-e868-49cf-8d8f-23487594fd75'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Sonatine, op. 59 n° 2: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d4d1712a-a858-4365-a4e3-2f831af135d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d4d1712a-a858-4365-a4e3-2f831af135d7', 3, NULL, 'Andante', 'Sonatine, op. 59 n° 2: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:36344822-d820-4e9a-b305-912201b21cdd'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d4d1712a-a858-4365-a4e3-2f831af135d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonatine, op. 59 n° 3', part.name_en = 'Sonatine, op. 59 n° 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e', 2, NULL, 'Sonatine, op. 59 n° 3', 'Sonatine, op. 59 n° 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonatine, op. 59 n° 3: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:70735bb3-b2a7-4bf2-b5ba-b4e33fa0c4f4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:70735bb3-b2a7-4bf2-b5ba-b4e33fa0c4f4', 1, NULL, 'Allegro moderato', 'Sonatine, op. 59 n° 3: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70735bb3-b2a7-4bf2-b5ba-b4e33fa0c4f4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Assez animé', part.name_en = 'Sonatine, op. 59 n° 3: II. Assez animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c1149a2a-ed81-4a69-ae11-c24a10463485' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:c1149a2a-ed81-4a69-ae11-c24a10463485', 2, NULL, 'Assez animé', 'Sonatine, op. 59 n° 3: II. Assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c1149a2a-ed81-4a69-ae11-c24a10463485'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegretto assez tranquille', part.name_en = 'Sonatine, op. 59 n° 3: III. Allegretto assez tranquille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9e16d30b-640d-4446-8f71-94195786144d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9e16d30b-640d-4446-8f71-94195786144d', 3, NULL, 'Allegretto assez tranquille', 'Sonatine, op. 59 n° 3: III. Allegretto assez tranquille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e16d30b-640d-4446-8f71-94195786144d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Final: Allegro con moto', part.name_en = 'Sonatine, op. 59 n° 3: IV. Final: Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25434 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e24a0293-6091-43ee-b37d-e52a872b5d44' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e24a0293-6091-43ee-b37d-e52a872b5d44', 4, NULL, 'Final: Allegro con moto', 'Sonatine, op. 59 n° 3: IV. Final: Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:3d613eb9-a44c-4d9c-a6ef-0d86caaa071e'
WHERE p.id = 25434 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e24a0293-6091-43ee-b37d-e52a872b5d44'
);


-- Op. 1 6 Rondels Op. 1

UPDATE pieces piece
SET piece.title = '6 Rondels Op. 1', piece.title_en = '6 Rondels, op. 1',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '1',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24008 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Printemps, op. 1 no. 4', part.name_en = 'Le Printemps, op. 1 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24008 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:da5530ea-a1ad-4b0a-911a-591799e6eecf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da5530ea-a1ad-4b0a-911a-591799e6eecf', 1, NULL, 'Le Printemps, op. 1 no. 4', 'Le Printemps, op. 1 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24008 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da5530ea-a1ad-4b0a-911a-591799e6eecf'
);


-- Op. 180 7개의 소품 Op. 180

UPDATE pieces piece
SET piece.title = '7개의 소품 Op. 180', piece.title_en = '7 Pieces for Saxophone and Piano, from op. 180',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '180',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25261 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante con moto', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 14. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:195a9f89-7bdd-45ae-9561-4e4e899dae04' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:195a9f89-7bdd-45ae-9561-4e4e899dae04', 1, NULL, 'Andante con moto', '7 Pieces for Saxophone and Piano, from op. 180: No. 14. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:195a9f89-7bdd-45ae-9561-4e4e899dae04'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 5. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3ada03a3-a9c8-49f7-983a-2ae69efe310a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ada03a3-a9c8-49f7-983a-2ae69efe310a', 2, NULL, 'Adagio', '7 Pieces for Saxophone and Piano, from op. 180: No. 5. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ada03a3-a9c8-49f7-983a-2ae69efe310a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 12. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:88f8f858-f6b4-400e-8b7f-c42af68afd74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88f8f858-f6b4-400e-8b7f-c42af68afd74', 3, NULL, 'Adagio', '7 Pieces for Saxophone and Piano, from op. 180: No. 12. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88f8f858-f6b4-400e-8b7f-c42af68afd74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Très doux presque adagio', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 15. Très doux presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:996c4941-524f-4e8a-b208-8aa63ba47e6a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:996c4941-524f-4e8a-b208-8aa63ba47e6a', 4, NULL, 'Très doux presque adagio', '7 Pieces for Saxophone and Piano, from op. 180: No. 15. Très doux presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:996c4941-524f-4e8a-b208-8aa63ba47e6a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante très doux', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 7. Andante très doux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a8c2376c-9c53-41a7-af36-30d7c7d39a27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a8c2376c-9c53-41a7-af36-30d7c7d39a27', 5, NULL, 'Andante très doux', '7 Pieces for Saxophone and Piano, from op. 180: No. 7. Andante très doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a8c2376c-9c53-41a7-af36-30d7c7d39a27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Andante presque adagio', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 3. Andante presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bd11bf23-d873-49a7-8c80-734f0e6521b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd11bf23-d873-49a7-8c80-734f0e6521b9', 6, NULL, 'Andante presque adagio', '7 Pieces for Saxophone and Piano, from op. 180: No. 3. Andante presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd11bf23-d873-49a7-8c80-734f0e6521b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Andante calme et doux', part.name_en = '7 Pieces for Saxophone and Piano, from op. 180: No. 10. Andante calme et doux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25261 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d90edce3-e796-4f53-b38b-64c3e836fa27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d90edce3-e796-4f53-b38b-64c3e836fa27', 7, NULL, 'Andante calme et doux', '7 Pieces for Saxophone and Piano, from op. 180: No. 10. Andante calme et doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25261 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d90edce3-e796-4f53-b38b-64c3e836fa27'
);


-- Op. 8 연가곡집 <7 Rondels> Op. 8

UPDATE pieces piece
SET piece.title = '연가곡집 <7 Rondels> Op. 8', piece.title_en = '7 Rondels, op. 8',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '8',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24086 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Pêche, op. 8 no. 1', part.name_en = 'La Pêche, op. 8 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24086 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6c4fda23-6603-480c-9763-ad525fe79dd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6c4fda23-6603-480c-9763-ad525fe79dd7', 1, NULL, 'La Pêche, op. 8 no. 1', 'La Pêche, op. 8 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24086 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6c4fda23-6603-480c-9763-ad525fe79dd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’Hiver, op. 8 no. 2', part.name_en = 'L’Hiver, op. 8 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24086 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f502a3f3-f554-495b-a819-f5aec9304fd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f502a3f3-f554-495b-a819-f5aec9304fd8', 2, NULL, 'L’Hiver, op. 8 no. 2', 'L’Hiver, op. 8 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24086 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f502a3f3-f554-495b-a819-f5aec9304fd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Les Pierreries, op. 8 no. 3', part.name_en = 'Les Pierreries, op. 8 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24086 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:47f6eb0e-68dc-483d-b13d-6d84a7d5c5e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:47f6eb0e-68dc-483d-b13d-6d84a7d5c5e5', 3, NULL, 'Les Pierreries, op. 8 no. 3', 'Les Pierreries, op. 8 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24086 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:47f6eb0e-68dc-483d-b13d-6d84a7d5c5e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Lune, op. 8 no. 4', part.name_en = 'La Lune, op. 8 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24086 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2d40b60a-8128-45cf-ad45-261a4268aa54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2d40b60a-8128-45cf-ad45-261a4268aa54', 4, NULL, 'La Lune, op. 8 no. 4', 'La Lune, op. 8 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24086 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2d40b60a-8128-45cf-ad45-261a4268aa54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Matin, op. 8 no. 6', part.name_en = 'Le Matin, op. 8 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24086 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:037dee75-57b2-45e8-8719-c26260b7c3ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:037dee75-57b2-45e8-8719-c26260b7c3ae', 5, NULL, 'Le Matin, op. 8 no. 6', 'Le Matin, op. 8 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24086 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:037dee75-57b2-45e8-8719-c26260b7c3ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'La Paix, op. 8 no. 7', part.name_en = 'La Paix, op. 8 no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24086 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:acabbc60-8213-40f0-ae0c-6c47fd70bca1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acabbc60-8213-40f0-ae0c-6c47fd70bca1', 6, NULL, 'La Paix, op. 8 no. 7', 'La Paix, op. 8 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24086 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acabbc60-8213-40f0-ae0c-6c47fd70bca1'
);


-- Op. 14 9 Rondels Op. 14

UPDATE pieces piece
SET piece.title = '9 Rondels Op. 14', piece.title_en = '9 Rondels, op. 14',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '14',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24828 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La Terre, op. 14 no. 6', part.name_en = 'La Terre, op. 14 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24828 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:089d571c-3c13-440a-b442-722dc6ef658a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:089d571c-3c13-440a-b442-722dc6ef658a', 1, NULL, 'La Terre, op. 14 no. 6', 'La Terre, op. 14 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24828 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:089d571c-3c13-440a-b442-722dc6ef658a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'L’Automne, op. 14 no. 7', part.name_en = 'L’Automne, op. 14 no. 7',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24828 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2a8ae00f-bf66-4a01-8154-34025bc4f50f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a8ae00f-bf66-4a01-8154-34025bc4f50f', 2, NULL, 'L’Automne, op. 14 no. 7', 'L’Automne, op. 14 no. 7', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24828 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a8ae00f-bf66-4a01-8154-34025bc4f50f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Guerre, op. 14 no. 9', part.name_en = 'La Guerre, op. 14 no. 9',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24828 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5edb8dbf-3f37-4a74-9e23-ae42bec7c8bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5edb8dbf-3f37-4a74-9e23-ae42bec7c8bc', 3, NULL, 'La Guerre, op. 14 no. 9', 'La Guerre, op. 14 no. 9', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24828 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5edb8dbf-3f37-4a74-9e23-ae42bec7c8bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Le Jour, op. 14 no. 1', part.name_en = 'Le Jour, op. 14 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24828 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6903ba6b-3b21-422a-9208-7613ba82891b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6903ba6b-3b21-422a-9208-7613ba82891b', 4, NULL, 'Le Jour, op. 14 no. 1', 'Le Jour, op. 14 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24828 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6903ba6b-3b21-422a-9208-7613ba82891b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Les Étoiles, op. 14 no. 8', part.name_en = 'Les Étoiles, op. 14 no. 8',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24828 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a0442460-82ad-4ad0-a3d6-f47d3a929f5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0442460-82ad-4ad0-a3d6-f47d3a929f5e', 5, NULL, 'Les Étoiles, op. 14 no. 8', 'Les Étoiles, op. 14 no. 8', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24828 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0442460-82ad-4ad0-a3d6-f47d3a929f5e'
);


-- Op. 201 Adagio

UPDATE pieces piece
SET piece.title = 'Adagio', piece.title_en = 'Adagio, op. 201',
    piece.type = 'song', piece.opus_number = 'Op. 201',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24486 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 211 Adagio Op. 211

UPDATE pieces piece
SET piece.title = 'Adagio Op. 211', piece.title_en = 'Adagio, op. 211',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '211',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24072 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andante con moto

UPDATE pieces piece
SET piece.title = 'Andante con moto', piece.title_en = 'Andante con moto',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25469 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Andante quasi adagio

UPDATE pieces piece
SET piece.title = 'Andante quasi adagio', piece.title_en = 'Andante quasi adagio',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24273 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 50 Ballade pour piano et orchestre

UPDATE pieces piece
SET piece.title = 'Ballade pour piano et orchestre', piece.title_en = 'Ballade pour piano et orchestre, op. 50',
    piece.type = 'song', piece.opus_number = 'Op. 50',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24796 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 71 바순 소나타

UPDATE pieces piece
SET piece.title = '바순 소나타', piece.title_en = 'Bassoon Sonata, op. 71',
    piece.type = 'album', piece.opus_number = 'Op. 71',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25346 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante moderato - Allegretto scherzando - Tempo I', part.name_en = 'Bassoon Sonata, op. 71: I. Andante moderato - Allegretto scherzando - Tempo I',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25346 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:50e22acb-7722-4877-ac5f-de5df85c1f9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50e22acb-7722-4877-ac5f-de5df85c1f9c', 1, 'I', 'Andante moderato - Allegretto scherzando - Tempo I', 'Bassoon Sonata, op. 71: I. Andante moderato - Allegretto scherzando - Tempo I', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25346 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50e22acb-7722-4877-ac5f-de5df85c1f9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Nocturne. Presque adagio', part.name_en = 'Bassoon Sonata, op. 71: II. Nocturne. Presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25346 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9b863e52-5a9e-4323-8f11-cf66d5b4c044' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9b863e52-5a9e-4323-8f11-cf66d5b4c044', 2, 'II', 'Nocturne. Presque adagio', 'Bassoon Sonata, op. 71: II. Nocturne. Presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25346 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9b863e52-5a9e-4323-8f11-cf66d5b4c044'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final. Allegro, vigoureusement et rudement rythmé - Stesso tempo - Assez lent - [Mouvement initial]', part.name_en = 'Bassoon Sonata, op. 71: III. Final. Allegro, vigoureusement et rudement rythmé - Stesso tempo - Assez lent - [Mouvement initial]',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25346 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:93aa4d8f-ee35-4787-90df-ab8163a7cbab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93aa4d8f-ee35-4787-90df-ab8163a7cbab', 3, 'III', 'Final. Allegro, vigoureusement et rudement rythmé - Stesso tempo - Assez lent - [Mouvement initial]', 'Bassoon Sonata, op. 71: III. Final. Allegro, vigoureusement et rudement rythmé - Stesso tempo - Assez lent - [Mouvement initial]', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25346 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93aa4d8f-ee35-4787-90df-ab8163a7cbab'
);


-- Op. 115 Chansons Bretonnes Op. 115

UPDATE pieces piece
SET piece.title = 'Chansons Bretonnes Op. 115', piece.title_en = 'Chansons Bretonnes, op. 115',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '115',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25081 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Book 1: No. 1. La Prophétie de Gwene''hlan', part.name_en = 'Chansons Bretonnes, op. 115: Book 1: No. 1. La Prophétie de Gwene''hlan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3fb3e360-b4a7-46c0-9f9c-12abadfe8b79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3fb3e360-b4a7-46c0-9f9c-12abadfe8b79', 1, NULL, 'Book 1: No. 1. La Prophétie de Gwene''hlan', 'Chansons Bretonnes, op. 115: Book 1: No. 1. La Prophétie de Gwene''hlan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fb3e360-b4a7-46c0-9f9c-12abadfe8b79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Book 1: No. 2. Le Seigneur Nann et la Fée', part.name_en = 'Chansons Bretonnes, op. 115: Book 1: No. 2. Le Seigneur Nann et la Fée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:56026960-7c68-4b7d-bae6-76fb4d829cc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56026960-7c68-4b7d-bae6-76fb4d829cc1', 2, NULL, 'Book 1: No. 2. Le Seigneur Nann et la Fée', 'Chansons Bretonnes, op. 115: Book 1: No. 2. Le Seigneur Nann et la Fée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56026960-7c68-4b7d-bae6-76fb4d829cc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Book 1: No. 3. Le Vin des Gaulois', part.name_en = 'Chansons Bretonnes, op. 115: Book 1: No. 3. Le Vin des Gaulois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:317466fa-e843-4757-bd76-2273c8f41cb2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:317466fa-e843-4757-bd76-2273c8f41cb2', 3, NULL, 'Book 1: No. 3. Le Vin des Gaulois', 'Chansons Bretonnes, op. 115: Book 1: No. 3. Le Vin des Gaulois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:317466fa-e843-4757-bd76-2273c8f41cb2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Book 1: No. 4. Azénor-la-Pâle', part.name_en = 'Chansons Bretonnes, op. 115: Book 1: No. 4. Azénor-la-Pâle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2c901443-80cb-460f-9cce-f4727db7f83c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c901443-80cb-460f-9cce-f4727db7f83c', 4, NULL, 'Book 1: No. 4. Azénor-la-Pâle', 'Chansons Bretonnes, op. 115: Book 1: No. 4. Azénor-la-Pâle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c901443-80cb-460f-9cce-f4727db7f83c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Book 1: No. 5. Saint-Eflam et le Roi Arthur', part.name_en = 'Chansons Bretonnes, op. 115: Book 1: No. 5. Saint-Eflam et le Roi Arthur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c7df3dd0-85c0-4c3e-9585-b84aef7ba52f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7df3dd0-85c0-4c3e-9585-b84aef7ba52f', 5, NULL, 'Book 1: No. 5. Saint-Eflam et le Roi Arthur', 'Chansons Bretonnes, op. 115: Book 1: No. 5. Saint-Eflam et le Roi Arthur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7df3dd0-85c0-4c3e-9585-b84aef7ba52f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Book 1: No. 6. Les Laboureurs', part.name_en = 'Chansons Bretonnes, op. 115: Book 1: No. 6. Les Laboureurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8bb59c97-eeaa-4f83-8b12-7bb85b759e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8bb59c97-eeaa-4f83-8b12-7bb85b759e6c', 6, NULL, 'Book 1: No. 6. Les Laboureurs', 'Chansons Bretonnes, op. 115: Book 1: No. 6. Les Laboureurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8bb59c97-eeaa-4f83-8b12-7bb85b759e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Book 2: No. 1. Les trois Moines rouges', part.name_en = 'Chansons Bretonnes, op. 115: Book 2: No. 1. Les trois Moines rouges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:133622b4-40fa-4f2c-bd17-93f0ae737b6b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:133622b4-40fa-4f2c-bd17-93f0ae737b6b', 7, NULL, 'Book 2: No. 1. Les trois Moines rouges', 'Chansons Bretonnes, op. 115: Book 2: No. 1. Les trois Moines rouges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:133622b4-40fa-4f2c-bd17-93f0ae737b6b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Book 2: No. 2. Alain-le-Renard', part.name_en = 'Chansons Bretonnes, op. 115: Book 2: No. 2. Alain-le-Renard',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:04a48901-4ea6-4f47-9a50-55f43129f4d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04a48901-4ea6-4f47-9a50-55f43129f4d3', 8, NULL, 'Book 2: No. 2. Alain-le-Renard', 'Chansons Bretonnes, op. 115: Book 2: No. 2. Alain-le-Renard', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04a48901-4ea6-4f47-9a50-55f43129f4d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Book 2: No. 3. Le baron Jaouioz', part.name_en = 'Chansons Bretonnes, op. 115: Book 2: No. 3. Le baron Jaouioz',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b44df387-1ed2-4a00-9fc0-1d5b080a7bba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b44df387-1ed2-4a00-9fc0-1d5b080a7bba', 9, NULL, 'Book 2: No. 3. Le baron Jaouioz', 'Chansons Bretonnes, op. 115: Book 2: No. 3. Le baron Jaouioz', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b44df387-1ed2-4a00-9fc0-1d5b080a7bba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Book 2: No. 4. Notre-Dame du Folgoat', part.name_en = 'Chansons Bretonnes, op. 115: Book 2: No. 4. Notre-Dame du Folgoat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6f0b64a1-17ec-4244-bc23-bbbe54ba112b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6f0b64a1-17ec-4244-bc23-bbbe54ba112b', 10, NULL, 'Book 2: No. 4. Notre-Dame du Folgoat', 'Chansons Bretonnes, op. 115: Book 2: No. 4. Notre-Dame du Folgoat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f0b64a1-17ec-4244-bc23-bbbe54ba112b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Book 2: No. 5. Iannik Skolan', part.name_en = 'Chansons Bretonnes, op. 115: Book 2: No. 5. Iannik Skolan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a942e688-2ee7-4a59-b5af-a477a1a1bf01' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a942e688-2ee7-4a59-b5af-a477a1a1bf01', 11, NULL, 'Book 2: No. 5. Iannik Skolan', 'Chansons Bretonnes, op. 115: Book 2: No. 5. Iannik Skolan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a942e688-2ee7-4a59-b5af-a477a1a1bf01'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Book 2: No. 6. La Ceinture de Noces', part.name_en = 'Chansons Bretonnes, op. 115: Book 2: No. 6. La Ceinture de Noces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1cc1d072-d396-4196-ad66-e028a770d1a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cc1d072-d396-4196-ad66-e028a770d1a2', 12, NULL, 'Book 2: No. 6. La Ceinture de Noces', 'Chansons Bretonnes, op. 115: Book 2: No. 6. La Ceinture de Noces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cc1d072-d396-4196-ad66-e028a770d1a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 1. La Chanson du pilote', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 1. La Chanson du pilote',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:591ac279-16ad-40c6-9e8e-45b93b850ffc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:591ac279-16ad-40c6-9e8e-45b93b850ffc', 13, NULL, 'Book 3: No. 1. La Chanson du pilote', 'Chansons Bretonnes, op. 115: Book 3: No. 1. La Chanson du pilote', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:591ac279-16ad-40c6-9e8e-45b93b850ffc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 2. Merlin au berceau', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 2. Merlin au berceau',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:31d4421b-92cf-499e-ab56-2854062e7bbc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:31d4421b-92cf-499e-ab56-2854062e7bbc', 14, NULL, 'Book 3: No. 2. Merlin au berceau', 'Chansons Bretonnes, op. 115: Book 3: No. 2. Merlin au berceau', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:31d4421b-92cf-499e-ab56-2854062e7bbc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 3. La Conversion de Merlin', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 3. La Conversion de Merlin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:44eff1d0-425c-4e28-b3b0-18912fd6bfa6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44eff1d0-425c-4e28-b3b0-18912fd6bfa6', 15, NULL, 'Book 3: No. 3. La Conversion de Merlin', 'Chansons Bretonnes, op. 115: Book 3: No. 3. La Conversion de Merlin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44eff1d0-425c-4e28-b3b0-18912fd6bfa6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 4. Le Faucon', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 4. Le Faucon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:67f86e3f-1f86-42ab-839d-b0c7f6ef597d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67f86e3f-1f86-42ab-839d-b0c7f6ef597d', 16, NULL, 'Book 3: No. 4. Le Faucon', 'Chansons Bretonnes, op. 115: Book 3: No. 4. Le Faucon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67f86e3f-1f86-42ab-839d-b0c7f6ef597d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 5. Le Rossignol modulant', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 5. Le Rossignol modulant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:be71acae-24aa-4481-9f56-e8628ca5af81' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:be71acae-24aa-4481-9f56-e8628ca5af81', 17, NULL, 'Book 3: No. 5. Le Rossignol modulant', 'Chansons Bretonnes, op. 115: Book 3: No. 5. Le Rossignol modulant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:be71acae-24aa-4481-9f56-e8628ca5af81'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 6. L''Enfant supposé', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 6. L''Enfant supposé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5c2a67ed-9f86-4d12-ba65-1ccaee5c77ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c2a67ed-9f86-4d12-ba65-1ccaee5c77ed', 18, NULL, 'Book 3: No. 6. L''Enfant supposé', 'Chansons Bretonnes, op. 115: Book 3: No. 6. L''Enfant supposé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c2a67ed-9f86-4d12-ba65-1ccaee5c77ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 7. L''Épouse du croisé', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 7. L''Épouse du croisé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:00546ed8-50ac-45ab-9b7b-85bb415d7407' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:00546ed8-50ac-45ab-9b7b-85bb415d7407', 19, NULL, 'Book 3: No. 7. L''Épouse du croisé', 'Chansons Bretonnes, op. 115: Book 3: No. 7. L''Épouse du croisé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:00546ed8-50ac-45ab-9b7b-85bb415d7407'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 8. Le page de Louis XIII', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 8. Le page de Louis XIII',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:204d4349-cb1c-4e7e-9338-951ba3e609b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:204d4349-cb1c-4e7e-9338-951ba3e609b0', 20, NULL, 'Book 3: No. 8. Le page de Louis XIII', 'Chansons Bretonnes, op. 115: Book 3: No. 8. Le page de Louis XIII', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:204d4349-cb1c-4e7e-9338-951ba3e609b0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Book 3: No. 9. La Marche d''Arthur', part.name_en = 'Chansons Bretonnes, op. 115: Book 3: No. 9. La Marche d''Arthur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25081 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:44e4f734-8f29-466e-b9a8-9ae42c419ac0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:44e4f734-8f29-466e-b9a8-9ae42c419ac0', 21, NULL, 'Book 3: No. 9. La Marche d''Arthur', 'Chansons Bretonnes, op. 115: Book 3: No. 9. La Marche d''Arthur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25081 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:44e4f734-8f29-466e-b9a8-9ae42c419ac0'
);


-- Op. 39 Chansons de Bilitis Op. 39

UPDATE pieces piece
SET piece.title = 'Chansons de Bilitis Op. 39', piece.title_en = 'Chansons de Bilitis, op. 39',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '39',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23721 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Hymne à Astarté', part.name_en = 'Chansons de Bilitis, op. 39: No. 1. Hymne à Astarté',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23721 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:115fb3ec-d0b1-4e5d-a9d3-7704bfe59764' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:115fb3ec-d0b1-4e5d-a9d3-7704bfe59764', 1, NULL, 'Hymne à Astarté', 'Chansons de Bilitis, op. 39: No. 1. Hymne à Astarté', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23721 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:115fb3ec-d0b1-4e5d-a9d3-7704bfe59764'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pluie au matin', part.name_en = 'Chansons de Bilitis, op. 39: No. 2. Pluie au matin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23721 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2c903240-6651-41b1-a7b7-9bf3362e567e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c903240-6651-41b1-a7b7-9bf3362e567e', 2, NULL, 'Pluie au matin', 'Chansons de Bilitis, op. 39: No. 2. Pluie au matin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23721 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c903240-6651-41b1-a7b7-9bf3362e567e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chant funèbre', part.name_en = 'Chansons de Bilitis, op. 39: No. 3. Chant funèbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23721 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b8f4ea7b-5364-4a70-b7c1-5fb948d0eb21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8f4ea7b-5364-4a70-b7c1-5fb948d0eb21', 3, NULL, 'Chant funèbre', 'Chansons de Bilitis, op. 39: No. 3. Chant funèbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23721 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8f4ea7b-5364-4a70-b7c1-5fb948d0eb21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Hymne à la nuit', part.name_en = 'Chansons de Bilitis, op. 39: No. 4. Hymne à la nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23721 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2ac26a33-967a-4a57-a0bf-84c424bbb0f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ac26a33-967a-4a57-a0bf-84c424bbb0f8', 4, NULL, 'Hymne à la nuit', 'Chansons de Bilitis, op. 39: No. 4. Hymne à la nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23721 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ac26a33-967a-4a57-a0bf-84c424bbb0f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Épitaphe de Bilitis', part.name_en = 'Chansons de Bilitis, op. 39: No. 5. Épitaphe de Bilitis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23721 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8e7bd8b0-32be-4772-84dd-8cd2822ec48d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e7bd8b0-32be-4772-84dd-8cd2822ec48d', 5, NULL, 'Épitaphe de Bilitis', 'Chansons de Bilitis, op. 39: No. 5. Épitaphe de Bilitis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23721 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e7bd8b0-32be-4772-84dd-8cd2822ec48d'
);


-- None Chant de la Résurrection, op. 179 bis

UPDATE pieces piece
SET piece.title = 'Chant de la Résurrection, op. 179 bis', piece.title_en = 'Chant de la Résurrection, op. 179 bis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24071 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 37 Chant funèbre à la mémoire des jeunes femmes défuntes

UPDATE pieces piece
SET piece.title = 'Chant funèbre à la mémoire des jeunes femmes défuntes', piece.title_en = 'Chant funèbre à la mémoire des jeunes femmes défuntes, op. 37',
    piece.type = 'song', piece.opus_number = 'Op. 37',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23585 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 161 Choral Final du Requiem

UPDATE pieces piece
SET piece.title = 'Choral Final du Requiem', piece.title_en = 'Choral Final du Requiem, op. 161',
    piece.type = 'song', piece.opus_number = 'Op. 161',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25347 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 90b Choral en fa mineur

UPDATE pieces piece
SET piece.title = 'Choral en fa mineur', piece.title_en = 'Choral en fa mineur, op. 90b',
    piece.type = 'song', piece.opus_number = 'Op. 90b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25896 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 5 연가곡집 <Cinq mélodies> Op. 5

UPDATE pieces piece
SET piece.title = '연가곡집 <Cinq mélodies> Op. 5', piece.title_en = 'Cinq mélodies, op. 5',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '5',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25375 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Promenade galante, op. 5 no. 1', part.name_en = 'Promenade galante, op. 5 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25375 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7bea74fc-f8aa-4029-b99b-0d32b51e8f34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7bea74fc-f8aa-4029-b99b-0d32b51e8f34', 1, NULL, 'Promenade galante, op. 5 no. 1', 'Promenade galante, op. 5 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25375 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7bea74fc-f8aa-4029-b99b-0d32b51e8f34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Moisson prochaine, op. 5 no. 2', part.name_en = 'Moisson prochaine, op. 5 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25375 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4c8ad41d-b84c-4a7c-91ec-fe5e92b1a94d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c8ad41d-b84c-4a7c-91ec-fe5e92b1a94d', 2, NULL, 'Moisson prochaine, op. 5 no. 2', 'Moisson prochaine, op. 5 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25375 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c8ad41d-b84c-4a7c-91ec-fe5e92b1a94d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Chanson d''amour, op. 5 no. 3', part.name_en = 'Chanson d''amour, op. 5 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25375 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:304687cd-c83e-4736-b340-17f19a377dcc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:304687cd-c83e-4736-b340-17f19a377dcc', 3, NULL, 'Chanson d''amour, op. 5 no. 3', 'Chanson d''amour, op. 5 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25375 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:304687cd-c83e-4736-b340-17f19a377dcc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Menuet, op. 5 no. 4', part.name_en = 'Menuet, op. 5 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25375 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2e01465e-4e9c-4a1d-9444-193123f423b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e01465e-4e9c-4a1d-9444-193123f423b8', 4, NULL, 'Menuet, op. 5 no. 4', 'Menuet, op. 5 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25375 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e01465e-4e9c-4a1d-9444-193123f423b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Si tu le veux, op. 5 no. 5', part.name_en = 'Si tu le veux, op. 5 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25375 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a2aa162c-182f-4009-a23b-5010488739f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a2aa162c-182f-4009-a23b-5010488739f3', 5, NULL, 'Si tu le veux, op. 5 no. 5', 'Si tu le veux, op. 5 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25375 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a2aa162c-182f-4009-a23b-5010488739f3'
);


-- Op. 163 Dances for Ginger

UPDATE pieces piece
SET piece.title = 'Dances for Ginger', piece.title_en = 'Dances for Ginger, op. 163',
    piece.type = 'album', piece.opus_number = 'Op. 163',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24714 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'L''Élan', part.name_en = 'Dances for Ginger, op. 163: I. L''Élan',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24714 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:eb57fe90-3b0b-4374-bcd1-e43956cc6846' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb57fe90-3b0b-4374-bcd1-e43956cc6846', 1, 'I', 'L''Élan', 'Dances for Ginger, op. 163: I. L''Élan', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24714 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb57fe90-3b0b-4374-bcd1-e43956cc6846'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Danse lente', part.name_en = 'Dances for Ginger, op. 163: II. Danse lente',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24714 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2a75127c-103e-416c-93fe-65ac7fe494bd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a75127c-103e-416c-93fe-65ac7fe494bd', 2, 'II', 'Danse lente', 'Dances for Ginger, op. 163: II. Danse lente', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24714 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a75127c-103e-416c-93fe-65ac7fe494bd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les Tourbillons', part.name_en = 'Dances for Ginger, op. 163: III. Les Tourbillons',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24714 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:72551b59-e9f8-4e1c-b3d3-16b024c9d285' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72551b59-e9f8-4e1c-b3d3-16b024c9d285', 3, 'III', 'Les Tourbillons', 'Dances for Ginger, op. 163: III. Les Tourbillons', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24714 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72551b59-e9f8-4e1c-b3d3-16b024c9d285'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Danse sous les étoiles', part.name_en = 'Dances for Ginger, op. 163: IV. La Danse sous les étoiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24714 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f963378d-f484-4c67-99c5-55d77b584ee5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f963378d-f484-4c67-99c5-55d77b584ee5', 4, 'IV', 'La Danse sous les étoiles', 'Dances for Ginger, op. 163: IV. La Danse sous les étoiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24714 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f963378d-f484-4c67-99c5-55d77b584ee5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Final - Apothéose de la danse', part.name_en = 'Dances for Ginger, op. 163: V. Final - Apothéose de la danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24714 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:97937732-4610-4221-a294-d1780561b09a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97937732-4610-4221-a294-d1780561b09a', 5, 'V', 'Final - Apothéose de la danse', 'Dances for Ginger, op. 163: V. Final - Apothéose de la danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24714 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97937732-4610-4221-a294-d1780561b09a'
);


-- Op. 4 Deux Chœurs pour voix de femmes Op. 4

UPDATE pieces piece
SET piece.title = 'Deux Chœurs pour voix de femmes Op. 4', piece.title_en = 'Deux Chœurs pour voix de femmes, op. 4',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '4',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25985 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Dans le ciel clair, op. 4 no. 1', part.name_en = 'Dans le ciel clair, op. 4 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25985 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ff656340-290f-4850-b707-8b9ba05f6a41' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff656340-290f-4850-b707-8b9ba05f6a41', 1, NULL, 'Dans le ciel clair, op. 4 no. 1', 'Dans le ciel clair, op. 4 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25985 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff656340-290f-4850-b707-8b9ba05f6a41'
);


-- None Deux Nocturnes, op. 32 bis

UPDATE pieces piece
SET piece.title = 'Deux Nocturnes, op. 32 bis', piece.title_en = 'Deux Nocturnes, op. 32 bis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24353 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Venise (Andante con moto)', part.name_en = 'Deux Nocturnes, op. 32 bis: I. Venise (Andante con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24353 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4d57654c-7690-4853-ad3f-cb2c403f02ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d57654c-7690-4853-ad3f-cb2c403f02ba', 1, 'I', 'Venise (Andante con moto)', 'Deux Nocturnes, op. 32 bis: I. Venise (Andante con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24353 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d57654c-7690-4853-ad3f-cb2c403f02ba'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Dans la forêt (Adagio)', part.name_en = 'Deux Nocturnes, op. 32 bis: II. Dans la forêt (Adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24353 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8993f7ef-605c-4c9a-b3ce-9f1fd1ceb19c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8993f7ef-605c-4c9a-b3ce-9f1fd1ceb19c', 2, 'II', 'Dans la forêt (Adagio)', 'Deux Nocturnes, op. 32 bis: II. Dans la forêt (Adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24353 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8993f7ef-605c-4c9a-b3ce-9f1fd1ceb19c'
);


-- Op. 194 Deux Sonatines pour hautbois d'amour Op. 194

UPDATE pieces piece
SET piece.title = 'Deux Sonatines pour hautbois d''amour Op. 194', piece.title_en = 'Deux Sonatines pour hautbois d''amour, op. 194',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '194',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25861 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonatine pour hautbois d''amour, op. 194 no. 1', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e', 1, NULL, 'Sonatine pour hautbois d''amour, op. 194 no. 1', 'Sonatine pour hautbois d''amour, op. 194 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 1: I. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0f7d1f0f-2923-4059-9052-8c075cfd2376' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:0f7d1f0f-2923-4059-9052-8c075cfd2376', 1, NULL, 'Andante quasi adagio', 'Sonatine pour hautbois d''amour, op. 194 no. 1: I. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f7d1f0f-2923-4059-9052-8c075cfd2376'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andantino con moto (presque allegretto)', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 1: II. Andantino con moto (presque allegretto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8461782e-a0fe-4322-be5c-6dbf84a4262e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:8461782e-a0fe-4322-be5c-6dbf84a4262e', 2, NULL, 'Andantino con moto (presque allegretto)', 'Sonatine pour hautbois d''amour, op. 194 no. 1: II. Andantino con moto (presque allegretto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8461782e-a0fe-4322-be5c-6dbf84a4262e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante con moto (assez allant)', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 1: III. Andante con moto (assez allant)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b6f82684-4a9a-434a-9a8e-55d32afa822a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b6f82684-4a9a-434a-9a8e-55d32afa822a', 3, NULL, 'Andante con moto (assez allant)', 'Sonatine pour hautbois d''amour, op. 194 no. 1: III. Andante con moto (assez allant)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b6f82684-4a9a-434a-9a8e-55d32afa822a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante con moto (presque allegro moderato)', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 1: IV. Andante con moto (presque allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1fd07b82-7d5d-4cee-93bf-cb7813e2f34a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1fd07b82-7d5d-4cee-93bf-cb7813e2f34a', 4, NULL, 'Andante con moto (presque allegro moderato)', 'Sonatine pour hautbois d''amour, op. 194 no. 1: IV. Andante con moto (presque allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1fd07b82-7d5d-4cee-93bf-cb7813e2f34a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 1: V. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:28361ec6-aa4b-4157-ab50-c7a8c5fa616c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:28361ec6-aa4b-4157-ab50-c7a8c5fa616c', 5, NULL, 'Allegro moderato', 'Sonatine pour hautbois d''amour, op. 194 no. 1: V. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:d1c87e26-fb31-4fff-b519-21c7067d9a1e'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28361ec6-aa4b-4157-ab50-c7a8c5fa616c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonatine pour hautbois d''amour, op. 194 no. 2', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58', 2, NULL, 'Sonatine pour hautbois d''amour, op. 194 no. 2', 'Sonatine pour hautbois d''amour, op. 194 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Andante (très calme, presque adagio)', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 2: I. Andante (très calme, presque adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fff08597-233e-469e-8787-743ac14044b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:fff08597-233e-469e-8787-743ac14044b3', 1, NULL, 'Andante (très calme, presque adagio)', 'Sonatine pour hautbois d''amour, op. 194 no. 2: I. Andante (très calme, presque adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fff08597-233e-469e-8787-743ac14044b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante con moto', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 2: II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5a506075-3322-4a83-b092-cb7bc4c82092' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5a506075-3322-4a83-b092-cb7bc4c82092', 2, NULL, 'Andante con moto', 'Sonatine pour hautbois d''amour, op. 194 no. 2: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5a506075-3322-4a83-b092-cb7bc4c82092'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Presque adagio', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 2: III. Presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bfee0447-43fc-40c9-a69d-015f809e0cb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:bfee0447-43fc-40c9-a69d-015f809e0cb4', 3, NULL, 'Presque adagio', 'Sonatine pour hautbois d''amour, op. 194 no. 2: III. Presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bfee0447-43fc-40c9-a69d-015f809e0cb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Finale: Allegro bien rythmé, mais pas trop vite', part.name_en = 'Sonatine pour hautbois d''amour, op. 194 no. 2: IV. Finale: Allegro bien rythmé, mais pas trop vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25861 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d67d87f0-4c4f-4555-9a93-b08607951ece' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d67d87f0-4c4f-4555-9a93-b08607951ece', 4, NULL, 'Finale: Allegro bien rythmé, mais pas trop vite', 'Sonatine pour hautbois d''amour, op. 194 no. 2: IV. Finale: Allegro bien rythmé, mais pas trop vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:b8dd55b1-7f48-46a6-be36-e801c9638e58'
WHERE p.id = 25861 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d67d87f0-4c4f-4555-9a93-b08607951ece'
);


-- Op. 212b Deux Vocalises

UPDATE pieces piece
SET piece.title = 'Deux Vocalises', piece.title_en = 'Deux Vocalises, op. 212b',
    piece.type = 'album', piece.opus_number = 'Op. 212b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24793 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegretto ben moderato', part.name_en = 'Deux Vocalises, op. 212b: I. Allegretto ben moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24793 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:738cc4c6-74e2-4a5e-aca4-6695cd1df1cc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:738cc4c6-74e2-4a5e-aca4-6695cd1df1cc', 1, 'I', 'Allegretto ben moderato', 'Deux Vocalises, op. 212b: I. Allegretto ben moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24793 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:738cc4c6-74e2-4a5e-aca4-6695cd1df1cc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Deux Vocalises, op. 212b: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24793 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:03d9f8c8-d741-495e-9c16-702ba7cb3e77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:03d9f8c8-d741-495e-9c16-702ba7cb3e77', 2, 'II', 'Adagio', 'Deux Vocalises, op. 212b: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24793 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:03d9f8c8-d741-495e-9c16-702ba7cb3e77'
);


-- Op. 43 Deux poèmes symphoniques Op. 43

UPDATE pieces piece
SET piece.title = 'Deux poèmes symphoniques Op. 43', piece.title_en = 'Deux poèmes symphoniques, op. 43',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '43',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24878 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Soleil et danses dans la forêt, op. 43 no. 1', part.name_en = 'Soleil et danses dans la forêt, op. 43 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24878 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0d4408b0-0054-46ee-a470-389d3eb83f2e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0d4408b0-0054-46ee-a470-389d3eb83f2e', 1, NULL, 'Soleil et danses dans la forêt, op. 43 no. 1', 'Soleil et danses dans la forêt, op. 43 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24878 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0d4408b0-0054-46ee-a470-389d3eb83f2e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Vers la plage lointaine, op. 43 no. 2', part.name_en = 'Vers la plage lointaine, op. 43 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24878 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0c7dc3ba-aa43-40b6-87c3-8d8cdd00281b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0c7dc3ba-aa43-40b6-87c3-8d8cdd00281b', 2, NULL, 'Vers la plage lointaine, op. 43 no. 2', 'Vers la plage lointaine, op. 43 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24878 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0c7dc3ba-aa43-40b6-87c3-8d8cdd00281b'
);


-- Op. 41 Esquisses Op. 41

UPDATE pieces piece
SET piece.title = 'Esquisses Op. 41', piece.title_en = 'Esquisses, op. 41',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '41',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23577 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Première Série', part.name_en = 'Esquisses, op. 41: Première Série',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010', 1, NULL, 'Première Série', 'Esquisses, op. 41: Première Série', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Assez calme (à la blanche)', part.name_en = 'Esquisses, op. 41: Première Série: I. Assez calme (à la blanche)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:199debd1-2eae-42c1-914f-7607425f642e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:199debd1-2eae-42c1-914f-7607425f642e', 1, NULL, 'Assez calme (à la blanche)', 'Esquisses, op. 41: Première Série: I. Assez calme (à la blanche)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:199debd1-2eae-42c1-914f-7607425f642e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto e dolce', part.name_en = 'Esquisses, op. 41: Première Série: II. Allegretto e dolce',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1574fb33-4c82-4884-b632-a4a46fc9cd64' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1574fb33-4c82-4884-b632-a4a46fc9cd64', 2, NULL, 'Allegretto e dolce', 'Esquisses, op. 41: Première Série: II. Allegretto e dolce', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1574fb33-4c82-4884-b632-a4a46fc9cd64'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato con moto', part.name_en = 'Esquisses, op. 41: Première Série: III. Allegro moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ef16f1db-6317-4265-b00c-ae6d127cadb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ef16f1db-6317-4265-b00c-ae6d127cadb6', 3, NULL, 'Allegro moderato con moto', 'Esquisses, op. 41: Première Série: III. Allegro moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef16f1db-6317-4265-b00c-ae6d127cadb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante moderato', part.name_en = 'Esquisses, op. 41: Première Série: IV. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1dc59df2-3596-40ec-96eb-0b4e3d1bc251' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:1dc59df2-3596-40ec-96eb-0b4e3d1bc251', 4, NULL, 'Andante moderato', 'Esquisses, op. 41: Première Série: IV. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1dc59df2-3596-40ec-96eb-0b4e3d1bc251'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Andante con moto (quasi moderato)', part.name_en = 'Esquisses, op. 41: Première Série: V. Andante con moto (quasi moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6f29fa0f-aa08-4db5-a65f-732a3b71b193' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:6f29fa0f-aa08-4db5-a65f-732a3b71b193', 5, NULL, 'Andante con moto (quasi moderato)', 'Esquisses, op. 41: Première Série: V. Andante con moto (quasi moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6f29fa0f-aa08-4db5-a65f-732a3b71b193'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Allegro molto moderato', part.name_en = 'Esquisses, op. 41: Première Série: VI. Allegro molto moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9fa02466-a760-4a94-bf70-92194e2e9f38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9fa02466-a760-4a94-bf70-92194e2e9f38', 6, NULL, 'Allegro molto moderato', 'Esquisses, op. 41: Première Série: VI. Allegro molto moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9fa02466-a760-4a94-bf70-92194e2e9f38'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Adagio', part.name_en = 'Esquisses, op. 41: Première Série: VII. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d02b12fb-2722-4089-b41e-7474afc47458' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:d02b12fb-2722-4089-b41e-7474afc47458', 7, NULL, 'Adagio', 'Esquisses, op. 41: Première Série: VII. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d02b12fb-2722-4089-b41e-7474afc47458'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Moderato tranquillo ma non lento', part.name_en = 'Esquisses, op. 41: Première Série: VIII. Moderato tranquillo ma non lento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e3d02547-d27a-4b69-9592-6e03d7f3a3bc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:e3d02547-d27a-4b69-9592-6e03d7f3a3bc', 8, NULL, 'Moderato tranquillo ma non lento', 'Esquisses, op. 41: Première Série: VIII. Moderato tranquillo ma non lento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3d02547-d27a-4b69-9592-6e03d7f3a3bc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Andante (non troppo lento) presque « moderato »', part.name_en = 'Esquisses, op. 41: Première Série: IX. Andante (non troppo lento) presque « moderato »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7402dd2e-bcf2-41bb-ad82-133468538513' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:7402dd2e-bcf2-41bb-ad82-133468538513', 9, NULL, 'Andante (non troppo lento) presque « moderato »', 'Esquisses, op. 41: Première Série: IX. Andante (non troppo lento) presque « moderato »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7402dd2e-bcf2-41bb-ad82-133468538513'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Andante con moto, quasi moderato', part.name_en = 'Esquisses, op. 41: Première Série: X. Andante con moto, quasi moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:baa67d94-e133-4e7f-8730-1e5b94032b4d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:baa67d94-e133-4e7f-8730-1e5b94032b4d', 10, NULL, 'Andante con moto, quasi moderato', 'Esquisses, op. 41: Première Série: X. Andante con moto, quasi moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:baa67d94-e133-4e7f-8730-1e5b94032b4d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Andante quasi adagio (non troppo)', part.name_en = 'Esquisses, op. 41: Première Série: XI. Andante quasi adagio (non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:525474c4-6b60-4729-a9da-317ab1ef40ed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:525474c4-6b60-4729-a9da-317ab1ef40ed', 11, NULL, 'Andante quasi adagio (non troppo)', 'Esquisses, op. 41: Première Série: XI. Andante quasi adagio (non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:525474c4-6b60-4729-a9da-317ab1ef40ed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Allegretto con molto quasi allegro', part.name_en = 'Esquisses, op. 41: Première Série: XII. Allegretto con molto quasi allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23577 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b2e4ef1d-ee0c-4125-a4cb-1081e0849c10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b2e4ef1d-ee0c-4125-a4cb-1081e0849c10', 12, NULL, 'Allegretto con molto quasi allegro', 'Esquisses, op. 41: Première Série: XII. Allegretto con molto quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:9e3c3a20-dc04-4773-bc37-004274293010'
WHERE p.id = 23577 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b2e4ef1d-ee0c-4125-a4cb-1081e0849c10'
);


-- Op. 180 Fifteen Pieces for Horn and Piano

UPDATE pieces piece
SET piece.title = 'Fifteen Pieces for Horn and Piano', piece.title_en = 'Fifteen Pieces for Horn and Piano, op. 180',
    piece.type = 'song', piece.opus_number = 'Op. 180',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23206 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 157b Fourteen Pieces for Flute and Piano Op. 157b

UPDATE pieces piece
SET piece.title = 'Fourteen Pieces for Flute and Piano Op. 157b', piece.title_en = 'Fourteen Pieces for Flute and Piano, op. 157b',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '157b',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23545 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Vieille chanson. Andante con moto', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 1. Vieille chanson. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:12802963-0893-4f2a-9168-ebb66ce23de4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12802963-0893-4f2a-9168-ebb66ce23de4', 1, NULL, 'Vieille chanson. Andante con moto', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 1. Vieille chanson. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12802963-0893-4f2a-9168-ebb66ce23de4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Gai, assez animé', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 2. Gai, assez animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dde85509-dc33-42e3-b488-d6c1b5dcd866' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dde85509-dc33-42e3-b488-d6c1b5dcd866', 2, NULL, 'Gai, assez animé', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 2. Gai, assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dde85509-dc33-42e3-b488-d6c1b5dcd866'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante espressivo', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 3. Andante espressivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2a227ea0-790a-4bbe-a990-b254847a8896' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2a227ea0-790a-4bbe-a990-b254847a8896', 3, NULL, 'Andante espressivo', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 3. Andante espressivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a227ea0-790a-4bbe-a990-b254847a8896'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Moderato con moto', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 4. Moderato con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dd25b1d8-dade-4b31-89fe-264378249d0e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd25b1d8-dade-4b31-89fe-264378249d0e', 4, NULL, 'Moderato con moto', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 4. Moderato con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd25b1d8-dade-4b31-89fe-264378249d0e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 5. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:25471b90-6b63-4271-bb5c-ed6b4f9c7e1d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:25471b90-6b63-4271-bb5c-ed6b4f9c7e1d', 5, NULL, 'Allegro moderato', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 5. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:25471b90-6b63-4271-bb5c-ed6b4f9c7e1d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 6. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6b8b9801-6f1b-4e41-aee9-b84dce328602' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b8b9801-6f1b-4e41-aee9-b84dce328602', 6, NULL, 'Andante quasi adagio', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 6. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b8b9801-6f1b-4e41-aee9-b84dce328602'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Beau soir. Largo', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 7. Beau soir. Largo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f4b94c4e-b35c-45a0-b79a-b2fa91de4fed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4b94c4e-b35c-45a0-b79a-b2fa91de4fed', 7, NULL, 'Beau soir. Largo', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 7. Beau soir. Largo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4b94c4e-b35c-45a0-b79a-b2fa91de4fed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 8. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:313bfc3f-4b4d-4ffb-9c53-510f07f327e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:313bfc3f-4b4d-4ffb-9c53-510f07f327e8', 8, NULL, 'Andantino', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 8. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:313bfc3f-4b4d-4ffb-9c53-510f07f327e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Allegretto con moto', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 9. Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b1beb833-2fcf-4bf2-8527-7d07938485cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1beb833-2fcf-4bf2-8527-7d07938485cf', 9, NULL, 'Allegretto con moto', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 9. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1beb833-2fcf-4bf2-8527-7d07938485cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Allegretto quasi andantino', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 10. Allegretto quasi andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f236b909-e468-4916-8e14-a520ee09d398' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f236b909-e468-4916-8e14-a520ee09d398', 10, NULL, 'Allegretto quasi andantino', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 10. Allegretto quasi andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f236b909-e468-4916-8e14-a520ee09d398'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 11. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5137a0f1-2381-4845-9269-eeb880f0e983' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5137a0f1-2381-4845-9269-eeb880f0e983', 11, NULL, 'Allegretto', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 11. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5137a0f1-2381-4845-9269-eeb880f0e983'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Danse printanière. Allegretto', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 12. Danse printanière. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fb750509-a270-4957-94e6-df71b5b82886' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb750509-a270-4957-94e6-df71b5b82886', 12, NULL, 'Danse printanière. Allegretto', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 12. Danse printanière. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb750509-a270-4957-94e6-df71b5b82886'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Marche funèbre. Andante', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 13. Marche funèbre. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d9d3c27f-6f7d-4b8c-92be-c7159d219352' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d9d3c27f-6f7d-4b8c-92be-c7159d219352', 13, NULL, 'Marche funèbre. Andante', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 13. Marche funèbre. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d9d3c27f-6f7d-4b8c-92be-c7159d219352'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Allegro moderato', part.name_en = 'Fourteen Pieces for Flute and Piano, op. 157b: No. 14. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23545 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3e74513b-5670-49fa-be0f-a19d3b1884b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e74513b-5670-49fa-be0f-a19d3b1884b3', 14, NULL, 'Allegro moderato', 'Fourteen Pieces for Flute and Piano, op. 157b: No. 14. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23545 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e74513b-5670-49fa-be0f-a19d3b1884b3'
);


-- Op. 204bis Fugue Modale

UPDATE pieces piece
SET piece.title = 'Fugue Modale', piece.title_en = 'Fugue Modale, op. 204bis',
    piece.type = 'song', piece.opus_number = 'Op. 204bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25192 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Fugue, op. 133 II

UPDATE pieces piece
SET piece.title = 'Fugue, op. 133 II', piece.title_en = 'Fugue, op. 133 II',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23755 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 70 호른 소나타

UPDATE pieces piece
SET piece.title = '호른 소나타', piece.title_en = 'Horn Sonata, op. 70',
    piece.type = 'album', piece.opus_number = 'Op. 70',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24292 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato, très simplement et avec souplesse', part.name_en = 'Horn Sonata, op. 70: I. Moderato, très simplement et avec souplesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24292 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0147e626-de69-4712-85df-eb91e1c6ccd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0147e626-de69-4712-85df-eb91e1c6ccd0', 1, 'I', 'Moderato, très simplement et avec souplesse', 'Horn Sonata, op. 70: I. Moderato, très simplement et avec souplesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24292 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0147e626-de69-4712-85df-eb91e1c6ccd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante, très tranquille, presque adagio', part.name_en = 'Horn Sonata, op. 70: II. Andante, très tranquille, presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24292 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5e35b845-a007-4b4a-84d0-97fc3e97fe91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5e35b845-a007-4b4a-84d0-97fc3e97fe91', 2, 'II', 'Andante, très tranquille, presque adagio', 'Horn Sonata, op. 70: II. Andante, très tranquille, presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24292 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5e35b845-a007-4b4a-84d0-97fc3e97fe91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro moderato, assez animé cependant', part.name_en = 'Horn Sonata, op. 70: III. Allegro moderato, assez animé cependant',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24292 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:042dac89-139b-4b83-86ae-cf785ae235d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:042dac89-139b-4b83-86ae-cf785ae235d6', 3, 'III', 'Allegro moderato, assez animé cependant', 'Horn Sonata, op. 70: III. Allegro moderato, assez animé cependant', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24292 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:042dac89-139b-4b83-86ae-cf785ae235d6'
);


-- Op. 155bis Idylle

UPDATE pieces piece
SET piece.title = 'Idylle', piece.title_en = 'Idylle, op. 155bis',
    piece.type = 'song', piece.opus_number = 'Op. 155bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24957 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 16 L'Abbaye, Suite religieuse pour chœur et orgue

UPDATE pieces piece
SET piece.title = 'L''Abbaye, Suite religieuse pour chœur et orgue', piece.title_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16',
    piece.type = 'album', piece.opus_number = 'Op. 16',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24114 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Prélude', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: I. Prélude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6327b677-e727-4b44-be29-104131fdbc91' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6327b677-e727-4b44-be29-104131fdbc91', 1, 'I', 'Prélude', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: I. Prélude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6327b677-e727-4b44-be29-104131fdbc91'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Ave Maria', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: II. Ave Maria',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8831085d-d904-4442-99dd-f372ea473bac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8831085d-d904-4442-99dd-f372ea473bac', 2, 'II', 'Ave Maria', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: II. Ave Maria', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8831085d-d904-4442-99dd-f372ea473bac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Kyrie – Requiem', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: III. Kyrie – Requiem',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4a0d40fe-cd13-494d-a4ae-c4d877a12396' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a0d40fe-cd13-494d-a4ae-c4d877a12396', 3, 'III', 'Kyrie – Requiem', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: III. Kyrie – Requiem', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a0d40fe-cd13-494d-a4ae-c4d877a12396'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Interlude', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: IV. Interlude',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:cccaaba8-2329-4e7e-8761-4a7279834644' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cccaaba8-2329-4e7e-8761-4a7279834644', 4, 'IV', 'Interlude', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: IV. Interlude', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cccaaba8-2329-4e7e-8761-4a7279834644'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Ave Verum', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: V. Ave Verum',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b0c2733c-9585-441d-ac3b-af83c8a4b5f2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0c2733c-9585-441d-ac3b-af83c8a4b5f2', 5, 'V', 'Ave Verum', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: V. Ave Verum', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0c2733c-9585-441d-ac3b-af83c8a4b5f2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'O Salutaris', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: VI. O Salutaris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ed31cd90-88b2-4db6-a220-abcc70839410' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed31cd90-88b2-4db6-a220-abcc70839410', 6, 'VI', 'O Salutaris', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: VI. O Salutaris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed31cd90-88b2-4db6-a220-abcc70839410'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Benedictus', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: VII. Benedictus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3f266fa8-fd1a-4079-b1df-9f4528e3b8d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3f266fa8-fd1a-4079-b1df-9f4528e3b8d0', 7, 'VII', 'Benedictus', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: VII. Benedictus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3f266fa8-fd1a-4079-b1df-9f4528e3b8d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Sanctus', part.name_en = 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: VIII. Sanctus',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24114 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:56a94b8e-0f0d-47c9-a621-f512a5c6e1b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56a94b8e-0f0d-47c9-a621-f512a5c6e1b0', 8, 'VIII', 'Sanctus', 'L''Abbaye, Suite religieuse pour chœur et orgue, op. 16: VIII. Sanctus', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24114 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56a94b8e-0f0d-47c9-a621-f512a5c6e1b0'
);


-- Op. 139 L'Album de Lilian I Op. 139

UPDATE pieces piece
SET piece.title = 'L''Album de Lilian I Op. 139', piece.title_en = 'L''Album de Lilian I, op. 139',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '139',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25804 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'En route vers le hongeur', part.name_en = 'L''Album de Lilian I, op. 139: N° 7. En route vers le hongeur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:17557214-5004-42bf-9144-46eb9c32c8de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17557214-5004-42bf-9144-46eb9c32c8de', 1, NULL, 'En route vers le hongeur', 'L''Album de Lilian I, op. 139: N° 7. En route vers le hongeur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17557214-5004-42bf-9144-46eb9c32c8de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Fugue sans protocole (d''après « Princesse à vos ordres »)', part.name_en = 'L''Album de Lilian I, op. 139: N° 2. Fugue sans protocole (d''après « Princesse à vos ordres »)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2f4f2750-fe8d-40e3-9d4e-0f0371e78012' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2f4f2750-fe8d-40e3-9d4e-0f0371e78012', 2, NULL, 'Fugue sans protocole (d''après « Princesse à vos ordres »)', 'L''Album de Lilian I, op. 139: N° 2. Fugue sans protocole (d''après « Princesse à vos ordres »)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2f4f2750-fe8d-40e3-9d4e-0f0371e78012'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Keep that school girl complexion', part.name_en = 'L''Album de Lilian I, op. 139: N° 1. Keep that school girl complexion',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5d028858-a211-4548-b347-9d8a3b22e7eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d028858-a211-4548-b347-9d8a3b22e7eb', 3, NULL, 'Keep that school girl complexion', 'L''Album de Lilian I, op. 139: N° 1. Keep that school girl complexion', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d028858-a211-4548-b347-9d8a3b22e7eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Valse de la réconciliation (d''après « La Fille et le Garçon »)', part.name_en = 'L''Album de Lilian I, op. 139: N° 3. Valse de la réconciliation (d''après « La Fille et le Garçon »)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6e569e4a-3ea7-4aad-854f-62f02359b381' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e569e4a-3ea7-4aad-854f-62f02359b381', 4, NULL, 'Valse de la réconciliation (d''après « La Fille et le Garçon »)', 'L''Album de Lilian I, op. 139: N° 3. Valse de la réconciliation (d''après « La Fille et le Garçon »)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e569e4a-3ea7-4aad-854f-62f02359b381'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Les Yeux clairs', part.name_en = 'L''Album de Lilian I, op. 139: N° 4. Les Yeux clairs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7fa92df4-f04b-4f81-abff-5398d3d66315' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fa92df4-f04b-4f81-abff-5398d3d66315', 5, NULL, 'Les Yeux clairs', 'L''Album de Lilian I, op. 139: N° 4. Les Yeux clairs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fa92df4-f04b-4f81-abff-5398d3d66315'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Skating-smiling', part.name_en = 'L''Album de Lilian I, op. 139: N° 6. Skating-smiling',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a0d48928-f62d-450b-be36-1c1fb7ac33bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a0d48928-f62d-450b-be36-1c1fb7ac33bf', 6, NULL, 'Skating-smiling', 'L''Album de Lilian I, op. 139: N° 6. Skating-smiling', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a0d48928-f62d-450b-be36-1c1fb7ac33bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Pleurs', part.name_en = 'L''Album de Lilian I, op. 139: N° 8. Pleurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b3492898-98bd-4abe-b1a9-0814ada90d34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3492898-98bd-4abe-b1a9-0814ada90d34', 7, NULL, 'Pleurs', 'L''Album de Lilian I, op. 139: N° 8. Pleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3492898-98bd-4abe-b1a9-0814ada90d34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Tout va bien', part.name_en = 'L''Album de Lilian I, op. 139: N° 9. Tout va bien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e0af9721-d984-4632-bcf1-cc494802d317' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e0af9721-d984-4632-bcf1-cc494802d317', 8, NULL, 'Tout va bien', 'L''Album de Lilian I, op. 139: N° 9. Tout va bien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e0af9721-d984-4632-bcf1-cc494802d317'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Joie de plein air (d''après «Le Chemin du paradis »)', part.name_en = 'L''Album de Lilian I, op. 139: N° 5. Joie de plein air (d''après «Le Chemin du paradis »)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25804 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f0ce1acd-6668-47f3-9fb5-47183fb9afab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f0ce1acd-6668-47f3-9fb5-47183fb9afab', 9, NULL, 'Joie de plein air (d''après «Le Chemin du paradis »)', 'L''Album de Lilian I, op. 139: N° 5. Joie de plein air (d''après «Le Chemin du paradis »)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25804 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f0ce1acd-6668-47f3-9fb5-47183fb9afab'
);


-- Op. 124 L'Ancienne Maison de campagne

UPDATE pieces piece
SET piece.title = 'L''Ancienne Maison de campagne', piece.title_en = 'L''Ancienne Maison de campagne, op. 124',
    piece.type = 'album', piece.opus_number = 'Op. 124',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24795 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'L''Accueil la maison', part.name_en = 'L''Ancienne Maison de campagne, op. 124: I. L''Accueil la maison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1b644ba8-0fb7-452c-8cbc-e717b06f3277' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b644ba8-0fb7-452c-8cbc-e717b06f3277', 1, 'I', 'L''Accueil la maison', 'L''Ancienne Maison de campagne, op. 124: I. L''Accueil la maison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b644ba8-0fb7-452c-8cbc-e717b06f3277'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'D''un vieil album', part.name_en = 'L''Ancienne Maison de campagne, op. 124: II. D''un vieil album',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da', 2, 'II', 'D''un vieil album', 'L''Ancienne Maison de campagne, op. 124: II. D''un vieil album', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Les Fiancés de 1830', part.name_en = 'L''Ancienne Maison de campagne, op. 124: II. D''un vieil album: 1. Les Fiancés de 1830',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4feba256-800b-435e-9d33-0950b85ab9e5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:4feba256-800b-435e-9d33-0950b85ab9e5', 1, NULL, 'Les Fiancés de 1830', 'L''Ancienne Maison de campagne, op. 124: II. D''un vieil album: 1. Les Fiancés de 1830', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da'
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4feba256-800b-435e-9d33-0950b85ab9e5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Reliquein de deuil', part.name_en = 'L''Ancienne Maison de campagne, op. 124: II. D''un vieil album: 2. Reliquein de deuil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ff34ce2a-82e6-468f-9881-3afa8c1c1db5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ff34ce2a-82e6-468f-9881-3afa8c1c1db5', 2, NULL, 'Reliquein de deuil', 'L''Ancienne Maison de campagne, op. 124: II. D''un vieil album: 2. Reliquein de deuil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:4dacc494-de2e-4572-9181-56b9d46a08da'
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff34ce2a-82e6-468f-9881-3afa8c1c1db5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Les Collines, et la vie tranquille', part.name_en = 'L''Ancienne Maison de campagne, op. 124: III. Les Collines, et la vie tranquille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e3b3a57f-c4b2-4304-8f2c-86692d4fe2aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e3b3a57f-c4b2-4304-8f2c-86692d4fe2aa', 3, 'III', 'Les Collines, et la vie tranquille', 'L''Ancienne Maison de campagne, op. 124: III. Les Collines, et la vie tranquille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e3b3a57f-c4b2-4304-8f2c-86692d4fe2aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Leçon de piano', part.name_en = 'L''Ancienne Maison de campagne, op. 124: IV. La Leçon de piano',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f7c6ee73-2679-469c-b0db-005c6461cb02' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7c6ee73-2679-469c-b0db-005c6461cb02', 4, 'IV', 'La Leçon de piano', 'L''Ancienne Maison de campagne, op. 124: IV. La Leçon de piano', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7c6ee73-2679-469c-b0db-005c6461cb02'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'La Terrasse Louis XV', part.name_en = 'L''Ancienne Maison de campagne, op. 124: V. La Terrasse Louis XV',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:eaa99b02-756c-4c83-b05d-67ba75415f6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eaa99b02-756c-4c83-b05d-67ba75415f6c', 5, 'V', 'La Terrasse Louis XV', 'L''Ancienne Maison de campagne, op. 124: V. La Terrasse Louis XV', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eaa99b02-756c-4c83-b05d-67ba75415f6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'La Vieille Fontaine', part.name_en = 'L''Ancienne Maison de campagne, op. 124: VI. La Vieille Fontaine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c52bf42b-6a5e-403d-ad88-c68c3a9adf74' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c52bf42b-6a5e-403d-ad88-c68c3a9adf74', 6, 'VI', 'La Vieille Fontaine', 'L''Ancienne Maison de campagne, op. 124: VI. La Vieille Fontaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c52bf42b-6a5e-403d-ad88-c68c3a9adf74'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Jeux', part.name_en = 'L''Ancienne Maison de campagne, op. 124: VII. Jeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1b965ecd-855e-4a61-b8ef-e7cd27bdd11d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b965ecd-855e-4a61-b8ef-e7cd27bdd11d', 7, 'VII', 'Jeux', 'L''Ancienne Maison de campagne, op. 124: VII. Jeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b965ecd-855e-4a61-b8ef-e7cd27bdd11d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'En ramant, sur le lac', part.name_en = 'L''Ancienne Maison de campagne, op. 124: VIII. En ramant, sur le lac',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0f72a6b2-54da-448e-ab29-ba5d8fe571d6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0f72a6b2-54da-448e-ab29-ba5d8fe571d6', 8, 'VIII', 'En ramant, sur le lac', 'L''Ancienne Maison de campagne, op. 124: VIII. En ramant, sur le lac', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0f72a6b2-54da-448e-ab29-ba5d8fe571d6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Matin dans le bois', part.name_en = 'L''Ancienne Maison de campagne, op. 124: IX. Matin dans le bois',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f1e4c50d-c7bd-49b1-901e-13c48d24b9f0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f1e4c50d-c7bd-49b1-901e-13c48d24b9f0', 9, 'IX', 'Matin dans le bois', 'L''Ancienne Maison de campagne, op. 124: IX. Matin dans le bois', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f1e4c50d-c7bd-49b1-901e-13c48d24b9f0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'La Veille du départ', part.name_en = 'L''Ancienne Maison de campagne, op. 124: X. La Veille du départ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:33e0a332-534f-4c30-9315-6ee60ecf1600' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:33e0a332-534f-4c30-9315-6ee60ecf1600', 10, 'X', 'La Veille du départ', 'L''Ancienne Maison de campagne, op. 124: X. La Veille du départ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:33e0a332-534f-4c30-9315-6ee60ecf1600'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Promenade d''automne', part.name_en = 'L''Ancienne Maison de campagne, op. 124: XI. Promenade d''automne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:06b6e32a-2b78-4810-bd1c-8ae6c445501c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:06b6e32a-2b78-4810-bd1c-8ae6c445501c', 11, 'XI', 'Promenade d''automne', 'L''Ancienne Maison de campagne, op. 124: XI. Promenade d''automne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:06b6e32a-2b78-4810-bd1c-8ae6c445501c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'La Jeunesse vue du seuil de la Vieillesse', part.name_en = 'L''Ancienne Maison de campagne, op. 124: XII. La Jeunesse vue du seuil de la Vieillesse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24795 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:52363c90-648d-4816-8e0d-6f24ec619622' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52363c90-648d-4816-8e0d-6f24ec619622', 12, 'XII', 'La Jeunesse vue du seuil de la Vieillesse', 'L''Ancienne Maison de campagne, op. 124: XII. La Jeunesse vue du seuil de la Vieillesse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24795 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52363c90-648d-4816-8e0d-6f24ec619622'
);


-- Op. 134 L'Andalouse dans Barcelone

UPDATE pieces piece
SET piece.title = 'L''Andalouse dans Barcelone', piece.title_en = 'L''Andalouse dans Barcelone, op. 134',
    piece.type = 'song', piece.opus_number = 'Op. 134',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23458 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 171 Le Buisson ardent

UPDATE pieces piece
SET piece.title = 'Le Buisson ardent', piece.title_en = 'Le Buisson ardent, op. 171',
    piece.type = 'song', piece.opus_number = 'Op. 171',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24565 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 203 Le Buisson ardent Op. 203

UPDATE pieces piece
SET piece.title = 'Le Buisson ardent Op. 203', piece.title_en = 'Le Buisson ardent, op. 203',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '203',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25600 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 202 Le Docteur Fabricius

UPDATE pieces piece
SET piece.title = 'Le Docteur Fabricius', piece.title_en = 'Le Docteur Fabricius, op. 202',
    piece.type = 'album', piece.opus_number = 'Op. 202',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23840 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'V',
    part.name_ko = 'La Nature, la Vie, l’Espoir', part.name_en = 'Le Docteur Fabricius, op. 202: V. La Nature, la Vie, l’Espoir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1222360f-fe23-4c96-ae49-e3a31a46aa3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1222360f-fe23-4c96-ae49-e3a31a46aa3a', 1, 'V', 'La Nature, la Vie, l’Espoir', 'Le Docteur Fabricius, op. 202: V. La Nature, la Vie, l’Espoir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1222360f-fe23-4c96-ae49-e3a31a46aa3a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'VI',
    part.name_ko = 'Réponse de l’homme', part.name_en = 'Le Docteur Fabricius, op. 202: VI. Réponse de l’homme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:705f92a9-71ea-4c4f-b8e4-4f8778e38ef6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:705f92a9-71ea-4c4f-b8e4-4f8778e38ef6', 2, 'VI', 'Réponse de l’homme', 'Le Docteur Fabricius, op. 202: VI. Réponse de l’homme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:705f92a9-71ea-4c4f-b8e4-4f8778e38ef6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Le Manoir', part.name_en = 'Le Docteur Fabricius, op. 202: I. Le Manoir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:87d5d88b-af2c-494e-bd8d-fef5a59d9a47' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:87d5d88b-af2c-494e-bd8d-fef5a59d9a47', 3, 'I', 'Le Manoir', 'Le Docteur Fabricius, op. 202: I. Le Manoir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:87d5d88b-af2c-494e-bd8d-fef5a59d9a47'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'II',
    part.name_ko = 'La Douleur', part.name_en = 'Le Docteur Fabricius, op. 202: II. La Douleur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:90a58010-1657-4ad2-8de0-2723ebecfd86' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90a58010-1657-4ad2-8de0-2723ebecfd86', 4, 'II', 'La Douleur', 'Le Docteur Fabricius, op. 202: II. La Douleur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90a58010-1657-4ad2-8de0-2723ebecfd86'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'VIII',
    part.name_ko = 'Choral final', part.name_en = 'Le Docteur Fabricius, op. 202: VIII. Choral final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:93a13353-ae3e-45d6-a7b8-6c9a38486e39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93a13353-ae3e-45d6-a7b8-6c9a38486e39', 5, 'VIII', 'Choral final', 'Le Docteur Fabricius, op. 202: VIII. Choral final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93a13353-ae3e-45d6-a7b8-6c9a38486e39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'IV',
    part.name_ko = 'Le Ciel étoilé', part.name_en = 'Le Docteur Fabricius, op. 202: IV. Le Ciel étoilé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d08d15c5-156c-47db-b626-8f60b6a52183' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d08d15c5-156c-47db-b626-8f60b6a52183', 6, 'IV', 'Le Ciel étoilé', 'Le Docteur Fabricius, op. 202: IV. Le Ciel étoilé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d08d15c5-156c-47db-b626-8f60b6a52183'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'III',
    part.name_ko = 'La Révolte', part.name_en = 'Le Docteur Fabricius, op. 202: III. La Révolte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ece652f6-3757-4a0e-9e94-f7679d55b52e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ece652f6-3757-4a0e-9e94-f7679d55b52e', 7, 'III', 'La Révolte', 'Le Docteur Fabricius, op. 202: III. La Révolte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ece652f6-3757-4a0e-9e94-f7679d55b52e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VII',
    part.name_ko = 'La Joie', part.name_en = 'Le Docteur Fabricius, op. 202: VII. La Joie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23840 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f8de3daa-4b93-4482-a495-b37bf950f95a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8de3daa-4b93-4482-a495-b37bf950f95a', 8, 'VII', 'La Joie', 'Le Docteur Fabricius, op. 202: VII. La Joie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23840 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8de3daa-4b93-4482-a495-b37bf950f95a'
);


-- Op. 140 Le Portrait de Daisy Hamilton Op. 140

UPDATE pieces piece
SET piece.title = 'Le Portrait de Daisy Hamilton Op. 140', piece.title_en = 'Le Portrait de Daisy Hamilton, op. 140',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '140',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24189 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Volume 3 (Sept pièces pour deux pianos)', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 3 (Sept pièces pour deux pianos)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12', 1, NULL, 'Volume 3 (Sept pièces pour deux pianos)', 'Le Portrait de Daisy Hamilton, op. 140: Volume 3 (Sept pièces pour deux pianos)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Canon humoriste. Allegretto vivo', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: 54. Canon humoriste. Allegretto vivo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:53c9908a-ea9e-4e05-9660-aedcbae03fb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:53c9908a-ea9e-4e05-9660-aedcbae03fb4', 1, NULL, 'Canon humoriste. Allegretto vivo', 'Le Portrait de Daisy Hamilton, op. 140: 54. Canon humoriste. Allegretto vivo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53c9908a-ea9e-4e05-9660-aedcbae03fb4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'A Venise. Andante quasi adagio', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: 59. A Venise. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5417e178-8153-4136-8110-04df8cb663c3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5417e178-8153-4136-8110-04df8cb663c3', 2, NULL, 'A Venise. Andante quasi adagio', 'Le Portrait de Daisy Hamilton, op. 140: 59. A Venise. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5417e178-8153-4136-8110-04df8cb663c3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Course. Allegro vivace', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: 15. La Course. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:81ab46da-9117-483a-99f6-2c6f54c63cff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:81ab46da-9117-483a-99f6-2c6f54c63cff', 3, NULL, 'La Course. Allegro vivace', 'Le Portrait de Daisy Hamilton, op. 140: 15. La Course. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ab46da-9117-483a-99f6-2c6f54c63cff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Autour du bonhomme de neige. Léger et gai', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: 42. Autour du bonhomme de neige. Léger et gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:cdae2869-8439-426c-b082-597c528243d0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:cdae2869-8439-426c-b082-597c528243d0', 4, NULL, 'Autour du bonhomme de neige. Léger et gai', 'Le Portrait de Daisy Hamilton, op. 140: 42. Autour du bonhomme de neige. Léger et gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cdae2869-8439-426c-b082-597c528243d0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'En auto. Vite', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: 27. En auto. Vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ea0aa699-3772-4022-a984-caa0dd5a57e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ea0aa699-3772-4022-a984-caa0dd5a57e0', 5, NULL, 'En auto. Vite', 'Le Portrait de Daisy Hamilton, op. 140: 27. En auto. Vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:799c3d0f-7767-44fa-a2f1-9d76fd433d12'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea0aa699-3772-4022-a984-caa0dd5a57e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Volume 5 (Huit pièces pour clarinette et piano)', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1', 2, NULL, 'Volume 5 (Huit pièces pour clarinette et piano)', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Gaiement, sur la route, au soleil (d''après « Le Chemin du Paradis »)', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): I. Gaiement, sur la route, au soleil (d''après « Le Chemin du Paradis »)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3fddbe3d-91f9-49a1-a080-1ba670f4f2fa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:3fddbe3d-91f9-49a1-a080-1ba670f4f2fa', 1, NULL, 'Gaiement, sur la route, au soleil (d''après « Le Chemin du Paradis »)', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): I. Gaiement, sur la route, au soleil (d''après « Le Chemin du Paradis »)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3fddbe3d-91f9-49a1-a080-1ba670f4f2fa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Romance (pour Marie-Christine, en revenant de « Princesse à vos ordres »)', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): II. Romance (pour Marie-Christine, en revenant de « Princesse à vos ordres »)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:232fbb73-ed35-43e8-b09e-9217024954d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:232fbb73-ed35-43e8-b09e-9217024954d7', 2, NULL, 'Romance (pour Marie-Christine, en revenant de « Princesse à vos ordres »)', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): II. Romance (pour Marie-Christine, en revenant de « Princesse à vos ordres »)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:232fbb73-ed35-43e8-b09e-9217024954d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Chant de la mer', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): III. Le Chant de la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:372c2a7c-fa74-4051-a1ec-16af04497a9d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:372c2a7c-fa74-4051-a1ec-16af04497a9d', 3, NULL, 'Le Chant de la mer', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): III. Le Chant de la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:372c2a7c-fa74-4051-a1ec-16af04497a9d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Grâce insoucieuse', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): IV. Grâce insoucieuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a3764cfd-5387-4e27-a765-eefbdb3cab33' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3764cfd-5387-4e27-a765-eefbdb3cab33', 4, NULL, 'Grâce insoucieuse', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): IV. Grâce insoucieuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3764cfd-5387-4e27-a765-eefbdb3cab33'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Autre Danse', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): V. Autre Danse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:90ca7903-adf4-469f-bd43-afb1b262b555' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:90ca7903-adf4-469f-bd43-afb1b262b555', 5, NULL, 'Autre Danse', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): V. Autre Danse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90ca7903-adf4-469f-bd43-afb1b262b555'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Marche dans les sentiers de ta nuit', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): VI. Marche dans les sentiers de ta nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:aaa110b4-657b-4c04-98ff-783b194b205d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:aaa110b4-657b-4c04-98ff-783b194b205d', 6, NULL, 'Marche dans les sentiers de ta nuit', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): VI. Marche dans les sentiers de ta nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aaa110b4-657b-4c04-98ff-783b194b205d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Berceuse nocturne', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): VII. Berceuse nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2ce858df-1e9c-474b-9b70-44cf3d82dd1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2ce858df-1e9c-474b-9b70-44cf3d82dd1b', 7, NULL, 'Berceuse nocturne', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): VII. Berceuse nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ce858df-1e9c-474b-9b70-44cf3d82dd1b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '« Je veux »', part.name_en = 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): VIII. « Je veux »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24189 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:652b33e2-458b-42bf-baa4-ff35dd46526c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:652b33e2-458b-42bf-baa4-ff35dd46526c', 8, NULL, '« Je veux »', 'Le Portrait de Daisy Hamilton, op. 140: Volume 5 (Huit pièces pour clarinette et piano): VIII. « Je veux »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:ed224a18-c6d3-4128-ab61-4b368b2464d1'
WHERE p.id = 24189 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:652b33e2-458b-42bf-baa4-ff35dd46526c'
);


-- Op. 216 Le Repos de Tityre

UPDATE pieces piece
SET piece.title = 'Le Repos de Tityre', piece.title_en = 'Le Repos de Tityre, op. 216',
    piece.type = 'song', piece.opus_number = 'Op. 216',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24447 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 198 Les Chants de Nectaire, 1ère série Op. 198

UPDATE pieces piece
SET piece.title = 'Les Chants de Nectaire, 1ère série Op. 198', piece.title_en = 'Les Chants de Nectaire, 1ère série, op. 198',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '198',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23590 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '"Le Désir qui crée les Mondes"', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : "Le Désir qui crée les Mondes"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:09f0fcd6-9f02-4fdb-94b9-0bfad741bf79' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09f0fcd6-9f02-4fdb-94b9-0bfad741bf79', 1, NULL, '"Le Désir qui crée les Mondes"', 'Les Chants de Nectaire, 1ère série, op. 198 : "Le Désir qui crée les Mondes"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09f0fcd6-9f02-4fdb-94b9-0bfad741bf79'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Préambule', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Préambule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:15dd6a29-478e-482d-9e70-72c54bbeede4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15dd6a29-478e-482d-9e70-72c54bbeede4', 2, NULL, 'Préambule', 'Les Chants de Nectaire, 1ère série, op. 198 : Préambule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15dd6a29-478e-482d-9e70-72c54bbeede4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Crainte', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : La Crainte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2c5e7d4d-7561-4bd6-a2c0-c030400e8aac' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c5e7d4d-7561-4bd6-a2c0-c030400e8aac', 3, NULL, 'La Crainte', 'Les Chants de Nectaire, 1ère série, op. 198 : La Crainte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c5e7d4d-7561-4bd6-a2c0-c030400e8aac'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Souffles du Printemps sur la mer', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Souffles du Printemps sur la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2c6d3482-5abc-4eeb-9867-8a0408882637' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2c6d3482-5abc-4eeb-9867-8a0408882637', 4, NULL, 'Souffles du Printemps sur la mer', 'Les Chants de Nectaire, 1ère série, op. 198 : Souffles du Printemps sur la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2c6d3482-5abc-4eeb-9867-8a0408882637'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'La Pitié', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : La Pitié',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2e837650-9de7-471a-807e-ff4ddd17b4c8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2e837650-9de7-471a-807e-ff4ddd17b4c8', 5, NULL, 'La Pitié', 'Les Chants de Nectaire, 1ère série, op. 198 : La Pitié', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2e837650-9de7-471a-807e-ff4ddd17b4c8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le Rire vainqueur', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Le Rire vainqueur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:390f90f6-8d18-4857-b5b9-e20cd51348d3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:390f90f6-8d18-4857-b5b9-e20cd51348d3', 6, NULL, 'Le Rire vainqueur', 'Les Chants de Nectaire, 1ère série, op. 198 : Le Rire vainqueur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:390f90f6-8d18-4857-b5b9-e20cd51348d3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Jeux de la lumière', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Jeux de la lumière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:438b83d5-0480-411c-971d-7197183004ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:438b83d5-0480-411c-971d-7197183004ec', 7, NULL, 'Jeux de la lumière', 'Les Chants de Nectaire, 1ère série, op. 198 : Jeux de la lumière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:438b83d5-0480-411c-971d-7197183004ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Méditation sur la douleur humaine', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Méditation sur la douleur humaine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4d9a7245-eb53-4a22-8b74-13365dc24f8a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d9a7245-eb53-4a22-8b74-13365dc24f8a', 8, NULL, 'Méditation sur la douleur humaine', 'Les Chants de Nectaire, 1ère série, op. 198 : Méditation sur la douleur humaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d9a7245-eb53-4a22-8b74-13365dc24f8a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Le Calme du Sage', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Le Calme du Sage',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4e1b8379-217a-4311-b4dd-b71c2b1e06fc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e1b8379-217a-4311-b4dd-b71c2b1e06fc', 9, NULL, 'Le Calme du Sage', 'Les Chants de Nectaire, 1ère série, op. 198 : Le Calme du Sage', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e1b8379-217a-4311-b4dd-b71c2b1e06fc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Le Jardin des Muses', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Le Jardin des Muses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:51ae4d22-1b5c-4251-b85e-f9a062a4fc27' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51ae4d22-1b5c-4251-b85e-f9a062a4fc27', 10, NULL, 'Le Jardin des Muses', 'Les Chants de Nectaire, 1ère série, op. 198 : Le Jardin des Muses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51ae4d22-1b5c-4251-b85e-f9a062a4fc27'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'La Plainte humaine', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : La Plainte humaine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:51c1f0fd-7115-4eef-8a13-8daa9d96e58b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51c1f0fd-7115-4eef-8a13-8daa9d96e58b', 11, NULL, 'La Plainte humaine', 'Les Chants de Nectaire, 1ère série, op. 198 : La Plainte humaine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51c1f0fd-7115-4eef-8a13-8daa9d96e58b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'L''Amour', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : L''Amour',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5f312a9f-cf6a-4a0f-ace3-8e92c441aeed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5f312a9f-cf6a-4a0f-ace3-8e92c441aeed', 12, NULL, 'L''Amour', 'Les Chants de Nectaire, 1ère série, op. 198 : L''Amour', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5f312a9f-cf6a-4a0f-ace3-8e92c441aeed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Les tranquilles clartés de l''intelligence', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Les tranquilles clartés de l''intelligence',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6e53a0c6-beb8-4d1a-a62f-ac0c0310147d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e53a0c6-beb8-4d1a-a62f-ac0c0310147d', 13, NULL, 'Les tranquilles clartés de l''intelligence', 'Les Chants de Nectaire, 1ère série, op. 198 : Les tranquilles clartés de l''intelligence', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e53a0c6-beb8-4d1a-a62f-ac0c0310147d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Naissance de la vie', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Naissance de la vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6eefa044-47aa-4786-b3e4-8ca00c19e539' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6eefa044-47aa-4786-b3e4-8ca00c19e539', 14, NULL, 'Naissance de la vie', 'Les Chants de Nectaire, 1ère série, op. 198 : Naissance de la vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6eefa044-47aa-4786-b3e4-8ca00c19e539'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Gaîté de la lumière', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Gaîté de la lumière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:92072d08-18be-4850-801b-b39cbe23e641' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:92072d08-18be-4850-801b-b39cbe23e641', 15, NULL, 'Gaîté de la lumière', 'Les Chants de Nectaire, 1ère série, op. 198 : Gaîté de la lumière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:92072d08-18be-4850-801b-b39cbe23e641'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'L''Effort de l''Homme', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : L''Effort de l''Homme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:97d66697-c576-48fa-89b6-c6c78b82261a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:97d66697-c576-48fa-89b6-c6c78b82261a', 16, NULL, 'L''Effort de l''Homme', 'Les Chants de Nectaire, 1ère série, op. 198 : L''Effort de l''Homme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:97d66697-c576-48fa-89b6-c6c78b82261a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Le Soir', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Le Soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9a052cb6-30b5-4b18-8590-2874dea5dba5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a052cb6-30b5-4b18-8590-2874dea5dba5', 17, NULL, 'Le Soir', 'Les Chants de Nectaire, 1ère série, op. 198 : Le Soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a052cb6-30b5-4b18-8590-2874dea5dba5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Pour les âmes souffrantes', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Pour les âmes souffrantes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9dbe31d6-504a-478d-9582-74adf1a77055' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dbe31d6-504a-478d-9582-74adf1a77055', 18, NULL, 'Pour les âmes souffrantes', 'Les Chants de Nectaire, 1ère série, op. 198 : Pour les âmes souffrantes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dbe31d6-504a-478d-9582-74adf1a77055'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Idylle', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Idylle',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9df31e3a-fca5-46ed-b343-9d0fe37c75da' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9df31e3a-fca5-46ed-b343-9d0fe37c75da', 19, NULL, 'Idylle', 'Les Chants de Nectaire, 1ère série, op. 198 : Idylle', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9df31e3a-fca5-46ed-b343-9d0fe37c75da'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Le Vaincu médite', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Le Vaincu médite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a110ba70-4991-4c89-a75e-c1410eb70898' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a110ba70-4991-4c89-a75e-c1410eb70898', 20, NULL, 'Le Vaincu médite', 'Les Chants de Nectaire, 1ère série, op. 198 : Le Vaincu médite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a110ba70-4991-4c89-a75e-c1410eb70898'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Lumière; modération; équillibre', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Lumière; modération; équillibre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a7a6703e-a0d8-40fb-9136-d1a0b8185c2c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a7a6703e-a0d8-40fb-9136-d1a0b8185c2c', 21, NULL, 'Lumière; modération; équillibre', 'Les Chants de Nectaire, 1ère série, op. 198 : Lumière; modération; équillibre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a7a6703e-a0d8-40fb-9136-d1a0b8185c2c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Clarté de l''Esprit', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Clarté de l''Esprit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:aa1a563f-3303-419b-9ea2-009beef2123d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa1a563f-3303-419b-9ea2-009beef2123d', 22, NULL, 'Clarté de l''Esprit', 'Les Chants de Nectaire, 1ère série, op. 198 : Clarté de l''Esprit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa1a563f-3303-419b-9ea2-009beef2123d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'L''Elan vers la vie', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : L''Elan vers la vie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bc6d9d6e-9b1a-4579-b6ea-fd1dc66617d5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bc6d9d6e-9b1a-4579-b6ea-fd1dc66617d5', 23, NULL, 'L''Elan vers la vie', 'Les Chants de Nectaire, 1ère série, op. 198 : L''Elan vers la vie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bc6d9d6e-9b1a-4579-b6ea-fd1dc66617d5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Les Vrilles de la Vigne', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Les Vrilles de la Vigne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c213e48d-b5cf-40f1-848c-172508a190de' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c213e48d-b5cf-40f1-848c-172508a190de', 24, NULL, 'Les Vrilles de la Vigne', 'Les Chants de Nectaire, 1ère série, op. 198 : Les Vrilles de la Vigne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c213e48d-b5cf-40f1-848c-172508a190de'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Jeunesse du monde', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Jeunesse du monde',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:cc845e5b-311a-4a44-8900-160475dfe634' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc845e5b-311a-4a44-8900-160475dfe634', 25, NULL, 'Jeunesse du monde', 'Les Chants de Nectaire, 1ère série, op. 198 : Jeunesse du monde', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc845e5b-311a-4a44-8900-160475dfe634'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'La Tendresse', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : La Tendresse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:cde8af4c-45c7-41ff-b424-df22ac8a58c9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cde8af4c-45c7-41ff-b424-df22ac8a58c9', 26, NULL, 'La Tendresse', 'Les Chants de Nectaire, 1ère série, op. 198 : La Tendresse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cde8af4c-45c7-41ff-b424-df22ac8a58c9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Les vaines querelles ("à quoi bon?")', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Les vaines querelles ("à quoi bon?")',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d0979e8c-ed4d-4988-a21e-6714338f45fb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0979e8c-ed4d-4988-a21e-6714338f45fb', 27, NULL, 'Les vaines querelles ("à quoi bon?")', 'Les Chants de Nectaire, 1ère série, op. 198 : Les vaines querelles ("à quoi bon?")', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0979e8c-ed4d-4988-a21e-6714338f45fb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Les Heures douces', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Les Heures douces',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d43777cb-b2c2-401a-8d32-3761bdd78263' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d43777cb-b2c2-401a-8d32-3761bdd78263', 28, NULL, 'Les Heures douces', 'Les Chants de Nectaire, 1ère série, op. 198 : Les Heures douces', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d43777cb-b2c2-401a-8d32-3761bdd78263'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Gaîté du matin ensoleillé', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Gaîté du matin ensoleillé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d58c2a36-1663-4be1-818c-f97494872618' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d58c2a36-1663-4be1-818c-f97494872618', 29, NULL, 'Gaîté du matin ensoleillé', 'Les Chants de Nectaire, 1ère série, op. 198 : Gaîté du matin ensoleillé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d58c2a36-1663-4be1-818c-f97494872618'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'criblent de flèches l''Erreur et la Bêtise', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : criblent de flèches l''Erreur et la Bêtise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:eabd5b73-4947-4587-b4a3-178eee4e0d3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eabd5b73-4947-4587-b4a3-178eee4e0d3e', 30, NULL, 'criblent de flèches l''Erreur et la Bêtise', 'Les Chants de Nectaire, 1ère série, op. 198 : criblent de flèches l''Erreur et la Bêtise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eabd5b73-4947-4587-b4a3-178eee4e0d3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Clair de lune sur la mer', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : Clair de lune sur la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f8d3d9be-339d-4917-8dad-6b4ced2a2cad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8d3d9be-339d-4917-8dad-6b4ced2a2cad', 31, NULL, 'Clair de lune sur la mer', 'Les Chants de Nectaire, 1ère série, op. 198 : Clair de lune sur la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8d3d9be-339d-4917-8dad-6b4ced2a2cad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'La Nuit', part.name_en = 'Les Chants de Nectaire, 1ère série, op. 198 : La Nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23590 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fa06ab56-1cd9-4d60-b11f-8c72a58123b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa06ab56-1cd9-4d60-b11f-8c72a58123b9', 32, NULL, 'La Nuit', 'Les Chants de Nectaire, 1ère série, op. 198 : La Nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23590 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa06ab56-1cd9-4d60-b11f-8c72a58123b9'
);


-- Op. 199 Les Chants de Nectaire, 2e série Op. 199

UPDATE pieces piece
SET piece.title = 'Les Chants de Nectaire, 2e série Op. 199', piece.title_en = 'Les Chants de Nectaire, 2e série, op. 199',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '199',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24862 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'La claire forêt', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : La claire forêt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0ebb374c-7840-4538-b841-83c223514f77' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0ebb374c-7840-4538-b841-83c223514f77', 1, NULL, 'La claire forêt', 'Les Chants de Nectaire, 2e série, op. 199 : La claire forêt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0ebb374c-7840-4538-b841-83c223514f77'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Pour le cortège de Dionysos', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Pour le cortège de Dionysos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:111370ad-12e3-430d-9a9b-d4132619ac1c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:111370ad-12e3-430d-9a9b-d4132619ac1c', 2, NULL, 'Pour le cortège de Dionysos', 'Les Chants de Nectaire, 2e série, op. 199 : Pour le cortège de Dionysos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:111370ad-12e3-430d-9a9b-d4132619ac1c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Brise fraîche du matin sur la mer', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Brise fraîche du matin sur la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:13fcd416-251c-47da-b3a5-6471f3b58a3f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:13fcd416-251c-47da-b3a5-6471f3b58a3f', 3, NULL, 'Brise fraîche du matin sur la mer', 'Les Chants de Nectaire, 2e série, op. 199 : Brise fraîche du matin sur la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:13fcd416-251c-47da-b3a5-6471f3b58a3f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Endymion, berger', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Endymion, berger',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:15900b88-bd07-4110-a2fd-50707556496c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:15900b88-bd07-4110-a2fd-50707556496c', 4, NULL, 'Endymion, berger', 'Les Chants de Nectaire, 2e série, op. 199 : Endymion, berger', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:15900b88-bd07-4110-a2fd-50707556496c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Danses dans la forêt', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Danses dans la forêt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1b334d4c-9d62-4cae-b526-24f063d1923f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1b334d4c-9d62-4cae-b526-24f063d1923f', 5, NULL, 'Danses dans la forêt', 'Les Chants de Nectaire, 2e série, op. 199 : Danses dans la forêt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1b334d4c-9d62-4cae-b526-24f063d1923f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Le Satyre', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Le Satyre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2ec6e485-5b12-469e-a48d-5ce8f74c3a37' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2ec6e485-5b12-469e-a48d-5ce8f74c3a37', 6, NULL, 'Le Satyre', 'Les Chants de Nectaire, 2e série, op. 199 : Le Satyre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2ec6e485-5b12-469e-a48d-5ce8f74c3a37'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'La mer aux bruits innombrables', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : La mer aux bruits innombrables',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:38fde2b5-b8a9-48a3-a841-f2eb9091de94' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:38fde2b5-b8a9-48a3-a841-f2eb9091de94', 7, NULL, 'La mer aux bruits innombrables', 'Les Chants de Nectaire, 2e série, op. 199 : La mer aux bruits innombrables', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:38fde2b5-b8a9-48a3-a841-f2eb9091de94'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Le Bois Sacré', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Le Bois Sacré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4cbb53e5-b456-4d86-ac53-8e24eea59d61' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4cbb53e5-b456-4d86-ac53-8e24eea59d61', 8, NULL, 'Le Bois Sacré', 'Les Chants de Nectaire, 2e série, op. 199 : Le Bois Sacré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4cbb53e5-b456-4d86-ac53-8e24eea59d61'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Gaîté du Printemps dans la Forêt', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Gaîté du Printemps dans la Forêt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:51082b8d-99c2-415e-abbc-2a005672137d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:51082b8d-99c2-415e-abbc-2a005672137d', 9, NULL, 'Gaîté du Printemps dans la Forêt', 'Les Chants de Nectaire, 2e série, op. 199 : Gaîté du Printemps dans la Forêt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:51082b8d-99c2-415e-abbc-2a005672137d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Soir lumineux', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Soir lumineux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5c3e1b76-3899-45b5-b00e-ef8ea0b45d62' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5c3e1b76-3899-45b5-b00e-ef8ea0b45d62', 10, NULL, 'Soir lumineux', 'Les Chants de Nectaire, 2e série, op. 199 : Soir lumineux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5c3e1b76-3899-45b5-b00e-ef8ea0b45d62'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Pureté du matin sur la grève', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Pureté du matin sur la grève',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:723feae4-0882-43cd-9dd7-1a412cb31e63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:723feae4-0882-43cd-9dd7-1a412cb31e63', 11, NULL, 'Pureté du matin sur la grève', 'Les Chants de Nectaire, 2e série, op. 199 : Pureté du matin sur la grève', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:723feae4-0882-43cd-9dd7-1a412cb31e63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '"Les oiseaux sont ivres..."', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "Les oiseaux sont ivres..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:73cbc880-d940-4276-9ad4-5784502895cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:73cbc880-d940-4276-9ad4-5784502895cb', 12, NULL, '"Les oiseaux sont ivres..."', 'Les Chants de Nectaire, 2e série, op. 199 : "Les oiseaux sont ivres..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:73cbc880-d940-4276-9ad4-5784502895cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Boire à l''ombre, en été', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Boire à l''ombre, en été',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:75a3e023-350e-4529-ba64-1e65c60a07ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:75a3e023-350e-4529-ba64-1e65c60a07ef', 13, NULL, 'Boire à l''ombre, en été', 'Les Chants de Nectaire, 2e série, op. 199 : Boire à l''ombre, en été', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:75a3e023-350e-4529-ba64-1e65c60a07ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = '"O fortunatos niminum...agricolas"', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "O fortunatos niminum...agricolas"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7f94ae6a-ecc6-49ab-b02a-5fb1ecc614d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f94ae6a-ecc6-49ab-b02a-5fb1ecc614d4', 14, NULL, '"O fortunatos niminum...agricolas"', 'Les Chants de Nectaire, 2e série, op. 199 : "O fortunatos niminum...agricolas"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f94ae6a-ecc6-49ab-b02a-5fb1ecc614d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = '"Tityre, Tu patulae recbans sub tegmine fagi"', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "Tityre, Tu patulae recbans sub tegmine fagi"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8104a7b6-7e68-49c6-9b00-42624abf13eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8104a7b6-7e68-49c6-9b00-42624abf13eb', 15, NULL, '"Tityre, Tu patulae recbans sub tegmine fagi"', 'Les Chants de Nectaire, 2e série, op. 199 : "Tityre, Tu patulae recbans sub tegmine fagi"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8104a7b6-7e68-49c6-9b00-42624abf13eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Jeux dans la clairière', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Jeux dans la clairière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:827358fe-ca62-4b02-b946-22681005f068' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:827358fe-ca62-4b02-b946-22681005f068', 16, NULL, 'Jeux dans la clairière', 'Les Chants de Nectaire, 2e série, op. 199 : Jeux dans la clairière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:827358fe-ca62-4b02-b946-22681005f068'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Calme du soir', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Calme du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8b59ed84-e262-4b37-a9c0-f45b99ef734d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8b59ed84-e262-4b37-a9c0-f45b99ef734d', 17, NULL, 'Calme du soir', 'Les Chants de Nectaire, 2e série, op. 199 : Calme du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8b59ed84-e262-4b37-a9c0-f45b99ef734d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Silène', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Silène',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:940ffebd-6411-4006-8105-ab69c9b5b1ab' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:940ffebd-6411-4006-8105-ab69c9b5b1ab', 18, NULL, 'Silène', 'Les Chants de Nectaire, 2e série, op. 199 : Silène', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:940ffebd-6411-4006-8105-ab69c9b5b1ab'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Le Bruissement des feuilles', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Le Bruissement des feuilles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9c41ce2c-a01b-402f-8188-1e7397d7a227' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9c41ce2c-a01b-402f-8188-1e7397d7a227', 19, NULL, 'Le Bruissement des feuilles', 'Les Chants de Nectaire, 2e série, op. 199 : Le Bruissement des feuilles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9c41ce2c-a01b-402f-8188-1e7397d7a227'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = '"Majoresque cadunt altis de montibus umbrae"', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "Majoresque cadunt altis de montibus umbrae"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9dab04c3-bb18-4e1c-a54b-2232438aaa92' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9dab04c3-bb18-4e1c-a54b-2232438aaa92', 20, NULL, '"Majoresque cadunt altis de montibus umbrae"', 'Les Chants de Nectaire, 2e série, op. 199 : "Majoresque cadunt altis de montibus umbrae"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9dab04c3-bb18-4e1c-a54b-2232438aaa92'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Danse de nymphes, au soleil', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Danse de nymphes, au soleil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a60fba10-9f59-42a7-8bdb-3a8983055076' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a60fba10-9f59-42a7-8bdb-3a8983055076', 21, NULL, 'Danse de nymphes, au soleil', 'Les Chants de Nectaire, 2e série, op. 199 : Danse de nymphes, au soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a60fba10-9f59-42a7-8bdb-3a8983055076'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Fraîcheur des beaux matins de la montagne', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Fraîcheur des beaux matins de la montagne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:af7b0c9f-6e63-4b55-b60a-e2cc7cb218b1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af7b0c9f-6e63-4b55-b60a-e2cc7cb218b1', 22, NULL, 'Fraîcheur des beaux matins de la montagne', 'Les Chants de Nectaire, 2e série, op. 199 : Fraîcheur des beaux matins de la montagne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af7b0c9f-6e63-4b55-b60a-e2cc7cb218b1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Jeux de Naïades', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Jeux de Naïades',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b0736779-cdbe-41e0-8dfd-d9288f52fd7e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0736779-cdbe-41e0-8dfd-d9288f52fd7e', 23, NULL, 'Jeux de Naïades', 'Les Chants de Nectaire, 2e série, op. 199 : Jeux de Naïades', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0736779-cdbe-41e0-8dfd-d9288f52fd7e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'L'' "Heuruex petit berger"', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : L'' "Heuruex petit berger"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b5eb02ac-169a-4b63-b156-2a09cee59a5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b5eb02ac-169a-4b63-b156-2a09cee59a5c', 24, NULL, 'L'' "Heuruex petit berger"', 'Les Chants de Nectaire, 2e série, op. 199 : L'' "Heuruex petit berger"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b5eb02ac-169a-4b63-b156-2a09cee59a5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = '"Formosi pecoris custos, formosior ipse"', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "Formosi pecoris custos, formosior ipse"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c03421d8-9402-4fa8-a8cd-2b972f365e07' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c03421d8-9402-4fa8-a8cd-2b972f365e07', 25, NULL, '"Formosi pecoris custos, formosior ipse"', 'Les Chants de Nectaire, 2e série, op. 199 : "Formosi pecoris custos, formosior ipse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c03421d8-9402-4fa8-a8cd-2b972f365e07'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = '"Mollesque sub arbore somni..."', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "Mollesque sub arbore somni..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:da19c107-8bac-407b-96a1-6dd2a4ed9bde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:da19c107-8bac-407b-96a1-6dd2a4ed9bde', 26, NULL, '"Mollesque sub arbore somni..."', 'Les Chants de Nectaire, 2e série, op. 199 : "Mollesque sub arbore somni..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:da19c107-8bac-407b-96a1-6dd2a4ed9bde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Danse des Faunes', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Danse des Faunes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e8417bc3-c64a-4143-aafb-bdfa12b5f2ec' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8417bc3-c64a-4143-aafb-bdfa12b5f2ec', 27, NULL, 'Danse des Faunes', 'Les Chants de Nectaire, 2e série, op. 199 : Danse des Faunes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8417bc3-c64a-4143-aafb-bdfa12b5f2ec'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = '"At secura quies..."', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : "At secura quies..."',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f4ea7f50-04fe-47c1-8053-d7612d189abe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4ea7f50-04fe-47c1-8053-d7612d189abe', 28, NULL, '"At secura quies..."', 'Les Chants de Nectaire, 2e série, op. 199 : "At secura quies..."', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4ea7f50-04fe-47c1-8053-d7612d189abe'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = 'Le Chevrier', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Le Chevrier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f8a87ba1-a076-4650-b84a-cfa3ffd69f19' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f8a87ba1-a076-4650-b84a-cfa3ffd69f19', 29, NULL, 'Le Chevrier', 'Les Chants de Nectaire, 2e série, op. 199 : Le Chevrier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f8a87ba1-a076-4650-b84a-cfa3ffd69f19'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Caprice du Faune', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Caprice du Faune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fbbafeb8-db76-4d39-9cc2-17625898bf34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fbbafeb8-db76-4d39-9cc2-17625898bf34', 30, NULL, 'Caprice du Faune', 'Les Chants de Nectaire, 2e série, op. 199 : Caprice du Faune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fbbafeb8-db76-4d39-9cc2-17625898bf34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Sur la mort d''un chat', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : Sur la mort d''un chat',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fda8a904-b8c2-4e72-a17e-bd350045f808' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fda8a904-b8c2-4e72-a17e-bd350045f808', 31, NULL, 'Sur la mort d''un chat', 'Les Chants de Nectaire, 2e série, op. 199 : Sur la mort d''un chat', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fda8a904-b8c2-4e72-a17e-bd350045f808'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'A l''ombre, par une fraîche matinée de printemps', part.name_en = 'Les Chants de Nectaire, 2e série, op. 199 : A l''ombre, par une fraîche matinée de printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24862 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ffd8c2b3-10f3-4c2c-bee6-923020c6eced' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ffd8c2b3-10f3-4c2c-bee6-923020c6eced', 32, NULL, 'A l''ombre, par une fraîche matinée de printemps', 'Les Chants de Nectaire, 2e série, op. 199 : A l''ombre, par une fraîche matinée de printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24862 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ffd8c2b3-10f3-4c2c-bee6-923020c6eced'
);


-- Op. 200 Les Chants de Nectaire, 3e série Op. 200

UPDATE pieces piece
SET piece.title = 'Les Chants de Nectaire, 3e série Op. 200', piece.title_en = 'Les Chants de Nectaire, 3e série, op. 200',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '200',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25089 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Tityre remercie les Dieux', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Tityre remercie les Dieux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1e2964aa-85ff-4c6d-a392-03ac07e825dd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1e2964aa-85ff-4c6d-a392-03ac07e825dd', 1, NULL, 'Tityre remercie les Dieux', 'Les Chants de Nectaire, 3e série, op. 200 : Tityre remercie les Dieux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1e2964aa-85ff-4c6d-a392-03ac07e825dd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Prière aux Sages de la Forêt', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière aux Sages de la Forêt',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2385bef9-e7a0-4f36-b56a-641ff7329791' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2385bef9-e7a0-4f36-b56a-641ff7329791', 2, NULL, 'Prière aux Sages de la Forêt', 'Les Chants de Nectaire, 3e série, op. 200 : Prière aux Sages de la Forêt', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2385bef9-e7a0-4f36-b56a-641ff7329791'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prière de l''épouse dont le mari est parti à la guerre', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière de l''épouse dont le mari est parti à la guerre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2856e6f7-78b4-4f30-8734-280336710f80' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2856e6f7-78b4-4f30-8734-280336710f80', 3, NULL, 'Prière de l''épouse dont le mari est parti à la guerre', 'Les Chants de Nectaire, 3e série, op. 200 : Prière de l''épouse dont le mari est parti à la guerre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2856e6f7-78b4-4f30-8734-280336710f80'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Danses des Faunes familiers', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Danses des Faunes familiers',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:312cdca3-dfbe-4c43-83d4-0e1284ce8319' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:312cdca3-dfbe-4c43-83d4-0e1284ce8319', 4, NULL, 'Danses des Faunes familiers', 'Les Chants de Nectaire, 3e série, op. 200 : Danses des Faunes familiers', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:312cdca3-dfbe-4c43-83d4-0e1284ce8319'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Hymne du philosophe devant la nuit d''étoiles', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Hymne du philosophe devant la nuit d''étoiles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:42cc806d-dfb4-47c9-8486-b96f56640ac9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:42cc806d-dfb4-47c9-8486-b96f56640ac9', 5, NULL, 'Hymne du philosophe devant la nuit d''étoiles', 'Les Chants de Nectaire, 3e série, op. 200 : Hymne du philosophe devant la nuit d''étoiles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42cc806d-dfb4-47c9-8486-b96f56640ac9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Danses d''adolescents devant la maison herueuse', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Danses d''adolescents devant la maison herueuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:430996f2-9b0b-4be0-9511-63db166bb18c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:430996f2-9b0b-4be0-9511-63db166bb18c', 6, NULL, 'Danses d''adolescents devant la maison herueuse', 'Les Chants de Nectaire, 3e série, op. 200 : Danses d''adolescents devant la maison herueuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:430996f2-9b0b-4be0-9511-63db166bb18c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Epithalames', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Epithalames',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:57b98c6a-9a7b-4d6a-817b-115ed8e97c9c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:57b98c6a-9a7b-4d6a-817b-115ed8e97c9c', 7, NULL, 'Epithalames', 'Les Chants de Nectaire, 3e série, op. 200 : Epithalames', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:57b98c6a-9a7b-4d6a-817b-115ed8e97c9c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = 'Le Maître enseigne à ses élèves la vie harmonieuse des Sages antiques : 3e série, op. 200', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Le Maître enseigne à ses élèves la vie harmonieuse des Sages antiques : 3e série, op. 200',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5872e948-8051-4419-8064-87c94cb2e32f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5872e948-8051-4419-8064-87c94cb2e32f', 8, NULL, 'Le Maître enseigne à ses élèves la vie harmonieuse des Sages antiques : 3e série, op. 200', 'Les Chants de Nectaire, 3e série, op. 200 : Le Maître enseigne à ses élèves la vie harmonieuse des Sages antiques : 3e série, op. 200', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5872e948-8051-4419-8064-87c94cb2e32f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = 'Autre prière pour la guérison', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Autre prière pour la guérison',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6a2eaca2-9310-4906-977e-6cdfa1de7877' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6a2eaca2-9310-4906-977e-6cdfa1de7877', 9, NULL, 'Autre prière pour la guérison', 'Les Chants de Nectaire, 3e série, op. 200 : Autre prière pour la guérison', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6a2eaca2-9310-4906-977e-6cdfa1de7877'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = 'Danses pour saluer le retour du printemps', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Danses pour saluer le retour du printemps',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:711ec544-79be-48ac-9b57-0a9554914125' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:711ec544-79be-48ac-9b57-0a9554914125', 10, NULL, 'Danses pour saluer le retour du printemps', 'Les Chants de Nectaire, 3e série, op. 200 : Danses pour saluer le retour du printemps', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:711ec544-79be-48ac-9b57-0a9554914125'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = 'Danse pour célébrer le retour du Père', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Danse pour célébrer le retour du Père',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:74a9e95a-a9fc-40c9-8afb-0799fdcb49a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74a9e95a-a9fc-40c9-8afb-0799fdcb49a4', 11, NULL, 'Danse pour célébrer le retour du Père', 'Les Chants de Nectaire, 3e série, op. 200 : Danse pour célébrer le retour du Père', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74a9e95a-a9fc-40c9-8afb-0799fdcb49a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = 'Ronde joyeuse dans les prés fleuris', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Ronde joyeuse dans les prés fleuris',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:84426eb4-e2d3-436b-8f39-5f9a44e50132' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:84426eb4-e2d3-436b-8f39-5f9a44e50132', 12, NULL, 'Ronde joyeuse dans les prés fleuris', 'Les Chants de Nectaire, 3e série, op. 200 : Ronde joyeuse dans les prés fleuris', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:84426eb4-e2d3-436b-8f39-5f9a44e50132'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = NULL,
    part.name_ko = 'Prière d''un malade', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière d''un malade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:88a1e3af-294a-4f77-bfc7-66fad6039bde' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88a1e3af-294a-4f77-bfc7-66fad6039bde', 13, NULL, 'Prière d''un malade', 'Les Chants de Nectaire, 3e série, op. 200 : Prière d''un malade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88a1e3af-294a-4f77-bfc7-66fad6039bde'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = NULL,
    part.name_ko = 'Prière des enfants', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière des enfants',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:91341eed-ec71-4fc7-80ea-4c58a720095d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91341eed-ec71-4fc7-80ea-4c58a720095d', 14, NULL, 'Prière des enfants', 'Les Chants de Nectaire, 3e série, op. 200 : Prière des enfants', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91341eed-ec71-4fc7-80ea-4c58a720095d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = NULL,
    part.name_ko = 'Danses pour célébrer d''heureuses fiancailles', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Danses pour célébrer d''heureuses fiancailles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:916155df-edae-41cf-9c8e-253d61a95f96' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:916155df-edae-41cf-9c8e-253d61a95f96', 15, NULL, 'Danses pour célébrer d''heureuses fiancailles', 'Les Chants de Nectaire, 3e série, op. 200 : Danses pour célébrer d''heureuses fiancailles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:916155df-edae-41cf-9c8e-253d61a95f96'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = NULL,
    part.name_ko = 'Cortège d''éphèbes', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Cortège d''éphèbes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9e61495f-8c7e-4204-93a8-695c03cf1f72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e61495f-8c7e-4204-93a8-695c03cf1f72', 16, NULL, 'Cortège d''éphèbes', 'Les Chants de Nectaire, 3e série, op. 200 : Cortège d''éphèbes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e61495f-8c7e-4204-93a8-695c03cf1f72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = NULL,
    part.name_ko = 'Prière aux dieux protecteurs du foyer', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière aux dieux protecteurs du foyer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9e6ebd3c-c549-4a86-9627-d6602cfd5897' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9e6ebd3c-c549-4a86-9627-d6602cfd5897', 17, NULL, 'Prière aux dieux protecteurs du foyer', 'Les Chants de Nectaire, 3e série, op. 200 : Prière aux dieux protecteurs du foyer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9e6ebd3c-c549-4a86-9627-d6602cfd5897'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = NULL,
    part.name_ko = 'Autre prière de l''aïeule', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Autre prière de l''aïeule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9ffb83e9-9e2f-495a-995e-78fc446a56f1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ffb83e9-9e2f-495a-995e-78fc446a56f1', 18, NULL, 'Autre prière de l''aïeule', 'Les Chants de Nectaire, 3e série, op. 200 : Autre prière de l''aïeule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ffb83e9-9e2f-495a-995e-78fc446a56f1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 19, part.movement_number = NULL,
    part.name_ko = 'Réponse à la divinité tutélaire', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Réponse à la divinité tutélaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a300a403-3728-4a03-9f3c-ce5272f3dccb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a300a403-3728-4a03-9f3c-ce5272f3dccb', 19, NULL, 'Réponse à la divinité tutélaire', 'Les Chants de Nectaire, 3e série, op. 200 : Réponse à la divinité tutélaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a300a403-3728-4a03-9f3c-ce5272f3dccb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 20, part.movement_number = NULL,
    part.name_ko = 'Cortège', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Cortège',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a41b8525-3531-4c11-988a-7d7ac179281b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a41b8525-3531-4c11-988a-7d7ac179281b', 20, NULL, 'Cortège', 'Les Chants de Nectaire, 3e série, op. 200 : Cortège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a41b8525-3531-4c11-988a-7d7ac179281b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 21, part.movement_number = NULL,
    part.name_ko = 'Incantation pour écarter les mauvais esprits', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Incantation pour écarter les mauvais esprits',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ae196b71-28ca-497f-a52f-a348dbdb4a53' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ae196b71-28ca-497f-a52f-a348dbdb4a53', 21, NULL, 'Incantation pour écarter les mauvais esprits', 'Les Chants de Nectaire, 3e série, op. 200 : Incantation pour écarter les mauvais esprits', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ae196b71-28ca-497f-a52f-a348dbdb4a53'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 22, part.movement_number = NULL,
    part.name_ko = 'Prière des orphelins', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière des orphelins',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bd59450d-d141-46c8-844c-c8199a1fea99' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bd59450d-d141-46c8-844c-c8199a1fea99', 22, NULL, 'Prière des orphelins', 'Les Chants de Nectaire, 3e série, op. 200 : Prière des orphelins', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bd59450d-d141-46c8-844c-c8199a1fea99'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 23, part.movement_number = NULL,
    part.name_ko = 'Cortège de jeunes filles', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Cortège de jeunes filles',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c12b0854-ed86-4772-80f6-b23115bcd739' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c12b0854-ed86-4772-80f6-b23115bcd739', 23, NULL, 'Cortège de jeunes filles', 'Les Chants de Nectaire, 3e série, op. 200 : Cortège de jeunes filles', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c12b0854-ed86-4772-80f6-b23115bcd739'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 24, part.movement_number = NULL,
    part.name_ko = 'Incantation pour guérir un cerveau malade', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Incantation pour guérir un cerveau malade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c6eba890-0c12-443f-b9ec-eaef3adec6a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c6eba890-0c12-443f-b9ec-eaef3adec6a8', 24, NULL, 'Incantation pour guérir un cerveau malade', 'Les Chants de Nectaire, 3e série, op. 200 : Incantation pour guérir un cerveau malade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c6eba890-0c12-443f-b9ec-eaef3adec6a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 25, part.movement_number = NULL,
    part.name_ko = 'Prière funéraire', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière funéraire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c71153c0-3f30-4c06-8610-d80c11e1595d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c71153c0-3f30-4c06-8610-d80c11e1595d', 25, NULL, 'Prière funéraire', 'Les Chants de Nectaire, 3e série, op. 200 : Prière funéraire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c71153c0-3f30-4c06-8610-d80c11e1595d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 26, part.movement_number = NULL,
    part.name_ko = 'Cortège d'' "actions de grâce"', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Cortège d'' "actions de grâce"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c77ce9a1-e9bb-4eea-934c-c0fbf5bcafa4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c77ce9a1-e9bb-4eea-934c-c0fbf5bcafa4', 26, NULL, 'Cortège d'' "actions de grâce"', 'Les Chants de Nectaire, 3e série, op. 200 : Cortège d'' "actions de grâce"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c77ce9a1-e9bb-4eea-934c-c0fbf5bcafa4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 27, part.movement_number = NULL,
    part.name_ko = 'Prière pour guérir un malade', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière pour guérir un malade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dcced592-c073-4412-a224-71aff9528f6f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcced592-c073-4412-a224-71aff9528f6f', 27, NULL, 'Prière pour guérir un malade', 'Les Chants de Nectaire, 3e série, op. 200 : Prière pour guérir un malade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcced592-c073-4412-a224-71aff9528f6f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 28, part.movement_number = NULL,
    part.name_ko = 'Prière dans le mode dorien', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière dans le mode dorien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e07e93b4-855f-42ff-b43f-d451542f89b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e07e93b4-855f-42ff-b43f-d451542f89b2', 28, NULL, 'Prière dans le mode dorien', 'Les Chants de Nectaire, 3e série, op. 200 : Prière dans le mode dorien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e07e93b4-855f-42ff-b43f-d451542f89b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 29, part.movement_number = NULL,
    part.name_ko = '"Danse"', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : "Danse"',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e22bc161-b3ee-4497-9e0f-20cdf4d7b6a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e22bc161-b3ee-4497-9e0f-20cdf4d7b6a8', 29, NULL, '"Danse"', 'Les Chants de Nectaire, 3e série, op. 200 : "Danse"', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e22bc161-b3ee-4497-9e0f-20cdf4d7b6a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 30, part.movement_number = NULL,
    part.name_ko = 'Cortège', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Cortège',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e7c8ac2c-c580-4c04-8bc6-9f628a26a44f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e7c8ac2c-c580-4c04-8bc6-9f628a26a44f', 30, NULL, 'Cortège', 'Les Chants de Nectaire, 3e série, op. 200 : Cortège', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e7c8ac2c-c580-4c04-8bc6-9f628a26a44f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 31, part.movement_number = NULL,
    part.name_ko = 'Prière de l''aïeule', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Prière de l''aïeule',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f2605689-bb8d-46f4-8bcb-9689c5a20002' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f2605689-bb8d-46f4-8bcb-9689c5a20002', 31, NULL, 'Prière de l''aïeule', 'Les Chants de Nectaire, 3e série, op. 200 : Prière de l''aïeule', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f2605689-bb8d-46f4-8bcb-9689c5a20002'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 32, part.movement_number = NULL,
    part.name_ko = 'Danse au soleil du matin dans la campagne', part.name_en = 'Les Chants de Nectaire, 3e série, op. 200 : Danse au soleil du matin dans la campagne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25089 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fb6312b0-2e82-4ad9-97f8-5a0e257935ba' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fb6312b0-2e82-4ad9-97f8-5a0e257935ba', 32, NULL, 'Danse au soleil du matin dans la campagne', 'Les Chants de Nectaire, 3e série, op. 200 : Danse au soleil du matin dans la campagne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25089 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fb6312b0-2e82-4ad9-97f8-5a0e257935ba'
);


-- Op. 9 Les Clairs de lune

UPDATE pieces piece
SET piece.title = 'Les Clairs de lune', piece.title_en = 'Les Clairs de lune, op. 9',
    piece.type = 'song', piece.opus_number = 'Op. 9',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23376 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 141 Les Confidences d'un joueur de clarinette

UPDATE pieces piece
SET piece.title = 'Les Confidences d''un joueur de clarinette', piece.title_en = 'Les Confidences d''un joueur de clarinette, op. 141',
    piece.type = 'album', piece.opus_number = 'Op. 141',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24435 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Romance de Kasper', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: I. Romance de Kasper',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:af16ff88-5746-43f1-9503-c33cffee343f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af16ff88-5746-43f1-9503-c33cffee343f', 1, 'I', 'Romance de Kasper', 'Les Confidences d''un joueur de clarinette, op. 141: I. Romance de Kasper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af16ff88-5746-43f1-9503-c33cffee343f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Aubade des vendanges', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: II. Aubade des vendanges',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e1fb4352-9b14-4813-b233-4976f5b6047a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1fb4352-9b14-4813-b233-4976f5b6047a', 2, 'II', 'Aubade des vendanges', 'Les Confidences d''un joueur de clarinette, op. 141: II. Aubade des vendanges', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1fb4352-9b14-4813-b233-4976f5b6047a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le Bouquet de fleurs des champs pour Magrédel', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: III. Le Bouquet de fleurs des champs pour Magrédel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5de6ced8-77e3-4914-9c25-81f77d2f8d2a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5de6ced8-77e3-4914-9c25-81f77d2f8d2a', 3, 'III', 'Le Bouquet de fleurs des champs pour Magrédel', 'Les Confidences d''un joueur de clarinette, op. 141: III. Le Bouquet de fleurs des champs pour Magrédel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5de6ced8-77e3-4914-9c25-81f77d2f8d2a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Pastrole', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: IV. Pastrole',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:aa8e6c5f-124d-4aba-a068-45e587f9e90b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aa8e6c5f-124d-4aba-a068-45e587f9e90b', 4, 'IV', 'Pastrole', 'Les Confidences d''un joueur de clarinette, op. 141: IV. Pastrole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aa8e6c5f-124d-4aba-a068-45e587f9e90b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Musique de Kasper et de Waldhorn pendant le dîner chez l''oncle Stavolo', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: V. Musique de Kasper et de Waldhorn pendant le dîner chez l''oncle Stavolo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4a23cb86-9701-43f6-97e7-03d974860122' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4a23cb86-9701-43f6-97e7-03d974860122', 5, 'V', 'Musique de Kasper et de Waldhorn pendant le dîner chez l''oncle Stavolo', 'Les Confidences d''un joueur de clarinette, op. 141: V. Musique de Kasper et de Waldhorn pendant le dîner chez l''oncle Stavolo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4a23cb86-9701-43f6-97e7-03d974860122'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Marche familière (Ouverture du bal)', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: VI. Marche familière (Ouverture du bal)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6bfb013c-287a-40af-8daa-d20179b88214' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bfb013c-287a-40af-8daa-d20179b88214', 6, 'VI', 'Marche familière (Ouverture du bal)', 'Les Confidences d''un joueur de clarinette, op. 141: VI. Marche familière (Ouverture du bal)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bfb013c-287a-40af-8daa-d20179b88214'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Valse rustique pour le bal à la fête d''Eckerswir', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: VII. Valse rustique pour le bal à la fête d''Eckerswir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c8921e3e-0cec-43c3-9bd7-d2d3989489ce' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c8921e3e-0cec-43c3-9bd7-d2d3989489ce', 7, 'VII', 'Valse rustique pour le bal à la fête d''Eckerswir', 'Les Confidences d''un joueur de clarinette, op. 141: VII. Valse rustique pour le bal à la fête d''Eckerswir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c8921e3e-0cec-43c3-9bd7-d2d3989489ce'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Rage de Kasper', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: VIII. Rage de Kasper',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d28a2716-bd12-463b-931c-7a661d34d885' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d28a2716-bd12-463b-931c-7a661d34d885', 8, 'VIII', 'Rage de Kasper', 'Les Confidences d''un joueur de clarinette, op. 141: VIII. Rage de Kasper', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d28a2716-bd12-463b-931c-7a661d34d885'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Lamento', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: IX. Lamento',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:69447e5a-839a-4320-99cc-1794fcbb33ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:69447e5a-839a-4320-99cc-1794fcbb33ef', 9, 'IX', 'Lamento', 'Les Confidences d''un joueur de clarinette, op. 141: IX. Lamento', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:69447e5a-839a-4320-99cc-1794fcbb33ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Duo final du « Printemps qui revient »', part.name_en = 'Les Confidences d''un joueur de clarinette, op. 141: X. Duo final du « Printemps qui revient »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24435 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:363b89e7-26f7-4a3f-a254-a007910f5bb4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:363b89e7-26f7-4a3f-a254-a007910f5bb4', 10, 'X', 'Duo final du « Printemps qui revient »', 'Les Confidences d''un joueur de clarinette, op. 141: X. Duo final du « Printemps qui revient »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24435 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:363b89e7-26f7-4a3f-a254-a007910f5bb4'
);


-- Op. 65 Les Heures persanes

UPDATE pieces piece
SET piece.title = 'Les Heures persanes', piece.title_en = 'Les Heures persanes, op. 65',
    piece.type = 'album', piece.opus_number = 'Op. 65',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25813 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sieste, avant le départ', part.name_en = 'Les Heures persanes, op. 65: I. Sieste, avant le départ',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ea4a729f-0ed1-40d8-9c14-4d98c64e784e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea4a729f-0ed1-40d8-9c14-4d98c64e784e', 1, 'I', 'Sieste, avant le départ', 'Les Heures persanes, op. 65: I. Sieste, avant le départ', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea4a729f-0ed1-40d8-9c14-4d98c64e784e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'La Caravanne (rêve, pendant la sieste)', part.name_en = 'Les Heures persanes, op. 65: II. La Caravanne (rêve, pendant la sieste)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fd5fc4e1-834e-4d9d-a210-420892988755' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fd5fc4e1-834e-4d9d-a210-420892988755', 2, 'II', 'La Caravanne (rêve, pendant la sieste)', 'Les Heures persanes, op. 65: II. La Caravanne (rêve, pendant la sieste)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fd5fc4e1-834e-4d9d-a210-420892988755'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'L''Escalade obscure', part.name_en = 'Les Heures persanes, op. 65: III. L''Escalade obscure',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:32e7d2fc-48d9-42b6-aba5-5bc583e1cb3e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:32e7d2fc-48d9-42b6-aba5-5bc583e1cb3e', 3, 'III', 'L''Escalade obscure', 'Les Heures persanes, op. 65: III. L''Escalade obscure', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:32e7d2fc-48d9-42b6-aba5-5bc583e1cb3e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Matin frais dans la haute vallée', part.name_en = 'Les Heures persanes, op. 65: IV. Matin frais dans la haute vallée',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5ecdd36a-e227-4888-82c6-32aca30d5222' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5ecdd36a-e227-4888-82c6-32aca30d5222', 4, 'IV', 'Matin frais dans la haute vallée', 'Les Heures persanes, op. 65: IV. Matin frais dans la haute vallée', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ecdd36a-e227-4888-82c6-32aca30d5222'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'En vue de la ville', part.name_en = 'Les Heures persanes, op. 65: V. En vue de la ville',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1cf3fca1-79e0-4bb5-a003-d251024e34df' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1cf3fca1-79e0-4bb5-a003-d251024e34df', 5, 'V', 'En vue de la ville', 'Les Heures persanes, op. 65: V. En vue de la ville', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1cf3fca1-79e0-4bb5-a003-d251024e34df'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'À travers les rues', part.name_en = 'Les Heures persanes, op. 65: VI. À travers les rues',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ddfa8625-cfb2-4f45-91ce-768ccf0e28ae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ddfa8625-cfb2-4f45-91ce-768ccf0e28ae', 6, 'VI', 'À travers les rues', 'Les Heures persanes, op. 65: VI. À travers les rues', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ddfa8625-cfb2-4f45-91ce-768ccf0e28ae'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Chant du soir', part.name_en = 'Les Heures persanes, op. 65: VII. Chant du soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7690e779-4905-47a9-8b5f-31bf2f7201d7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7690e779-4905-47a9-8b5f-31bf2f7201d7', 7, 'VII', 'Chant du soir', 'Les Heures persanes, op. 65: VII. Chant du soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7690e779-4905-47a9-8b5f-31bf2f7201d7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Clair de lune sur les terrasses', part.name_en = 'Les Heures persanes, op. 65: VIII. Clair de lune sur les terrasses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:122e8527-9d49-4b45-a9d0-081829b2116f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:122e8527-9d49-4b45-a9d0-081829b2116f', 8, 'VIII', 'Clair de lune sur les terrasses', 'Les Heures persanes, op. 65: VIII. Clair de lune sur les terrasses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:122e8527-9d49-4b45-a9d0-081829b2116f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Aubade', part.name_en = 'Les Heures persanes, op. 65: IX. Aubade',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c828c049-22e4-4180-ab2f-e7363c723ca5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c828c049-22e4-4180-ab2f-e7363c723ca5', 9, 'IX', 'Aubade', 'Les Heures persanes, op. 65: IX. Aubade', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c828c049-22e4-4180-ab2f-e7363c723ca5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Roses au soleil de midi', part.name_en = 'Les Heures persanes, op. 65: X. Roses au soleil de midi',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6b1f3738-49e4-46dc-a898-76743700f116' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6b1f3738-49e4-46dc-a898-76743700f116', 10, 'X', 'Roses au soleil de midi', 'Les Heures persanes, op. 65: X. Roses au soleil de midi', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6b1f3738-49e4-46dc-a898-76743700f116'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'À l''ombre, près de la fontaine de marbre', part.name_en = 'Les Heures persanes, op. 65: XI. À l''ombre, près de la fontaine de marbre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:66382a49-8c79-44d5-b4f7-fa9c828ff3aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:66382a49-8c79-44d5-b4f7-fa9c828ff3aa', 11, 'XI', 'À l''ombre, près de la fontaine de marbre', 'Les Heures persanes, op. 65: XI. À l''ombre, près de la fontaine de marbre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:66382a49-8c79-44d5-b4f7-fa9c828ff3aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Arabesques', part.name_en = 'Les Heures persanes, op. 65: XII. Arabesques',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6bd132da-8de2-4a4c-b249-c45ba119bb5c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6bd132da-8de2-4a4c-b249-c45ba119bb5c', 12, 'XII', 'Arabesques', 'Les Heures persanes, op. 65: XII. Arabesques', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6bd132da-8de2-4a4c-b249-c45ba119bb5c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Les Collines, au coucher du soleil', part.name_en = 'Les Heures persanes, op. 65: XIII. Les Collines, au coucher du soleil',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c517d127-2d22-4563-b619-bd81dceaf79b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c517d127-2d22-4563-b619-bd81dceaf79b', 13, 'XIII', 'Les Collines, au coucher du soleil', 'Les Heures persanes, op. 65: XIII. Les Collines, au coucher du soleil', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c517d127-2d22-4563-b619-bd81dceaf79b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Le Conteur (Le Pêcheur et le Genni - Le Palais enchanté - Danse d''adolescents - Clair de lune sur les jardins)', part.name_en = 'Les Heures persanes, op. 65: XIV. Le Conteur (Le Pêcheur et le Genni - Le Palais enchanté - Danse d''adolescents - Clair de lune sur les jardins)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f5af3bac-168a-4b7a-8b90-e002d2411e67' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f5af3bac-168a-4b7a-8b90-e002d2411e67', 14, 'XIV', 'Le Conteur (Le Pêcheur et le Genni - Le Palais enchanté - Danse d''adolescents - Clair de lune sur les jardins)', 'Les Heures persanes, op. 65: XIV. Le Conteur (Le Pêcheur et le Genni - Le Palais enchanté - Danse d''adolescents - Clair de lune sur les jardins)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f5af3bac-168a-4b7a-8b90-e002d2411e67'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'XV',
    part.name_ko = 'La Paix du soir au cimetière', part.name_en = 'Les Heures persanes, op. 65: XV. La Paix du soir au cimetière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:09e3f6f3-468c-4198-bace-1a5ebcdcdbf6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:09e3f6f3-468c-4198-bace-1a5ebcdcdbf6', 15, 'XV', 'La Paix du soir au cimetière', 'Les Heures persanes, op. 65: XV. La Paix du soir au cimetière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09e3f6f3-468c-4198-bace-1a5ebcdcdbf6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'XVI',
    part.name_ko = 'Derviches dans la nuit - Clair de lune sur la place déserte', part.name_en = 'Les Heures persanes, op. 65: XVI. Derviches dans la nuit - Clair de lune sur la place déserte',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25813 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2bab4a29-c373-4d2b-80fd-e47c88c8e8a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2bab4a29-c373-4d2b-80fd-e47c88c8e8a8', 16, 'XVI', 'Derviches dans la nuit - Clair de lune sur la place déserte', 'Les Heures persanes, op. 65: XVI. Derviches dans la nuit - Clair de lune sur la place déserte', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25813 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2bab4a29-c373-4d2b-80fd-e47c88c8e8a8'
);


-- Op. 197 Les chants de Kervéléan pour trompette et petit orchestre

UPDATE pieces piece
SET piece.title = 'Les chants de Kervéléan pour trompette et petit orchestre', piece.title_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197',
    piece.type = 'album', piece.opus_number = 'Op. 197',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23277 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Invocation. Andante. Expressif et solide', part.name_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 1, Invocation. Andante. Expressif et solide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23277 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6cbb7b19-35df-4b94-b4a1-64e1f052ada3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6cbb7b19-35df-4b94-b4a1-64e1f052ada3', 1, NULL, 'Invocation. Andante. Expressif et solide', 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 1, Invocation. Andante. Expressif et solide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23277 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6cbb7b19-35df-4b94-b4a1-64e1f052ada3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le calme et la splendeur de la nature. Andante presque', part.name_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 2, Le calme et la splendeur de la nature. Andante presque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23277 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:35dd07c0-dfda-41c6-b72e-cbe3a0295c1f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:35dd07c0-dfda-41c6-b72e-cbe3a0295c1f', 2, NULL, 'Le calme et la splendeur de la nature. Andante presque', 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 2, Le calme et la splendeur de la nature. Andante presque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23277 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:35dd07c0-dfda-41c6-b72e-cbe3a0295c1f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante très calme, presque adagio', part.name_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 3, Andante très calme, presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23277 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:79ae84cb-ac92-40a0-bb9c-a8a242894380' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:79ae84cb-ac92-40a0-bb9c-a8a242894380', 3, NULL, 'Andante très calme, presque adagio', 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 3, Andante très calme, presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23277 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:79ae84cb-ac92-40a0-bb9c-a8a242894380'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andantino', part.name_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 4, Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23277 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:218432d2-9743-434c-bdde-7da7d1a0e210' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:218432d2-9743-434c-bdde-7da7d1a0e210', 4, NULL, 'Andantino', 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 4, Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23277 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:218432d2-9743-434c-bdde-7da7d1a0e210'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Adagio (non troppo)', part.name_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 5, Adagio (non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23277 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3b5e9fbb-4787-4c0f-bb34-4f3e35acd0e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b5e9fbb-4787-4c0f-bb34-4f3e35acd0e0', 5, NULL, 'Adagio (non troppo)', 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 5, Adagio (non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23277 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b5e9fbb-4787-4c0f-bb34-4f3e35acd0e0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Adagio. Large et de plus en plus sonore', part.name_en = 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 6, Adagio. Large et de plus en plus sonore',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23277 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8f4bcf0a-3b55-47bd-a048-0c42653e56a1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8f4bcf0a-3b55-47bd-a048-0c42653e56a1', 6, NULL, 'Adagio. Large et de plus en plus sonore', 'Les chants de Kervéléan pour trompette et petit orchestre, op. 197: No. 6, Adagio. Large et de plus en plus sonore', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23277 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8f4bcf0a-3b55-47bd-a048-0c42653e56a1'
);


-- Op. 216 Monodies pour clarinette solo

UPDATE pieces piece
SET piece.title = 'Monodies pour clarinette solo', piece.title_en = 'Monodies pour clarinette solo, op. 216',
    piece.type = 'album', piece.opus_number = 'Op. 216',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25348 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Le Faune', part.name_en = 'Monodies pour clarinette solo, op. 216: I. Le Faune',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25348 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:80506322-3f9b-40b9-9f47-6ee85151a9a4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80506322-3f9b-40b9-9f47-6ee85151a9a4', 1, 'I', 'Le Faune', 'Monodies pour clarinette solo, op. 216: I. Le Faune', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25348 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80506322-3f9b-40b9-9f47-6ee85151a9a4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Le Soir', part.name_en = 'Monodies pour clarinette solo, op. 216: II. Le Soir',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25348 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d5b92ca5-b341-47d0-a943-4cb8bbb9e20d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5b92ca5-b341-47d0-a943-4cb8bbb9e20d', 2, 'II', 'Le Soir', 'Monodies pour clarinette solo, op. 216: II. Le Soir', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25348 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5b92ca5-b341-47d0-a943-4cb8bbb9e20d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Mer aux bruits innombrables', part.name_en = 'Monodies pour clarinette solo, op. 216: III. La Mer aux bruits innombrables',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25348 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5573f0bc-376c-4376-a507-3b19f8c3825f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5573f0bc-376c-4376-a507-3b19f8c3825f', 3, 'III', 'La Mer aux bruits innombrables', 'Monodies pour clarinette solo, op. 216: III. La Mer aux bruits innombrables', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25348 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5573f0bc-376c-4376-a507-3b19f8c3825f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'La Chasse d''Artémis', part.name_en = 'Monodies pour clarinette solo, op. 216: IV. La Chasse d''Artémis',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25348 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8e88b353-36a7-437a-bb11-e49490f96335' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8e88b353-36a7-437a-bb11-e49490f96335', 4, 'IV', 'La Chasse d''Artémis', 'Monodies pour clarinette solo, op. 216: IV. La Chasse d''Artémis', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25348 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8e88b353-36a7-437a-bb11-e49490f96335'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Le Repos de Tityre', part.name_en = 'Monodies pour clarinette solo, op. 216: V. Le Repos de Tityre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25348 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e6827f8a-74f2-4306-b2b3-653f385035b0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6827f8a-74f2-4306-b2b3-653f385035b0', 5, 'V', 'Le Repos de Tityre', 'Monodies pour clarinette solo, op. 216: V. Le Repos de Tityre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25348 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6827f8a-74f2-4306-b2b3-653f385035b0'
);


-- Op. 33 Nocturne chromatique

UPDATE pieces piece
SET piece.title = 'Nocturne chromatique', piece.title_en = 'Nocturne chromatique, op. 33',
    piece.type = 'song', piece.opus_number = 'Op. 33',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24220 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 98b Offertoire écrit pour le mariage de Renée Philippart

UPDATE pieces piece
SET piece.title = 'Offertoire écrit pour le mariage de Renée Philippart', piece.title_en = 'Offertoire écrit pour le mariage de Renée Philippart, op. 98b',
    piece.type = 'song', piece.opus_number = 'Op. 98b',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24668 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 187 Offrande musicale sur le nom de BACH

UPDATE pieces piece
SET piece.title = 'Offrande musicale sur le nom de BACH', piece.title_en = 'Offrande musicale sur le nom de BACH, op. 187',
    piece.type = 'album', piece.opus_number = 'Op. 187',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25651 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Choral sur le thème B-A-C-H', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: I. Choral sur le thème B-A-C-H',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3d5b2265-8246-4419-868e-e31035139ebf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3d5b2265-8246-4419-868e-e31035139ebf', 1, 'I', 'Choral sur le thème B-A-C-H', 'Offrande musicale sur le nom de BACH, op. 187: I. Choral sur le thème B-A-C-H', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3d5b2265-8246-4419-868e-e31035139ebf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Canons sur le nom de BACH', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: II. Canons sur le nom de BACH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b0961ebc-fdac-49ff-bd78-f5e99adf6459' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b0961ebc-fdac-49ff-bd78-f5e99adf6459', 2, 'II', 'Canons sur le nom de BACH', 'Offrande musicale sur le nom de BACH, op. 187: II. Canons sur le nom de BACH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b0961ebc-fdac-49ff-bd78-f5e99adf6459'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Fugue sur le nom de BACH', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: III. Fugue sur le nom de BACH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:53168d24-a727-4f56-b6ba-87114428a628' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:53168d24-a727-4f56-b6ba-87114428a628', 3, 'III', 'Fugue sur le nom de BACH', 'Offrande musicale sur le nom de BACH, op. 187: III. Fugue sur le nom de BACH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:53168d24-a727-4f56-b6ba-87114428a628'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Passacaille', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: IV. Passacaille',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4e658abe-ad8d-4ed3-97fb-89026a9a6be7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e658abe-ad8d-4ed3-97fb-89026a9a6be7', 4, 'IV', 'Passacaille', 'Offrande musicale sur le nom de BACH, op. 187: IV. Passacaille', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e658abe-ad8d-4ed3-97fb-89026a9a6be7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Fugue sur le nom de BACH', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: V. Fugue sur le nom de BACH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f6443865-201c-4105-acbc-3d66b93b1d57' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f6443865-201c-4105-acbc-3d66b93b1d57', 5, 'V', 'Fugue sur le nom de BACH', 'Offrande musicale sur le nom de BACH, op. 187: V. Fugue sur le nom de BACH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f6443865-201c-4105-acbc-3d66b93b1d57'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Polyphonie en imitations accompagnant le thème: BACH', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: VI. Polyphonie en imitations accompagnant le thème: BACH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e587cbf2-4765-4811-9662-f7110ee9f8a6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e587cbf2-4765-4811-9662-f7110ee9f8a6', 6, 'VI', 'Polyphonie en imitations accompagnant le thème: BACH', 'Offrande musicale sur le nom de BACH, op. 187: VI. Polyphonie en imitations accompagnant le thème: BACH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e587cbf2-4765-4811-9662-f7110ee9f8a6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Feuillet d''album', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: VII. Feuillet d''album',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5024ee95-bfad-43c8-a531-1f356e811a40' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5024ee95-bfad-43c8-a531-1f356e811a40', 7, 'VII', 'Feuillet d''album', 'Offrande musicale sur le nom de BACH, op. 187: VII. Feuillet d''album', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5024ee95-bfad-43c8-a531-1f356e811a40'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Deux leçons d''harmonie sur le nom de BACH: 1. «Chant donné»', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: VIII. Deux leçons d''harmonie sur le nom de BACH: 1. «Chant donné»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4f85a8f5-66fd-498e-9eeb-4808f4f3caf2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4f85a8f5-66fd-498e-9eeb-4808f4f3caf2', 8, 'VIII', 'Deux leçons d''harmonie sur le nom de BACH: 1. «Chant donné»', 'Offrande musicale sur le nom de BACH, op. 187: VIII. Deux leçons d''harmonie sur le nom de BACH: 1. «Chant donné»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4f85a8f5-66fd-498e-9eeb-4808f4f3caf2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'VIII',
    part.name_ko = 'Deux leçons d''harmonie sur le nom de BACH: 2. «Basse donnée»', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: VIII. Deux leçons d''harmonie sur le nom de BACH: 2. «Basse donnée»',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bb1b81a9-bfae-4a15-a9fe-1ee0eb899d36' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bb1b81a9-bfae-4a15-a9fe-1ee0eb899d36', 9, 'VIII', 'Deux leçons d''harmonie sur le nom de BACH: 2. «Basse donnée»', 'Offrande musicale sur le nom de BACH, op. 187: VIII. Deux leçons d''harmonie sur le nom de BACH: 2. «Basse donnée»', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bb1b81a9-bfae-4a15-a9fe-1ee0eb899d36'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'IX',
    part.name_ko = 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1. «Fleuri» (Rigoureux) à 2 parties', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1. «Fleuri» (Rigoureux) à 2 parties',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8ae5194c-6218-485a-9e64-37a5116e2b5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ae5194c-6218-485a-9e64-37a5116e2b5d', 10, 'IX', 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1. «Fleuri» (Rigoureux) à 2 parties', 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1. «Fleuri» (Rigoureux) à 2 parties', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ae5194c-6218-485a-9e64-37a5116e2b5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'IX',
    part.name_ko = 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1 bis. Variante sur le même chant donné', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1 bis. Variante sur le même chant donné',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ebdc2e47-6b61-4a6d-8f12-26ce78074e6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ebdc2e47-6b61-4a6d-8f12-26ce78074e6c', 11, 'IX', 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1 bis. Variante sur le même chant donné', 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 1 bis. Variante sur le même chant donné', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ebdc2e47-6b61-4a6d-8f12-26ce78074e6c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'IX',
    part.name_ko = 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 2. «Fleuri» (Rigoureux) à 3 parties', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 2. «Fleuri» (Rigoureux) à 3 parties',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:aed4dbe9-3eac-4cee-ac1b-40ee0894be00' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:aed4dbe9-3eac-4cee-ac1b-40ee0894be00', 12, 'IX', 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 2. «Fleuri» (Rigoureux) à 3 parties', 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 2. «Fleuri» (Rigoureux) à 3 parties', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:aed4dbe9-3eac-4cee-ac1b-40ee0894be00'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'IX',
    part.name_ko = 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 3. «Fleuri» (Rigoureux) à 4 parties', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 3. «Fleuri» (Rigoureux) à 4 parties',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dc45112a-ee3d-4345-a303-4ce9012a4f34' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dc45112a-ee3d-4345-a303-4ce9012a4f34', 13, 'IX', 'Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 3. «Fleuri» (Rigoureux) à 4 parties', 'Offrande musicale sur le nom de BACH, op. 187: IX. Divers contrepoints d''école sur des C[hants] D[onnés] avec «BACH»: 3. «Fleuri» (Rigoureux) à 4 parties', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dc45112a-ee3d-4345-a303-4ce9012a4f34'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'X',
    part.name_ko = 'Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 1. «Fleuri» (Libre) à 4 parties', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: X. Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 1. «Fleuri» (Libre) à 4 parties',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e230ab29-f818-48d9-baff-172d780fe0dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e230ab29-f818-48d9-baff-172d780fe0dc', 14, 'X', 'Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 1. «Fleuri» (Libre) à 4 parties', 'Offrande musicale sur le nom de BACH, op. 187: X. Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 1. «Fleuri» (Libre) à 4 parties', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e230ab29-f818-48d9-baff-172d780fe0dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 15, part.movement_number = 'X',
    part.name_ko = 'Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 2. «Fleuri» (Libre) à 5 parties', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: X. Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 2. «Fleuri» (Libre) à 5 parties',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:68bee84b-01af-4e65-8c3c-3d2837ab7d39' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:68bee84b-01af-4e65-8c3c-3d2837ab7d39', 15, 'X', 'Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 2. «Fleuri» (Libre) à 5 parties', 'Offrande musicale sur le nom de BACH, op. 187: X. Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 2. «Fleuri» (Libre) à 5 parties', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:68bee84b-01af-4e65-8c3c-3d2837ab7d39'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 16, part.movement_number = 'X',
    part.name_ko = 'Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 3. «Fleuri» (Libre) à 6 parties', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: X. Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 3. «Fleuri» (Libre) à 6 parties',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ea7aeea6-4c32-4ec7-b392-5b410aba94d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea7aeea6-4c32-4ec7-b392-5b410aba94d4', 16, 'X', 'Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 3. «Fleuri» (Libre) à 6 parties', 'Offrande musicale sur le nom de BACH, op. 187: X. Contrepoint plus libres à 4, 5, 6 parties, avec C[hants] D[onnés] commençant par «BACH»: 3. «Fleuri» (Libre) à 6 parties', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea7aeea6-4c32-4ec7-b392-5b410aba94d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 17, part.movement_number = 'XI',
    part.name_ko = 'Fugue «symétrique» sur le nom de BACH', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: XI. Fugue «symétrique» sur le nom de BACH',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:df73183f-f251-41ea-9825-b94fc4099b2f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df73183f-f251-41ea-9825-b94fc4099b2f', 17, 'XI', 'Fugue «symétrique» sur le nom de BACH', 'Offrande musicale sur le nom de BACH, op. 187: XI. Fugue «symétrique» sur le nom de BACH', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df73183f-f251-41ea-9825-b94fc4099b2f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 18, part.movement_number = 'XII',
    part.name_ko = 'Final', part.name_en = 'Offrande musicale sur le nom de BACH, op. 187: XII. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25651 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c92eed72-73de-4636-ad41-396b2a08d319' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c92eed72-73de-4636-ad41-396b2a08d319', 18, 'XII', 'Final', 'Offrande musicale sur le nom de BACH, op. 187: XII. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25651 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c92eed72-73de-4636-ad41-396b2a08d319'
);


-- Op. 205 파르티타

UPDATE pieces piece
SET piece.title = '파르티타', piece.title_en = 'Partita, op. 205',
    piece.type = 'song', piece.opus_number = 'Op. 205',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25374 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 75bis 파스토랄

UPDATE pieces piece
SET piece.title = '파스토랄', piece.title_en = 'Pastorale, op. 75bis',
    piece.type = 'song', piece.opus_number = 'Op. 75bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25733 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 63 Paysages et Marines

UPDATE pieces piece
SET piece.title = 'Paysages et Marines', piece.title_en = 'Paysages et Marines, op. 63',
    piece.type = 'album', piece.opus_number = 'Op. 63',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25778 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Sur la falaise', part.name_en = 'Paysages et Marines, op. 63: I. Sur la falaise',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1270d9bd-7a83-4f79-8e6b-874efb8b5178' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1270d9bd-7a83-4f79-8e6b-874efb8b5178', 1, 'I', 'Sur la falaise', 'Paysages et Marines, op. 63: I. Sur la falaise', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1270d9bd-7a83-4f79-8e6b-874efb8b5178'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Matin calme', part.name_en = 'Paysages et Marines, op. 63: II. Matin calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e5a2b7af-e180-47a0-aa52-14c2ab4ad109' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5a2b7af-e180-47a0-aa52-14c2ab4ad109', 2, 'II', 'Matin calme', 'Paysages et Marines, op. 63: II. Matin calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5a2b7af-e180-47a0-aa52-14c2ab4ad109'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Promenade vers la mer', part.name_en = 'Paysages et Marines, op. 63: III. Promenade vers la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:945762fc-a0b1-49ad-b58e-69c7abb5fd30' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:945762fc-a0b1-49ad-b58e-69c7abb5fd30', 3, 'III', 'Promenade vers la mer', 'Paysages et Marines, op. 63: III. Promenade vers la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:945762fc-a0b1-49ad-b58e-69c7abb5fd30'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Le Chant du chevrier', part.name_en = 'Paysages et Marines, op. 63: IV. Le Chant du chevrier',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ff74c99d-47b5-47a4-b464-c8d781adad5d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff74c99d-47b5-47a4-b464-c8d781adad5d', 4, 'IV', 'Le Chant du chevrier', 'Paysages et Marines, op. 63: IV. Le Chant du chevrier', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff74c99d-47b5-47a4-b464-c8d781adad5d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Soir d''été (d''après la lithographie d''Henri Rivière)', part.name_en = 'Paysages et Marines, op. 63: V. Soir d''été (d''après la lithographie d''Henri Rivière)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3280ea92-974d-4f91-953a-b192c84fc252' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3280ea92-974d-4f91-953a-b192c84fc252', 5, 'V', 'Soir d''été (d''après la lithographie d''Henri Rivière)', 'Paysages et Marines, op. 63: V. Soir d''été (d''après la lithographie d''Henri Rivière)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3280ea92-974d-4f91-953a-b192c84fc252'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Ceux qui s''en vont pêcher au large dans la nuit', part.name_en = 'Paysages et Marines, op. 63: VI. Ceux qui s''en vont pêcher au large dans la nuit',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:34157e7d-bf90-4536-9200-0f9215518044' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34157e7d-bf90-4536-9200-0f9215518044', 6, 'VI', 'Ceux qui s''en vont pêcher au large dans la nuit', 'Paysages et Marines, op. 63: VI. Ceux qui s''en vont pêcher au large dans la nuit', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34157e7d-bf90-4536-9200-0f9215518044'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Soir d''angoisses', part.name_en = 'Paysages et Marines, op. 63: VII. Soir d''angoisses',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7f93bfe8-ec1f-461b-acca-b57d2a60d9b9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f93bfe8-ec1f-461b-acca-b57d2a60d9b9', 7, 'VII', 'Soir d''angoisses', 'Paysages et Marines, op. 63: VII. Soir d''angoisses', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f93bfe8-ec1f-461b-acca-b57d2a60d9b9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'La Chanson des pommiers en fleurs', part.name_en = 'Paysages et Marines, op. 63: VIII. La Chanson des pommiers en fleurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9bce4ce1-2cc1-4379-84eb-38dd6f955843' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9bce4ce1-2cc1-4379-84eb-38dd6f955843', 8, 'VIII', 'La Chanson des pommiers en fleurs', 'Paysages et Marines, op. 63: VIII. La Chanson des pommiers en fleurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bce4ce1-2cc1-4379-84eb-38dd6f955843'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Paysage d''octobre', part.name_en = 'Paysages et Marines, op. 63: IX. Paysage d''octobre',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c2ccd883-4c42-409d-8b59-0f2e228e5884' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c2ccd883-4c42-409d-8b59-0f2e228e5884', 9, 'IX', 'Paysage d''octobre', 'Paysages et Marines, op. 63: IX. Paysage d''octobre', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c2ccd883-4c42-409d-8b59-0f2e228e5884'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Le Chant des pêcheurs', part.name_en = 'Paysages et Marines, op. 63: X. Le Chant des pêcheurs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3e2a3093-377e-4339-b85b-48d46b1bf460' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e2a3093-377e-4339-b85b-48d46b1bf460', 10, 'X', 'Le Chant des pêcheurs', 'Paysages et Marines, op. 63: X. Le Chant des pêcheurs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e2a3093-377e-4339-b85b-48d46b1bf460'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Dans les grands champs', part.name_en = 'Paysages et Marines, op. 63: XI. Dans les grands champs',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ef6cbed4-ebcf-4fe8-b4a5-44e09555850d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ef6cbed4-ebcf-4fe8-b4a5-44e09555850d', 11, 'XI', 'Dans les grands champs', 'Paysages et Marines, op. 63: XI. Dans les grands champs', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ef6cbed4-ebcf-4fe8-b4a5-44e09555850d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Poème virgilien', part.name_en = 'Paysages et Marines, op. 63: XII. Poème virgilien',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25778 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:72cd28bc-ce98-4997-acc2-cde96e630c73' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:72cd28bc-ce98-4997-acc2-cde96e630c73', 12, 'XII', 'Poème virgilien', 'Paysages et Marines, op. 63: XII. Poème virgilien', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25778 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:72cd28bc-ce98-4997-acc2-cde96e630c73'
);


-- Op. 218 Pièce pour flûte et piano (pour lecture à vue)

UPDATE pieces piece
SET piece.title = 'Pièce pour flûte et piano (pour lecture à vue)', piece.title_en = 'Pièce pour flûte et piano (pour lecture à vue), op. 218',
    piece.type = 'song', piece.opus_number = 'Op. 218',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24413 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 226 Pièce pour orgue

UPDATE pieces piece
SET piece.title = 'Pièce pour orgue', piece.title_en = 'Pièce pour orgue, op. 226',
    piece.type = 'song', piece.opus_number = 'Op. 226',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23689 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- None Pièce pour piano, op. 83 bis

UPDATE pieces piece
SET piece.title = 'Pièce pour piano, op. 83 bis', piece.title_en = 'Pièce pour piano, op. 83 bis',
    piece.type = 'song', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23719 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 179 Pièces pour hautbois d'amour & piano Op. 179

UPDATE pieces piece
SET piece.title = 'Pièces pour hautbois d''amour & piano Op. 179', piece.title_en = 'Pièces pour hautbois d''amour & piano, op. 179',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '179',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23488 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = '12ème mouvement, Dolcissimo', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 12ème mouvement, Dolcissimo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0fd11381-2e48-4ed0-8c8c-d140652d42eb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0fd11381-2e48-4ed0-8c8c-d140652d42eb', 1, NULL, '12ème mouvement, Dolcissimo', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 12ème mouvement, Dolcissimo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0fd11381-2e48-4ed0-8c8c-d140652d42eb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = '2ème mouvement, Allegretto, plutôt andantino', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 2ème mouvement, Allegretto, plutôt andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:11cf1791-1b45-479a-85ac-6782ceb6327d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:11cf1791-1b45-479a-85ac-6782ceb6327d', 2, NULL, '2ème mouvement, Allegretto, plutôt andantino', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 2ème mouvement, Allegretto, plutôt andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:11cf1791-1b45-479a-85ac-6782ceb6327d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = '3ème mouvement, Andante', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 3ème mouvement, Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4b6a9da7-04dd-41e5-b123-9faf66ab00e1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4b6a9da7-04dd-41e5-b123-9faf66ab00e1', 3, NULL, '3ème mouvement, Andante', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 3ème mouvement, Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4b6a9da7-04dd-41e5-b123-9faf66ab00e1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = '7ème mouvement, Andante, presque adagio', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 7ème mouvement, Andante, presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5cb3e7bb-5a0b-471d-99d0-d62a91ed0b72' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5cb3e7bb-5a0b-471d-99d0-d62a91ed0b72', 4, NULL, '7ème mouvement, Andante, presque adagio', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 7ème mouvement, Andante, presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5cb3e7bb-5a0b-471d-99d0-d62a91ed0b72'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = '14ème mouvement, Allegro con moto', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 14ème mouvement, Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:93260c8c-0f54-4919-a21e-be20a730d0be' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93260c8c-0f54-4919-a21e-be20a730d0be', 5, NULL, '14ème mouvement, Allegro con moto', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 14ème mouvement, Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93260c8c-0f54-4919-a21e-be20a730d0be'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = '9ème mouvement, Lent (adagio)', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 9ème mouvement, Lent (adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:98497e48-ec8a-4a9d-8afb-a8eea93aee10' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98497e48-ec8a-4a9d-8afb-a8eea93aee10', 6, NULL, '9ème mouvement, Lent (adagio)', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 9ème mouvement, Lent (adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98497e48-ec8a-4a9d-8afb-a8eea93aee10'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = '1er mouvement, Andante con moto quasi allegro moderato', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 1er mouvement, Andante con moto quasi allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bad23f60-6425-486f-9a1b-6e1734c922bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bad23f60-6425-486f-9a1b-6e1734c922bf', 7, NULL, '1er mouvement, Andante con moto quasi allegro moderato', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 1er mouvement, Andante con moto quasi allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bad23f60-6425-486f-9a1b-6e1734c922bf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = NULL,
    part.name_ko = '6ème mouvement, Allegretto con moto', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 6ème mouvement, Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ca2b61e8-55ba-4793-916f-b050e708bed3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca2b61e8-55ba-4793-916f-b050e708bed3', 8, NULL, '6ème mouvement, Allegretto con moto', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 6ème mouvement, Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca2b61e8-55ba-4793-916f-b050e708bed3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = NULL,
    part.name_ko = '11ème mouvement, Allegretto con moto', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 11ème mouvement, Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dcd3fb5e-6e1d-4112-bad9-f5d0ebf18938' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dcd3fb5e-6e1d-4112-bad9-f5d0ebf18938', 9, NULL, '11ème mouvement, Allegretto con moto', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 11ème mouvement, Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dcd3fb5e-6e1d-4112-bad9-f5d0ebf18938'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = NULL,
    part.name_ko = '8ème mouvement, Allegretto, assez tranquille, presque andantino', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 8ème mouvement, Allegretto, assez tranquille, presque andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:df735d53-e1f1-4bed-981e-ed54af8d6766' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:df735d53-e1f1-4bed-981e-ed54af8d6766', 10, NULL, '8ème mouvement, Allegretto, assez tranquille, presque andantino', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 8ème mouvement, Allegretto, assez tranquille, presque andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:df735d53-e1f1-4bed-981e-ed54af8d6766'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = NULL,
    part.name_ko = '13ème mouvement, Adagio', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 13ème mouvement, Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e4c9d5a6-df24-4d42-bf9d-35ca7d23f180' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c9d5a6-df24-4d42-bf9d-35ca7d23f180', 11, NULL, '13ème mouvement, Adagio', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 13ème mouvement, Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c9d5a6-df24-4d42-bf9d-35ca7d23f180'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = NULL,
    part.name_ko = '5ème mouvement, Tres doux, presque adagio', part.name_en = 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 5ème mouvement, Tres doux, presque adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23488 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e5aa00cc-0312-460b-9f35-5ff0d39aea7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e5aa00cc-0312-460b-9f35-5ff0d39aea7b', 12, NULL, '5ème mouvement, Tres doux, presque adagio', 'Pièces pour hautbois d''amour & piano, op. 179 (1er recueil) : 5ème mouvement, Tres doux, presque adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23488 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e5aa00cc-0312-460b-9f35-5ff0d39aea7b'
);


-- Op. 13 Poèmes d'automne Op. 13

UPDATE pieces piece
SET piece.title = 'Poèmes d''automne Op. 13', piece.title_en = 'Poèmes d''automne, op. 13',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '13',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23724 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Déclin d''amour, op. 13 no. 1', part.name_en = 'Déclin d''amour, op. 13 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d1564922-e0f8-4ce4-a031-6554d0f775f9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d1564922-e0f8-4ce4-a031-6554d0f775f9', 1, NULL, 'Déclin d''amour, op. 13 no. 1', 'Déclin d''amour, op. 13 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d1564922-e0f8-4ce4-a031-6554d0f775f9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Les Rêves morts, op. 13 no. 2', part.name_en = 'Les Rêves morts, op. 13 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c5416e6b-e6a8-440a-8ef5-cc9b091f0888' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5416e6b-e6a8-440a-8ef5-cc9b091f0888', 2, NULL, 'Les Rêves morts, op. 13 no. 2', 'Les Rêves morts, op. 13 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5416e6b-e6a8-440a-8ef5-cc9b091f0888'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Le Nénuphar, op. 13 no. 3', part.name_en = 'Le Nénuphar, op. 13 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6e16ad4f-f22c-4382-9a3e-e12dfd65b7ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e16ad4f-f22c-4382-9a3e-e12dfd65b7ef', 3, NULL, 'Le Nénuphar, op. 13 no. 3', 'Le Nénuphar, op. 13 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e16ad4f-f22c-4382-9a3e-e12dfd65b7ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'L''Astre rouge, op. 13 no. 4', part.name_en = 'L''Astre rouge, op. 13 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:eeca86e5-1057-44b3-8280-ee50e0d47706' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eeca86e5-1057-44b3-8280-ee50e0d47706', 4, NULL, 'L''Astre rouge, op. 13 no. 4', 'L''Astre rouge, op. 13 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eeca86e5-1057-44b3-8280-ee50e0d47706'
);


-- Op. 51 4중주 1번 D

UPDATE pieces piece
SET piece.title = '4중주 1번 D', piece.title_en = 'Quartet n°1 in D, op. 51',
    piece.type = 'album', piece.opus_number = 'Op. 51',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23608 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato', part.name_en = 'Quartet n°1 in D, op. 51: I. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23608 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c7951b03-4d7a-4de7-8347-da75406e7013' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c7951b03-4d7a-4de7-8347-da75406e7013', 1, 'I', 'Allegro moderato', 'Quartet n°1 in D, op. 51: I. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23608 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c7951b03-4d7a-4de7-8347-da75406e7013'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Allegro scherzando non troppo vivace)', part.name_en = 'Quartet n°1 in D, op. 51: II. Scherzo (Allegro scherzando non troppo vivace)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23608 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:752cd30a-51c4-4685-b6f1-f55b28183a5b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:752cd30a-51c4-4685-b6f1-f55b28183a5b', 2, 'II', 'Scherzo (Allegro scherzando non troppo vivace)', 'Quartet n°1 in D, op. 51: II. Scherzo (Allegro scherzando non troppo vivace)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23608 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:752cd30a-51c4-4685-b6f1-f55b28183a5b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Quartet n°1 in D, op. 51: III. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23608 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fcd55123-62ce-4ce1-b6b2-690dc98937fd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fcd55123-62ce-4ce1-b6b2-690dc98937fd', 3, 'III', 'Andante quasi adagio', 'Quartet n°1 in D, op. 51: III. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23608 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fcd55123-62ce-4ce1-b6b2-690dc98937fd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale (Allegro con moto)', part.name_en = 'Quartet n°1 in D, op. 51: IV. Finale (Allegro con moto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23608 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f791a719-134a-477f-a5ea-5831d72f1af9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f791a719-134a-477f-a5ea-5831d72f1af9', 4, 'IV', 'Finale (Allegro con moto)', 'Quartet n°1 in D, op. 51: IV. Finale (Allegro con moto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23608 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f791a719-134a-477f-a5ea-5831d72f1af9'
);


-- Op. 57 4중주 2번

UPDATE pieces piece
SET piece.title = '4중주 2번', piece.title_en = 'Quartet n°2, op. 57',
    piece.type = 'album', piece.opus_number = 'Op. 57',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25935 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Quartet n°2, op. 57: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25935 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:29333ce5-aba9-4a16-ac4e-5dce6bbee96c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:29333ce5-aba9-4a16-ac4e-5dce6bbee96c', 1, 'I', 'Adagio', 'Quartet n°2, op. 57: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25935 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:29333ce5-aba9-4a16-ac4e-5dce6bbee96c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo (Allegro con fuoco)', part.name_en = 'Quartet n°2, op. 57: II. Scherzo (Allegro con fuoco)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25935 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:23511499-2b14-4006-9d88-421b2e5aee45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:23511499-2b14-4006-9d88-421b2e5aee45', 2, 'II', 'Scherzo (Allegro con fuoco)', 'Quartet n°2, op. 57: II. Scherzo (Allegro con fuoco)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25935 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:23511499-2b14-4006-9d88-421b2e5aee45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Quasi adagio', part.name_en = 'Quartet n°2, op. 57: III. Quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25935 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:229f100f-35ee-471f-b54e-e0b0b300a8f3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:229f100f-35ee-471f-b54e-e0b0b300a8f3', 3, 'III', 'Quasi adagio', 'Quartet n°2, op. 57: III. Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25935 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:229f100f-35ee-471f-b54e-e0b0b300a8f3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale (Allegro moderato)', part.name_en = 'Quartet n°2, op. 57: IV. Finale (Allegro moderato)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25935 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2887cb97-7129-46d6-9979-597f968afab9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2887cb97-7129-46d6-9979-597f968afab9', 4, 'IV', 'Finale (Allegro moderato)', 'Quartet n°2, op. 57: IV. Finale (Allegro moderato)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25935 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2887cb97-7129-46d6-9979-597f968afab9'
);


-- Op. 178 Quatorze Pièces pour clarinette et piano

UPDATE pieces piece
SET piece.title = 'Quatorze Pièces pour clarinette et piano', piece.title_en = 'Quatorze Pièces pour clarinette et piano, op. 178',
    piece.type = 'album', piece.opus_number = 'Op. 178',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25734 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante con moto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: I. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:80aa34ec-1996-41a2-95ab-0669fbf4ffaf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:80aa34ec-1996-41a2-95ab-0669fbf4ffaf', 1, 'I', 'Andante con moto', 'Quatorze Pièces pour clarinette et piano, op. 178: I. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:80aa34ec-1996-41a2-95ab-0669fbf4ffaf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:64303150-5c29-40e5-964d-122880c52dc5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:64303150-5c29-40e5-964d-122880c52dc5', 2, 'II', 'Allegretto', 'Quatorze Pièces pour clarinette et piano, op. 178: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:64303150-5c29-40e5-964d-122880c52dc5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Tranquillo', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: III. Tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f7b650b3-0762-4c66-b9d7-8da5f54f46cf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f7b650b3-0762-4c66-b9d7-8da5f54f46cf', 3, 'III', 'Tranquillo', 'Quatorze Pièces pour clarinette et piano, op. 178: III. Tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f7b650b3-0762-4c66-b9d7-8da5f54f46cf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Tempo de sicilienne', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: IV. Tempo de sicilienne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:354755b4-5757-4c4a-ba2f-548106449650' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:354755b4-5757-4c4a-ba2f-548106449650', 4, 'IV', 'Tempo de sicilienne', 'Quatorze Pièces pour clarinette et piano, op. 178: IV. Tempo de sicilienne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:354755b4-5757-4c4a-ba2f-548106449650'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegretto con moto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: V. Allegretto con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b258b97a-5311-498e-a804-c565b525bada' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b258b97a-5311-498e-a804-c565b525bada', 5, 'V', 'Allegretto con moto', 'Quatorze Pièces pour clarinette et piano, op. 178: V. Allegretto con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b258b97a-5311-498e-a804-c565b525bada'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Serein', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: VI. Serein',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3e613884-648e-4a13-b2f7-5151df2b22e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3e613884-648e-4a13-b2f7-5151df2b22e2', 6, 'VI', 'Serein', 'Quatorze Pièces pour clarinette et piano, op. 178: VI. Serein', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3e613884-648e-4a13-b2f7-5151df2b22e2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Allegro con moto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: VII. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ec5b2c03-e610-473b-b3db-e41ad0868135' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ec5b2c03-e610-473b-b3db-e41ad0868135', 7, 'VII', 'Allegro con moto', 'Quatorze Pièces pour clarinette et piano, op. 178: VII. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ec5b2c03-e610-473b-b3db-e41ad0868135'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 8, part.movement_number = 'VIII',
    part.name_ko = 'Concentré, presque adagio, sana traîner', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: VIII. Concentré, presque adagio, sana traîner',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:efb45ce2-8728-49d4-a20f-fa110d349968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:efb45ce2-8728-49d4-a20f-fa110d349968', 8, 'VIII', 'Concentré, presque adagio, sana traîner', 'Quatorze Pièces pour clarinette et piano, op. 178: VIII. Concentré, presque adagio, sana traîner', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:efb45ce2-8728-49d4-a20f-fa110d349968'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 9, part.movement_number = 'IX',
    part.name_ko = 'Allegro con moto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: IX. Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:56b49433-e8d5-482f-b51d-8e33f5a8c861' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:56b49433-e8d5-482f-b51d-8e33f5a8c861', 9, 'IX', 'Allegro con moto', 'Quatorze Pièces pour clarinette et piano, op. 178: IX. Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:56b49433-e8d5-482f-b51d-8e33f5a8c861'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 10, part.movement_number = 'X',
    part.name_ko = 'Andante', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: X. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c76090b3-2f58-44ad-aae3-b00e7c1285c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c76090b3-2f58-44ad-aae3-b00e7c1285c2', 10, 'X', 'Andante', 'Quatorze Pièces pour clarinette et piano, op. 178: X. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c76090b3-2f58-44ad-aae3-b00e7c1285c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 11, part.movement_number = 'XI',
    part.name_ko = 'Allegro con moto, vif et solide', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: XI. Allegro con moto, vif et solide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ee13a91f-0d1b-4061-a6cd-d458c2e413a2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee13a91f-0d1b-4061-a6cd-d458c2e413a2', 11, 'XI', 'Allegro con moto, vif et solide', 'Quatorze Pièces pour clarinette et piano, op. 178: XI. Allegro con moto, vif et solide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee13a91f-0d1b-4061-a6cd-d458c2e413a2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 12, part.movement_number = 'XII',
    part.name_ko = 'Larghetto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: XII. Larghetto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f4e681bc-9aeb-4ff8-a1aa-682973ebb483' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f4e681bc-9aeb-4ff8-a1aa-682973ebb483', 12, 'XII', 'Larghetto', 'Quatorze Pièces pour clarinette et piano, op. 178: XII. Larghetto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f4e681bc-9aeb-4ff8-a1aa-682973ebb483'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 13, part.movement_number = 'XIII',
    part.name_ko = 'Allegro vivo (non troppo)', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: XIII. Allegro vivo (non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:deaf089e-deb6-4e44-8469-1eb46827f85a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:deaf089e-deb6-4e44-8469-1eb46827f85a', 13, 'XIII', 'Allegro vivo (non troppo)', 'Quatorze Pièces pour clarinette et piano, op. 178: XIII. Allegro vivo (non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:deaf089e-deb6-4e44-8469-1eb46827f85a'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 14, part.movement_number = 'XIV',
    part.name_ko = 'Allegretto', part.name_en = 'Quatorze Pièces pour clarinette et piano, op. 178: XIV. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25734 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:847edee5-daf8-4ff8-91df-a2ce4045c06c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:847edee5-daf8-4ff8-91df-a2ce4045c06c', 14, 'XIV', 'Allegretto', 'Quatorze Pièces pour clarinette et piano, op. 178: XIV. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25734 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:847edee5-daf8-4ff8-91df-a2ce4045c06c'
);


-- Op. 214 Quatre Interludes

UPDATE pieces piece
SET piece.title = 'Quatre Interludes', piece.title_en = 'Quatre Interludes, op. 214',
    piece.type = 'album', piece.opus_number = 'Op. 214',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23989 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Assez animé', part.name_en = 'Quatre Interludes, op. 214: I. Assez animé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23989 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:147fb78b-e480-4fd0-b4c4-191562b0acb9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:147fb78b-e480-4fd0-b4c4-191562b0acb9', 1, 'I', 'Assez animé', 'Quatre Interludes, op. 214: I. Assez animé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23989 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:147fb78b-e480-4fd0-b4c4-191562b0acb9'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto', part.name_en = 'Quatre Interludes, op. 214: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23989 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4c06157b-38ac-47c9-8475-24b9f6d013ee' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4c06157b-38ac-47c9-8475-24b9f6d013ee', 2, 'II', 'Allegretto', 'Quatre Interludes, op. 214: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23989 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4c06157b-38ac-47c9-8475-24b9f6d013ee'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro (non troppo)', part.name_en = 'Quatre Interludes, op. 214: III. Allegro (non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23989 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:52dca0e7-9278-4554-b8fc-91edcf123dbf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:52dca0e7-9278-4554-b8fc-91edcf123dbf', 3, 'III', 'Allegro (non troppo)', 'Quatre Interludes, op. 214: III. Allegro (non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23989 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:52dca0e7-9278-4554-b8fc-91edcf123dbf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Coulant, assez vite', part.name_en = 'Quatre Interludes, op. 214: IV. Coulant, assez vite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23989 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:14a39a40-6aa5-4133-a533-a1e5f6eb5722' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:14a39a40-6aa5-4133-a533-a1e5f6eb5722', 4, 'IV', 'Coulant, assez vite', 'Quatre Interludes, op. 214: IV. Coulant, assez vite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23989 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:14a39a40-6aa5-4133-a533-a1e5f6eb5722'
);


-- Op. 32 Quatre Petites Pièces

UPDATE pieces piece
SET piece.title = 'Quatre Petites Pièces', piece.title_en = 'Quatre Petites Pièces, op. 32',
    piece.type = 'album', piece.opus_number = 'Op. 32',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24740 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Quatre Petites Pièces, op. 32: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24740 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f53c2221-c914-4f5d-90eb-480a707eadc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f53c2221-c914-4f5d-90eb-480a707eadc1', 1, 'I', 'Andante', 'Quatre Petites Pièces, op. 32: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24740 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f53c2221-c914-4f5d-90eb-480a707eadc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Très modéré', part.name_en = 'Quatre Petites Pièces, op. 32: II. Très modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24740 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d0bf8837-7dce-4490-aa27-1ea2fea09777' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d0bf8837-7dce-4490-aa27-1ea2fea09777', 2, 'II', 'Très modéré', 'Quatre Petites Pièces, op. 32: II. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24740 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d0bf8837-7dce-4490-aa27-1ea2fea09777'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegretto quasi andantino', part.name_en = 'Quatre Petites Pièces, op. 32: III. Allegretto quasi andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24740 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:04f6e6a0-2de4-4f2a-9847-d34e1e075cb6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:04f6e6a0-2de4-4f2a-9847-d34e1e075cb6', 3, 'III', 'Allegretto quasi andantino', 'Quatre Petites Pièces, op. 32: III. Allegretto quasi andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24740 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:04f6e6a0-2de4-4f2a-9847-d34e1e075cb6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Scherzando', part.name_en = 'Quatre Petites Pièces, op. 32: IV. Scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24740 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:942ab971-ccee-44f5-a22e-edb5a7d180e3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:942ab971-ccee-44f5-a22e-edb5a7d180e3', 4, 'IV', 'Scherzando', 'Quatre Petites Pièces, op. 32: IV. Scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24740 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:942ab971-ccee-44f5-a22e-edb5a7d180e3'
);


-- Op. 153 Quelques chorals pour des fêtes populaires Op. 153

UPDATE pieces piece
SET piece.title = 'Quelques chorals pour des fêtes populaires Op. 153', piece.title_en = 'Quelques chorals pour des fêtes populaires, op. 153',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '153',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24048 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Jeux', part.name_en = 'Quelques chorals pour des fêtes populaires, op. 153: No. 1. Jeux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24048 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:98cffafe-a000-4c7a-8bed-d55937418479' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:98cffafe-a000-4c7a-8bed-d55937418479', 1, NULL, 'Jeux', 'Quelques chorals pour des fêtes populaires, op. 153: No. 1. Jeux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24048 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:98cffafe-a000-4c7a-8bed-d55937418479'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Victoire', part.name_en = 'Quelques chorals pour des fêtes populaires, op. 153: No. 2. Victoire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24048 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7deba375-fd46-4bca-80ee-d783c20301f6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7deba375-fd46-4bca-80ee-d783c20301f6', 2, NULL, 'Victoire', 'Quelques chorals pour des fêtes populaires, op. 153: No. 2. Victoire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24048 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7deba375-fd46-4bca-80ee-d783c20301f6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Prélude a une fête populaire', part.name_en = 'Quelques chorals pour des fêtes populaires, op. 153: No. 3. Prélude a une fête populaire',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24048 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8091f013-56f1-4805-ad7c-f6a7d77759a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8091f013-56f1-4805-ad7c-f6a7d77759a8', 3, NULL, 'Prélude a une fête populaire', 'Quelques chorals pour des fêtes populaires, op. 153: No. 3. Prélude a une fête populaire', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24048 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8091f013-56f1-4805-ad7c-f6a7d77759a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Choral pour une fête de plein air', part.name_en = 'Quelques chorals pour des fêtes populaires, op. 153: No. 4. Choral pour une fête de plein air',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24048 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:45363025-8d7d-4c81-bc1d-1160cbb3cdae' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:45363025-8d7d-4c81-bc1d-1160cbb3cdae', 4, NULL, 'Choral pour une fête de plein air', 'Quelques chorals pour des fêtes populaires, op. 153: No. 4. Choral pour une fête de plein air', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24048 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:45363025-8d7d-4c81-bc1d-1160cbb3cdae'
);


-- Op. 156 Quintette Primavera

UPDATE pieces piece
SET piece.title = 'Quintette Primavera', piece.title_en = 'Quintette Primavera, op. 156',
    piece.type = 'album', piece.opus_number = 'Op. 156',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25378 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro quasi allegretto', part.name_en = 'Quintette Primavera, op. 156: I. Allegro quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25378 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b1d50454-695a-48ae-a13e-561411ea3e54' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1d50454-695a-48ae-a13e-561411ea3e54', 1, 'I', 'Allegro quasi allegretto', 'Quintette Primavera, op. 156: I. Allegro quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25378 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1d50454-695a-48ae-a13e-561411ea3e54'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Adagio', part.name_en = 'Quintette Primavera, op. 156: II. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25378 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a5877c61-fb79-41a8-84bb-4d0b943a97b6' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a5877c61-fb79-41a8-84bb-4d0b943a97b6', 2, 'II', 'Adagio', 'Quintette Primavera, op. 156: II. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25378 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a5877c61-fb79-41a8-84bb-4d0b943a97b6'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo', part.name_en = 'Quintette Primavera, op. 156: III. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25378 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:46bebf87-13e3-4ee8-bbb4-3a858639bd55' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:46bebf87-13e3-4ee8-bbb4-3a858639bd55', 3, 'III', 'Intermezzo', 'Quintette Primavera, op. 156: III. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25378 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:46bebf87-13e3-4ee8-bbb4-3a858639bd55'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Quintette Primavera, op. 156: IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25378 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dd588a6b-89c7-49a5-aa1f-6bd216e47f6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd588a6b-89c7-49a5-aa1f-6bd216e47f6e', 4, 'IV', 'Finale', 'Quintette Primavera, op. 156: IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25378 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd588a6b-89c7-49a5-aa1f-6bd216e47f6e'
);


-- Op. 223 Quintette no. 2 pour flute, violin, alto, violoncello et harpe

UPDATE pieces piece
SET piece.title = 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe', piece.title_en = 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223',
    piece.type = 'album', piece.opus_number = 'Op. 223',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24002 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro (non troppo)', part.name_en = 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: I. Allegro (non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24002 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:afd3145a-58bb-47d1-bf9f-180b32f3d2ef' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:afd3145a-58bb-47d1-bf9f-180b32f3d2ef', 1, 'I', 'Allegro (non troppo)', 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: I. Allegro (non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24002 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:afd3145a-58bb-47d1-bf9f-180b32f3d2ef'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Intermezzo - Scherzando, allegretto', part.name_en = 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: II. Intermezzo - Scherzando, allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24002 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4d7fb00a-992d-4941-b70b-98e25792eca7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4d7fb00a-992d-4941-b70b-98e25792eca7', 2, 'II', 'Intermezzo - Scherzando, allegretto', 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: II. Intermezzo - Scherzando, allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24002 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4d7fb00a-992d-4941-b70b-98e25792eca7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante con moto (Soleil au matin)', part.name_en = 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: III. Andante con moto (Soleil au matin)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24002 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f98e7013-907d-4dc4-bfbb-a0e3fcfd7450' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f98e7013-907d-4dc4-bfbb-a0e3fcfd7450', 3, 'III', 'Andante con moto (Soleil au matin)', 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: III. Andante con moto (Soleil au matin)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24002 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f98e7013-907d-4dc4-bfbb-a0e3fcfd7450'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final (Allegro con motto)', part.name_en = 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: IV. Final (Allegro con motto)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24002 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1ea0e25d-425e-433c-958d-8a8f6255bf0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1ea0e25d-425e-433c-958d-8a8f6255bf0c', 4, 'IV', 'Final (Allegro con motto)', 'Quintette no. 2 pour flute, violin, alto, violoncello et harpe, op. 223: IV. Final (Allegro con motto)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24002 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1ea0e25d-425e-433c-958d-8a8f6255bf0c'
);


-- Op. 80 Quintette pour piano et cordes

UPDATE pieces piece
SET piece.title = 'Quintette pour piano et cordes', piece.title_en = 'Quintette pour piano et cordes, op. 80',
    piece.type = 'album', piece.opus_number = 'Op. 80',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25213 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'L''attente obscure de ce qui sera', part.name_en = 'Quintette pour piano et cordes, op. 80: I. L''attente obscure de ce qui sera',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25213 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:eb8f3aab-c60e-461a-adde-ae91efce5aff' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:eb8f3aab-c60e-461a-adde-ae91efce5aff', 1, 'I', 'L''attente obscure de ce qui sera', 'Quintette pour piano et cordes, op. 80: I. L''attente obscure de ce qui sera', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25213 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:eb8f3aab-c60e-461a-adde-ae91efce5aff'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'L''Assaut de l''ennemi (la blessure)', part.name_en = 'Quintette pour piano et cordes, op. 80: II. L''Assaut de l''ennemi (la blessure)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25213 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5b8df465-eb17-41a5-9286-dcbabb006a21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5b8df465-eb17-41a5-9286-dcbabb006a21', 2, 'II', 'L''Assaut de l''ennemi (la blessure)', 'Quintette pour piano et cordes, op. 80: II. L''Assaut de l''ennemi (la blessure)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25213 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5b8df465-eb17-41a5-9286-dcbabb006a21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'La Nature consolatrice', part.name_en = 'Quintette pour piano et cordes, op. 80: III. La Nature consolatrice',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25213 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:60a5488c-3711-48fb-bf53-a0e71c6a2199' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60a5488c-3711-48fb-bf53-a0e71c6a2199', 3, 'III', 'La Nature consolatrice', 'Quintette pour piano et cordes, op. 80: III. La Nature consolatrice', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25213 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60a5488c-3711-48fb-bf53-a0e71c6a2199'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final. La Joie', part.name_en = 'Quintette pour piano et cordes, op. 80: IV. Final. La Joie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25213 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8ca25720-249c-4016-ac0b-1ce7f7b37d1b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ca25720-249c-4016-ac0b-1ce7f7b37d1b', 4, 'IV', 'Final. La Joie', 'Quintette pour piano et cordes, op. 80: IV. Final. La Joie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25213 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ca25720-249c-4016-ac0b-1ce7f7b37d1b'
);


-- Op. 165 Septuor d’instruments a vent

UPDATE pieces piece
SET piece.title = 'Septuor d’instruments a vent', piece.title_en = 'Septuor d’instruments a vent, op. 165',
    piece.type = 'album', piece.opus_number = 'Op. 165',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23470 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Monodie', part.name_en = 'Septuor d’instruments a vent, op. 165: I. Monodie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23470 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5bdaa3a5-1aa6-40dd-8c92-8d5bb0ce8267' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5bdaa3a5-1aa6-40dd-8c92-8d5bb0ce8267', 1, 'I', 'Monodie', 'Septuor d’instruments a vent, op. 165: I. Monodie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23470 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5bdaa3a5-1aa6-40dd-8c92-8d5bb0ce8267'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Pastorale', part.name_en = 'Septuor d’instruments a vent, op. 165: II. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23470 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ee8173e1-fc8a-4ed0-8d21-5b5872cff86e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee8173e1-fc8a-4ed0-8d21-5b5872cff86e', 2, 'II', 'Pastorale', 'Septuor d’instruments a vent, op. 165: II. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23470 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee8173e1-fc8a-4ed0-8d21-5b5872cff86e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Intermezzo', part.name_en = 'Septuor d’instruments a vent, op. 165: III. Intermezzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23470 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1042f59f-d283-48ba-a0f7-9c9c16ad894f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1042f59f-d283-48ba-a0f7-9c9c16ad894f', 3, 'III', 'Intermezzo', 'Septuor d’instruments a vent, op. 165: III. Intermezzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23470 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1042f59f-d283-48ba-a0f7-9c9c16ad894f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Fugue', part.name_en = 'Septuor d’instruments a vent, op. 165: IV. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23470 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6685f562-07a5-4b83-8d20-6385786bdcfa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6685f562-07a5-4b83-8d20-6385786bdcfa', 4, 'IV', 'Fugue', 'Septuor d’instruments a vent, op. 165: IV. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23470 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6685f562-07a5-4b83-8d20-6385786bdcfa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Sérénité', part.name_en = 'Septuor d’instruments a vent, op. 165: V. Sérénité',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23470 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e8fceaaa-21f9-469d-af4b-25c540222853' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e8fceaaa-21f9-469d-af4b-25c540222853', 5, 'V', 'Sérénité', 'Septuor d’instruments a vent, op. 165: V. Sérénité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23470 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e8fceaaa-21f9-469d-af4b-25c540222853'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Fugue', part.name_en = 'Septuor d’instruments a vent, op. 165: VI. Fugue',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23470 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e4c91d69-ecc0-498e-a9c4-95d03460cd1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e4c91d69-ecc0-498e-a9c4-95d03460cd1e', 6, 'VI', 'Fugue', 'Septuor d’instruments a vent, op. 165: VI. Fugue', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23470 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e4c91d69-ecc0-498e-a9c4-95d03460cd1e'
);


-- Op. 84 Shéhérazade (Recueil 2) Op. 84

UPDATE pieces piece
SET piece.title = 'Shéhérazade (Recueil 2) Op. 84', piece.title_en = 'Shéhérazade (Recueil 2), op. 84',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '84',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24664 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Voyage, op. 84 no. 2', part.name_en = 'Le Voyage, op. 84 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24664 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8cc13be5-0e38-4326-9a1f-2d97f4bb5e3a' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8cc13be5-0e38-4326-9a1f-2d97f4bb5e3a', 1, NULL, 'Le Voyage, op. 84 no. 2', 'Le Voyage, op. 84 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24664 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8cc13be5-0e38-4326-9a1f-2d97f4bb5e3a'
);


-- Op. 56 연가곡집 <Shéhérazade> Op. 56

UPDATE pieces piece
SET piece.title = '연가곡집 <Shéhérazade> Op. 56', piece.title_en = 'Shéhérazade, op. 56',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '56',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25487 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Chanson d''Engaddi, op. 56 no. 1', part.name_en = 'Chanson d''Engaddi, op. 56 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25487 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:983e48ce-c207-4ad5-b05d-08ac9a704b70' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:983e48ce-c207-4ad5-b05d-08ac9a704b70', 1, NULL, 'Chanson d''Engaddi, op. 56 no. 1', 'Chanson d''Engaddi, op. 56 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25487 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:983e48ce-c207-4ad5-b05d-08ac9a704b70'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Paysage, op. 56 no. 2', part.name_en = 'Paysage, op. 56 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25487 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b67df750-aef5-442f-b791-05b0f7bfc7cb' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b67df750-aef5-442f-b791-05b0f7bfc7cb', 2, NULL, 'Paysage, op. 56 no. 2', 'Paysage, op. 56 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25487 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b67df750-aef5-442f-b791-05b0f7bfc7cb'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'La Rose du rameau sec, op. 56 no. 3', part.name_en = 'La Rose du rameau sec, op. 56 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25487 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:cc9edace-646c-4ccb-8700-2a1a9c2f67c2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cc9edace-646c-4ccb-8700-2a1a9c2f67c2', 3, NULL, 'La Rose du rameau sec, op. 56 no. 3', 'La Rose du rameau sec, op. 56 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25487 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cc9edace-646c-4ccb-8700-2a1a9c2f67c2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Neige, op. 56 no. 4', part.name_en = 'La Neige, op. 56 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25487 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:675065c2-46b1-4e4f-9176-e01eb04bf313' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:675065c2-46b1-4e4f-9176-e01eb04bf313', 4, NULL, 'La Neige, op. 56 no. 4', 'La Neige, op. 56 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25487 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:675065c2-46b1-4e4f-9176-e01eb04bf313'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Ventre merveilleux, op. 56 no. 5', part.name_en = 'Le Ventre merveilleux, op. 56 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25487 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:12884838-4990-4b4b-9138-b2c6febfe6ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:12884838-4990-4b4b-9138-b2c6febfe6ad', 5, NULL, 'Le Ventre merveilleux, op. 56 no. 5', 'Le Ventre merveilleux, op. 56 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25487 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:12884838-4990-4b4b-9138-b2c6febfe6ad'
);


-- Op. 31 Six mélodies Op. 31

UPDATE pieces piece
SET piece.title = 'Six mélodies Op. 31', piece.title_en = 'Six mélodies, op. 31',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '31',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25944 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Sommeil de Canope, op. 31 no. 1', part.name_en = 'Le Sommeil de Canope, op. 31 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25944 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8115cd96-cd6e-4738-9cb8-7db07f9d0958' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8115cd96-cd6e-4738-9cb8-7db07f9d0958', 1, NULL, 'Le Sommeil de Canope, op. 31 no. 1', 'Le Sommeil de Canope, op. 31 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25944 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8115cd96-cd6e-4738-9cb8-7db07f9d0958'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Le Cortège d’Amphitrite, op. 31 no. 2', part.name_en = 'Le Cortège d’Amphitrite, op. 31 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25944 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:93de791a-c126-4eac-8fca-f49a1f33b24d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:93de791a-c126-4eac-8fca-f49a1f33b24d', 2, NULL, 'Le Cortège d’Amphitrite, op. 31 no. 2', 'Le Cortège d’Amphitrite, op. 31 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25944 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:93de791a-c126-4eac-8fca-f49a1f33b24d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'L’Île ancienne, op. 31 no. 3', part.name_en = 'L’Île ancienne, op. 31 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25944 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a375af38-ac38-4984-8c88-b382ac9ccf49' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a375af38-ac38-4984-8c88-b382ac9ccf49', 3, NULL, 'L’Île ancienne, op. 31 no. 3', 'L’Île ancienne, op. 31 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25944 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a375af38-ac38-4984-8c88-b382ac9ccf49'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'La Maison du matin, op. 31 no. 4', part.name_en = 'La Maison du matin, op. 31 no. 4',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25944 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4e50e352-79a7-4055-8679-03d51f62efad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4e50e352-79a7-4055-8679-03d51f62efad', 4, NULL, 'La Maison du matin, op. 31 no. 4', 'La Maison du matin, op. 31 no. 4', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25944 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4e50e352-79a7-4055-8679-03d51f62efad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Le Repas préparé, op. 31 no. 5', part.name_en = 'Le Repas préparé, op. 31 no. 5',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25944 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8ca40ca7-f7c6-47e3-ab98-98b9dec73df7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8ca40ca7-f7c6-47e3-ab98-98b9dec73df7', 5, NULL, 'Le Repas préparé, op. 31 no. 5', 'Le Repas préparé, op. 31 no. 5', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25944 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8ca40ca7-f7c6-47e3-ab98-98b9dec73df7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Amphise et Melitta, op. 31 no. 6', part.name_en = 'Amphise et Melitta, op. 31 no. 6',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25944 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:cd640bfb-754c-46bf-85a9-c6903a22e3d1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:cd640bfb-754c-46bf-85a9-c6903a22e3d1', 6, NULL, 'Amphise et Melitta, op. 31 no. 6', 'Amphise et Melitta, op. 31 no. 6', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25944 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:cd640bfb-754c-46bf-85a9-c6903a22e3d1'
);


-- Op. 85 Sonate nº 1 pour clarinette et piano

UPDATE pieces piece
SET piece.title = 'Sonate nº 1 pour clarinette et piano', piece.title_en = 'Sonate nº 1 pour clarinette et piano, op. 85',
    piece.type = 'album', piece.opus_number = 'Op. 85',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24724 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro', part.name_en = 'Sonate nº 1 pour clarinette et piano, op. 85: I. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9ca185d5-1be4-4cfe-bc50-548579deccf5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ca185d5-1be4-4cfe-bc50-548579deccf5', 1, 'I', 'Allegro', 'Sonate nº 1 pour clarinette et piano, op. 85: I. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ca185d5-1be4-4cfe-bc50-548579deccf5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Sonate nº 1 pour clarinette et piano, op. 85: II. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2527a1d6-e0dd-4767-a081-fa12f48c7050' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2527a1d6-e0dd-4767-a081-fa12f48c7050', 2, 'II', 'Andante quasi adagio', 'Sonate nº 1 pour clarinette et piano, op. 85: II. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2527a1d6-e0dd-4767-a081-fa12f48c7050'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final', part.name_en = 'Sonate nº 1 pour clarinette et piano, op. 85: III. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24724 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7fa623f3-b00c-4e34-8e7c-5201c342d915' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7fa623f3-b00c-4e34-8e7c-5201c342d915', 3, 'III', 'Final', 'Sonate nº 1 pour clarinette et piano, op. 85: III. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24724 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7fa623f3-b00c-4e34-8e7c-5201c342d915'
);


-- Op. 86 Sonate nº 2 pour clarinette et piano

UPDATE pieces piece
SET piece.title = 'Sonate nº 2 pour clarinette et piano', piece.title_en = 'Sonate nº 2 pour clarinette et piano, op. 86',
    piece.type = 'album', piece.opus_number = 'Op. 86',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25045 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro ben moderato', part.name_en = 'Sonate nº 2 pour clarinette et piano, op. 86: I. Allegro ben moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25045 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f3aeef99-984b-45d7-89b6-aebbb6df37aa' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f3aeef99-984b-45d7-89b6-aebbb6df37aa', 1, 'I', 'Allegro ben moderato', 'Sonate nº 2 pour clarinette et piano, op. 86: I. Allegro ben moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25045 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f3aeef99-984b-45d7-89b6-aebbb6df37aa'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante con moto', part.name_en = 'Sonate nº 2 pour clarinette et piano, op. 86: II. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25045 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5fe58da1-de9c-4f0d-bd88-8a0e31697c0c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5fe58da1-de9c-4f0d-bd88-8a0e31697c0c', 2, 'II', 'Andante con moto', 'Sonate nº 2 pour clarinette et piano, op. 86: II. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25045 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5fe58da1-de9c-4f0d-bd88-8a0e31697c0c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Allegro', part.name_en = 'Sonate nº 2 pour clarinette et piano, op. 86: III. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25045 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2484701a-bd73-492c-a3b5-240c9c2b5752' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2484701a-bd73-492c-a3b5-240c9c2b5752', 3, 'III', 'Allegro', 'Sonate nº 2 pour clarinette et piano, op. 86: III. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25045 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2484701a-bd73-492c-a3b5-240c9c2b5752'
);


-- Op. 75 Sonate pour deux flûtes

UPDATE pieces piece
SET piece.title = 'Sonate pour deux flûtes', piece.title_en = 'Sonate pour deux flûtes, op. 75',
    piece.type = 'album', piece.opus_number = 'Op. 75',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25196 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Assez lent', part.name_en = 'Sonate pour deux flûtes, op. 75: I. Assez lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25196 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:54aaa5c6-6dbf-44b5-a83d-143339d97552' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:54aaa5c6-6dbf-44b5-a83d-143339d97552', 1, 'I', 'Assez lent', 'Sonate pour deux flûtes, op. 75: I. Assez lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25196 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:54aaa5c6-6dbf-44b5-a83d-143339d97552'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto scherzando', part.name_en = 'Sonate pour deux flûtes, op. 75: II. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25196 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8830f714-a98a-43ec-bb94-da05b6bd553d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8830f714-a98a-43ec-bb94-da05b6bd553d', 2, 'II', 'Allegretto scherzando', 'Sonate pour deux flûtes, op. 75: II. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25196 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8830f714-a98a-43ec-bb94-da05b6bd553d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final: Allegro (assez vif)', part.name_en = 'Sonate pour deux flûtes, op. 75: III. Final: Allegro (assez vif)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25196 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6e7bca52-e68b-4129-b03e-775e4fe76370' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e7bca52-e68b-4129-b03e-775e4fe76370', 3, 'III', 'Final: Allegro (assez vif)', 'Sonate pour deux flûtes, op. 75: III. Final: Allegro (assez vif)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25196 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e7bca52-e68b-4129-b03e-775e4fe76370'
);


-- Op. 52 Sonate pour flûte et piano

UPDATE pieces piece
SET piece.title = 'Sonate pour flûte et piano', piece.title_en = 'Sonate pour flûte et piano, op. 52',
    piece.type = 'album', piece.opus_number = 'Op. 52',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24104 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Adagio molto tranquillo', part.name_en = 'Sonate pour flûte et piano, op. 52: I. Adagio molto tranquillo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24104 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:bda01633-a036-4655-b3ed-c6dee6579d32' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:bda01633-a036-4655-b3ed-c6dee6579d32', 1, 'I', 'Adagio molto tranquillo', 'Sonate pour flûte et piano, op. 52: I. Adagio molto tranquillo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24104 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:bda01633-a036-4655-b3ed-c6dee6579d32'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto très modéré mais sans traîner (mouvement de sicilienne)', part.name_en = 'Sonate pour flûte et piano, op. 52: II. Allegretto très modéré mais sans traîner (mouvement de sicilienne)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24104 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f54bfaab-f645-417c-9d74-ee04733b37d8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f54bfaab-f645-417c-9d74-ee04733b37d8', 2, 'II', 'Allegretto très modéré mais sans traîner (mouvement de sicilienne)', 'Sonate pour flûte et piano, op. 52: II. Allegretto très modéré mais sans traîner (mouvement de sicilienne)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24104 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f54bfaab-f645-417c-9d74-ee04733b37d8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final. Animé et gai', part.name_en = 'Sonate pour flûte et piano, op. 52: III. Final. Animé et gai',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24104 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:01b031ad-3a7e-4bbc-b6a9-4041873a0514' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:01b031ad-3a7e-4bbc-b6a9-4041873a0514', 3, 'III', 'Final. Animé et gai', 'Sonate pour flûte et piano, op. 52: III. Final. Animé et gai', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24104 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:01b031ad-3a7e-4bbc-b6a9-4041873a0514'
);


-- Op. 53 Sonate pour piano et alto

UPDATE pieces piece
SET piece.title = 'Sonate pour piano et alto', piece.title_en = 'Sonate pour piano et alto, op. 53',
    piece.type = 'album', piece.opus_number = 'Op. 53',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25359 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Allegro molto animato e agitato', part.name_en = 'Sonate pour piano et alto, op. 53: II. Scherzo: Allegro molto animato e agitato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25359 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a1c62470-d90d-4b6f-bcfd-20b453a61591' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a1c62470-d90d-4b6f-bcfd-20b453a61591', 1, 'II', 'Scherzo: Allegro molto animato e agitato', 'Sonate pour piano et alto, op. 53: II. Scherzo: Allegro molto animato e agitato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25359 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a1c62470-d90d-4b6f-bcfd-20b453a61591'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'III',
    part.name_ko = 'Andante (presque adagio)', part.name_en = 'Sonate pour piano et alto, op. 53: III. Andante (presque adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25359 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b1c73b13-1b97-416a-9cc0-fe7eab493640' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b1c73b13-1b97-416a-9cc0-fe7eab493640', 2, 'III', 'Andante (presque adagio)', 'Sonate pour piano et alto, op. 53: III. Andante (presque adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25359 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b1c73b13-1b97-416a-9cc0-fe7eab493640'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Sonate pour piano et alto, op. 53: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25359 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b964346b-e5a9-4e31-95f0-7484ffb203a8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b964346b-e5a9-4e31-95f0-7484ffb203a8', 3, 'I', 'Adagio', 'Sonate pour piano et alto, op. 53: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25359 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b964346b-e5a9-4e31-95f0-7484ffb203a8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final: Allegro très modéré mai sourdement agité', part.name_en = 'Sonate pour piano et alto, op. 53: IV. Final: Allegro très modéré mai sourdement agité',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25359 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:feaf63b0-5b31-46aa-a95e-25b11ada6b68' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:feaf63b0-5b31-46aa-a95e-25b11ada6b68', 4, 'IV', 'Final: Allegro très modéré mai sourdement agité', 'Sonate pour piano et alto, op. 53: IV. Final: Allegro très modéré mai sourdement agité', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25359 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:feaf63b0-5b31-46aa-a95e-25b11ada6b68'
);


-- Op. 58 Sonate pour piano et hautbois

UPDATE pieces piece
SET piece.title = 'Sonate pour piano et hautbois', piece.title_en = 'Sonate pour piano et hautbois, op. 58',
    piece.type = 'album', piece.opus_number = 'Op. 58',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23493 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Allegro moderato: « La Terre, les travaux des champs, le soir »', part.name_en = 'Sonate pour piano et hautbois, op. 58: I. Allegro moderato: « La Terre, les travaux des champs, le soir »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23493 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ee589a73-d521-4ec6-8549-cf20b9224d93' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ee589a73-d521-4ec6-8549-cf20b9224d93', 1, 'I', 'Allegro moderato: « La Terre, les travaux des champs, le soir »', 'Sonate pour piano et hautbois, op. 58: I. Allegro moderato: « La Terre, les travaux des champs, le soir »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23493 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ee589a73-d521-4ec6-8549-cf20b9224d93'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: « Danses des Faunes »', part.name_en = 'Sonate pour piano et hautbois, op. 58: II. Scherzo: « Danses des Faunes »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23493 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:4ab059bd-3eba-461b-854b-eba1de32f1f8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:4ab059bd-3eba-461b-854b-eba1de32f1f8', 2, 'II', 'Scherzo: « Danses des Faunes »', 'Sonate pour piano et hautbois, op. 58: II. Scherzo: « Danses des Faunes »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23493 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:4ab059bd-3eba-461b-854b-eba1de32f1f8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante: «Le Soir, dans le Midi »', part.name_en = 'Sonate pour piano et hautbois, op. 58: III. Andante: «Le Soir, dans le Midi »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23493 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ab320c00-7d85-4f51-840f-5cdac425edad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ab320c00-7d85-4f51-840f-5cdac425edad', 3, 'III', 'Andante: «Le Soir, dans le Midi »', 'Sonate pour piano et hautbois, op. 58: III. Andante: «Le Soir, dans le Midi »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23493 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ab320c00-7d85-4f51-840f-5cdac425edad'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final (Allegro): « La Maison de campagne »', part.name_en = 'Sonate pour piano et hautbois, op. 58: IV. Final (Allegro): « La Maison de campagne »',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23493 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:50b4cf05-7ea8-4487-b281-b47275ae1608' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50b4cf05-7ea8-4487-b281-b47275ae1608', 4, 'IV', 'Final (Allegro): « La Maison de campagne »', 'Sonate pour piano et hautbois, op. 58: IV. Final (Allegro): « La Maison de campagne »', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23493 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50b4cf05-7ea8-4487-b281-b47275ae1608'
);


-- Op. 66 Sonate pour violoncelle et piano

UPDATE pieces piece
SET piece.title = 'Sonate pour violoncelle et piano', piece.title_en = 'Sonate pour violoncelle et piano, op. 66',
    piece.type = 'album', piece.opus_number = 'Op. 66',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25863 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Très modéré', part.name_en = 'Sonate pour violoncelle et piano, op. 66 : I. Très modéré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25863 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:797967c8-8ce3-4ce0-985b-2118b79db8b2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:797967c8-8ce3-4ce0-985b-2118b79db8b2', 1, 'I', 'Très modéré', 'Sonate pour violoncelle et piano, op. 66 : I. Très modéré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25863 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:797967c8-8ce3-4ce0-985b-2118b79db8b2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante quasi Adagio', part.name_en = 'Sonate pour violoncelle et piano, op. 66 : II. Andante quasi Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25863 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9a408bb2-c16a-4979-8bad-ab7f9921b968' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9a408bb2-c16a-4979-8bad-ab7f9921b968', 2, 'II', 'Andante quasi Adagio', 'Sonate pour violoncelle et piano, op. 66 : II. Andante quasi Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25863 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9a408bb2-c16a-4979-8bad-ab7f9921b968'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final: Allegro non troppo', part.name_en = 'Sonate pour violoncelle et piano, op. 66 : III. Final: Allegro non troppo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25863 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:398c6885-17a8-480b-ac97-17263b49d5d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:398c6885-17a8-480b-ac97-17263b49d5d4', 3, 'III', 'Final: Allegro non troppo', 'Sonate pour violoncelle et piano, op. 66 : III. Final: Allegro non troppo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25863 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:398c6885-17a8-480b-ac97-17263b49d5d4'
);


-- Op. 221 Sonate à sept

UPDATE pieces piece
SET piece.title = 'Sonate à sept', piece.title_en = 'Sonate à sept, op. 221',
    piece.type = 'album', piece.opus_number = 'Op. 221',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23805 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante', part.name_en = 'Sonate à sept, op. 221: I. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23805 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ca24f3f8-42e7-48de-b658-c892e7359bc1' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ca24f3f8-42e7-48de-b658-c892e7359bc1', 1, 'I', 'Andante', 'Sonate à sept, op. 221: I. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23805 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ca24f3f8-42e7-48de-b658-c892e7359bc1'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro', part.name_en = 'Sonate à sept, op. 221: II. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23805 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:285c6042-3700-42da-90ff-5c7a95ed6c5e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:285c6042-3700-42da-90ff-5c7a95ed6c5e', 2, 'II', 'Allegro', 'Sonate à sept, op. 221: II. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23805 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:285c6042-3700-42da-90ff-5c7a95ed6c5e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Sonate à sept, op. 221: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23805 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c5cc66a7-11ba-4a1d-9bbd-0ee15941304b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c5cc66a7-11ba-4a1d-9bbd-0ee15941304b', 3, 'III', 'Andante', 'Sonate à sept, op. 221: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23805 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c5cc66a7-11ba-4a1d-9bbd-0ee15941304b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Allegro', part.name_en = 'Sonate à sept, op. 221: IV. Allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23805 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d5fe3766-e599-4e3c-a2c2-d17449313ebe' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d5fe3766-e599-4e3c-a2c2-d17449313ebe', 4, 'IV', 'Allegro', 'Sonate à sept, op. 221: IV. Allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23805 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d5fe3766-e599-4e3c-a2c2-d17449313ebe'
);


-- None Sonatine modale pour flûte et clarinette, op. 155 a

UPDATE pieces piece
SET piece.title = 'Sonatine modale pour flûte et clarinette, op. 155 a', piece.title_en = 'Sonatine modale pour flûte et clarinette, op. 155 a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25941 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andante moderato', part.name_en = 'Sonatine modale pour flûte et clarinette, op. 155 a: I. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25941 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:17ede630-2586-4562-aaa2-128825b57dd7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:17ede630-2586-4562-aaa2-128825b57dd7', 1, 'I', 'Andante moderato', 'Sonatine modale pour flûte et clarinette, op. 155 a: I. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25941 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:17ede630-2586-4562-aaa2-128825b57dd7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegro moderato', part.name_en = 'Sonatine modale pour flûte et clarinette, op. 155 a: II. Allegro moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25941 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d51cf8c8-9731-4c77-9f73-29e36695eb46' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d51cf8c8-9731-4c77-9f73-29e36695eb46', 2, 'II', 'Allegro moderato', 'Sonatine modale pour flûte et clarinette, op. 155 a: II. Allegro moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25941 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d51cf8c8-9731-4c77-9f73-29e36695eb46'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino (sans traîner)', part.name_en = 'Sonatine modale pour flûte et clarinette, op. 155 a: III. Andantino (sans traîner)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25941 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d534ff0a-dcb3-4b5f-ac6b-9053db3067b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d534ff0a-dcb3-4b5f-ac6b-9053db3067b8', 3, 'III', 'Andantino (sans traîner)', 'Sonatine modale pour flûte et clarinette, op. 155 a: III. Andantino (sans traîner)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25941 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d534ff0a-dcb3-4b5f-ac6b-9053db3067b8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Assez large, expansif', part.name_en = 'Sonatine modale pour flûte et clarinette, op. 155 a: IV. Assez large, expansif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25941 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:894be0f7-8518-4ac3-9a40-820d2729572e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:894be0f7-8518-4ac3-9a40-820d2729572e', 4, 'IV', 'Assez large, expansif', 'Sonatine modale pour flûte et clarinette, op. 155 a: IV. Assez large, expansif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25941 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:894be0f7-8518-4ac3-9a40-820d2729572e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Allegro (non troppo)', part.name_en = 'Sonatine modale pour flûte et clarinette, op. 155 a: V. Allegro (non troppo)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25941 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8a741c7b-4fb0-422f-97e6-5ae526ee27e2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8a741c7b-4fb0-422f-97e6-5ae526ee27e2', 5, 'V', 'Allegro (non troppo)', 'Sonatine modale pour flûte et clarinette, op. 155 a: V. Allegro (non troppo)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25941 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8a741c7b-4fb0-422f-97e6-5ae526ee27e2'
);


-- Op. 224 Stèle funéraire

UPDATE pieces piece
SET piece.title = 'Stèle funéraire', piece.title_en = 'Stèle funéraire, op. 224',
    piece.type = 'song', piece.opus_number = 'Op. 224',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23329 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 55 Suite en quatuor

UPDATE pieces piece
SET piece.title = 'Suite en quatuor', piece.title_en = 'Suite en quatuor, op. 55',
    piece.type = 'album', piece.opus_number = 'Op. 55',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25275 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Moderato quasi andante', part.name_en = 'Suite en quatuor, op. 55: I. Moderato quasi andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25275 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:fa238b14-37f7-4970-b4d4-b690a772ad14' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:fa238b14-37f7-4970-b4d4-b690a772ad14', 1, 'I', 'Moderato quasi andante', 'Suite en quatuor, op. 55: I. Moderato quasi andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25275 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:fa238b14-37f7-4970-b4d4-b690a772ad14'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andante quasi adagio', part.name_en = 'Suite en quatuor, op. 55: II. Andante quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25275 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1f0e23bf-18e8-4151-8de8-4779ea8d9d63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1f0e23bf-18e8-4151-8de8-4779ea8d9d63', 2, 'II', 'Andante quasi adagio', 'Suite en quatuor, op. 55: II. Andante quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25275 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1f0e23bf-18e8-4151-8de8-4779ea8d9d63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final: Allegro con mot. Bein décidé', part.name_en = 'Suite en quatuor, op. 55: III. Final: Allegro con mot. Bein décidé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25275 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:1d0cb1af-c4b6-4b2c-a949-d77c2b1cb3ad' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:1d0cb1af-c4b6-4b2c-a949-d77c2b1cb3ad', 3, 'III', 'Final: Allegro con mot. Bein décidé', 'Suite en quatuor, op. 55: III. Final: Allegro con mot. Bein décidé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25275 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:1d0cb1af-c4b6-4b2c-a949-d77c2b1cb3ad'
);


-- Op. 19 Suite for piano duet

UPDATE pieces piece
SET piece.title = 'Suite for piano duet', piece.title_en = 'Suite for piano duet, op. 19',
    piece.type = 'album', piece.opus_number = 'Op. 19',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23578 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Canon', part.name_en = 'Suite for piano duet, op. 19: I. Canon',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23578 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7d6adc97-0e91-425d-965e-069195f5936c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7d6adc97-0e91-425d-965e-069195f5936c', 1, 'I', 'Canon', 'Suite for piano duet, op. 19: I. Canon', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23578 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7d6adc97-0e91-425d-965e-069195f5936c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lied', part.name_en = 'Suite for piano duet, op. 19: II. Lied',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23578 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f222fcf1-418d-4794-aa63-6c034322c654' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f222fcf1-418d-4794-aa63-6c034322c654', 2, 'II', 'Lied', 'Suite for piano duet, op. 19: II. Lied', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23578 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f222fcf1-418d-4794-aa63-6c034322c654'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Feuillet d''album', part.name_en = 'Suite for piano duet, op. 19: III. Feuillet d''album',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23578 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:81ff3633-6f52-4357-b73e-232c5477b0cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:81ff3633-6f52-4357-b73e-232c5477b0cd', 3, 'III', 'Feuillet d''album', 'Suite for piano duet, op. 19: III. Feuillet d''album', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23578 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:81ff3633-6f52-4357-b73e-232c5477b0cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Berceuse', part.name_en = 'Suite for piano duet, op. 19: IV. Berceuse',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23578 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a3981a05-0525-40ac-893a-fa60386b184b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:a3981a05-0525-40ac-893a-fa60386b184b', 4, 'IV', 'Berceuse', 'Suite for piano duet, op. 19: IV. Berceuse', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23578 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3981a05-0525-40ac-893a-fa60386b184b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Final', part.name_en = 'Suite for piano duet, op. 19: V. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23578 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d21dd1ad-8ddf-412f-a3b3-a2ac0d252112' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d21dd1ad-8ddf-412f-a3b3-a2ac0d252112', 5, 'V', 'Final', 'Suite for piano duet, op. 19: V. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23578 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d21dd1ad-8ddf-412f-a3b3-a2ac0d252112'
);


-- Op. 185 Suite pour cor anglais seul

UPDATE pieces piece
SET piece.title = 'Suite pour cor anglais seul', piece.title_en = 'Suite pour cor anglais seul, op. 185',
    piece.type = 'album', piece.opus_number = 'Op. 185',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25881 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Mélopée pour s''évader du réel', part.name_en = 'Suite pour cor anglais seul, op. 185: I. Mélopée pour s''évader du réel',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25881 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f60c41db-50c7-4a47-85a0-3a5e7ca4cfa2' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f60c41db-50c7-4a47-85a0-3a5e7ca4cfa2', 1, 'I', 'Mélopée pour s''évader du réel', 'Suite pour cor anglais seul, op. 185: I. Mélopée pour s''évader du réel', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25881 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f60c41db-50c7-4a47-85a0-3a5e7ca4cfa2'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo: Danse de faunes', part.name_en = 'Suite pour cor anglais seul, op. 185: II. Scherzo: Danse de faunes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25881 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dd77f764-e465-4fe5-96e3-5f2cf0ce758c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dd77f764-e465-4fe5-96e3-5f2cf0ce758c', 2, 'II', 'Scherzo: Danse de faunes', 'Suite pour cor anglais seul, op. 185: II. Scherzo: Danse de faunes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25881 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dd77f764-e465-4fe5-96e3-5f2cf0ce758c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Plainte nocturne', part.name_en = 'Suite pour cor anglais seul, op. 185: III. Plainte nocturne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25881 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:91026425-2533-4c7d-96db-0e1830825b7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:91026425-2533-4c7d-96db-0e1830825b7b', 3, 'III', 'Plainte nocturne', 'Suite pour cor anglais seul, op. 185: III. Plainte nocturne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25881 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:91026425-2533-4c7d-96db-0e1830825b7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Final: L''Âme libre et fantasque', part.name_en = 'Suite pour cor anglais seul, op. 185: IV. Final: L''Âme libre et fantasque',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25881 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b62dda9b-6020-4021-8f28-c5a6a032dad9' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b62dda9b-6020-4021-8f28-c5a6a032dad9', 4, 'IV', 'Final: L''Âme libre et fantasque', 'Suite pour cor anglais seul, op. 185: IV. Final: L''Âme libre et fantasque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25881 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b62dda9b-6020-4021-8f28-c5a6a032dad9'
);


-- Op. 6 Suite pour deux pianos

UPDATE pieces piece
SET piece.title = 'Suite pour deux pianos', piece.title_en = 'Suite pour deux pianos, op. 6',
    piece.type = 'album', piece.opus_number = 'Op. 6',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24876 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Andantino', part.name_en = 'Suite pour deux pianos, op. 6: I. Andantino',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24876 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:dfa39b1c-4a07-4460-89d6-2d0e11c5053b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:dfa39b1c-4a07-4460-89d6-2d0e11c5053b', 1, 'I', 'Andantino', 'Suite pour deux pianos, op. 6: I. Andantino', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24876 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:dfa39b1c-4a07-4460-89d6-2d0e11c5053b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Andantino con moto', part.name_en = 'Suite pour deux pianos, op. 6: II. Andantino con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24876 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:8aea1c1b-2370-442d-82bf-1925a0370308' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:8aea1c1b-2370-442d-82bf-1925a0370308', 2, 'II', 'Andantino con moto', 'Suite pour deux pianos, op. 6: II. Andantino con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24876 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:8aea1c1b-2370-442d-82bf-1925a0370308'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Andantino con moto quasi allegro', part.name_en = 'Suite pour deux pianos, op. 6: III. Andantino con moto quasi allegro',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24876 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f9c82ff4-85ac-4f88-b9ad-0e6402d313b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f9c82ff4-85ac-4f88-b9ad-0e6402d313b3', 3, 'III', 'Andantino con moto quasi allegro', 'Suite pour deux pianos, op. 6: III. Andantino con moto quasi allegro', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24876 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f9c82ff4-85ac-4f88-b9ad-0e6402d313b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Andantino quasi allegretto', part.name_en = 'Suite pour deux pianos, op. 6: IV. Andantino quasi allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24876 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:70fbc049-245f-4428-8a5f-82c157cbd5b8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:70fbc049-245f-4428-8a5f-82c157cbd5b8', 4, 'IV', 'Andantino quasi allegretto', 'Suite pour deux pianos, op. 6: IV. Andantino quasi allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24876 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:70fbc049-245f-4428-8a5f-82c157cbd5b8'
);


-- Op. 130 Sur les flots lointains

UPDATE pieces piece
SET piece.title = 'Sur les flots lointains', piece.title_en = 'Sur les flots lointains, op. 130',
    piece.type = 'song', piece.opus_number = 'Op. 130',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25986 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 57bis 교향곡 1번

UPDATE pieces piece
SET piece.title = '교향곡 1번', piece.title_en = 'Symphony No. 1, Op. 57bis',
    piece.type = 'album', piece.opus_number = 'Op. 57bis',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25517 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'III',
    part.name_ko = 'Andante', part.name_en = 'Symphony no. 1, op. 57bis: III. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25517 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2992feef-9927-416c-bab0-707a630a8b6e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2992feef-9927-416c-bab0-707a630a8b6e', 1, 'III', 'Andante', 'Symphony no. 1, op. 57bis: III. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25517 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2992feef-9927-416c-bab0-707a630a8b6e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Scherzo', part.name_en = 'Symphony no. 1, op. 57bis: II. Scherzo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25517 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3ea0728b-cb5d-4574-8573-99213b27ad11' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3ea0728b-cb5d-4574-8573-99213b27ad11', 2, 'II', 'Scherzo', 'Symphony no. 1, op. 57bis: II. Scherzo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25517 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3ea0728b-cb5d-4574-8573-99213b27ad11'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'I',
    part.name_ko = 'Adagio', part.name_en = 'Symphony no. 1, op. 57bis: I. Adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25517 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d2562ebf-3784-48ba-9854-3b83f1a85d1e' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d2562ebf-3784-48ba-9854-3b83f1a85d1e', 3, 'I', 'Adagio', 'Symphony no. 1, op. 57bis: I. Adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25517 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d2562ebf-3784-48ba-9854-3b83f1a85d1e'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Finale', part.name_en = 'Symphony no. 1, op. 57bis: IV. Finale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25517 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ff7b2d45-6998-4eec-930f-76b23c3b38d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ff7b2d45-6998-4eec-930f-76b23c3b38d4', 4, 'IV', 'Finale', 'Symphony no. 1, op. 57bis: IV. Finale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25517 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ff7b2d45-6998-4eec-930f-76b23c3b38d4'
);


-- Op. 132 The Seven Stars' Symphony

UPDATE pieces piece
SET piece.title = 'The Seven Stars'' Symphony', piece.title_en = 'The Seven Stars'' Symphony, op. 132',
    piece.type = 'album', piece.opus_number = 'Op. 132',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23423 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Douglas Fairbanks', part.name_en = 'The Seven Stars'' Symphony, op. 132: I. Douglas Fairbanks',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5022b1fc-0d01-4c02-a409-b9307037d4e8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5022b1fc-0d01-4c02-a409-b9307037d4e8', 1, 'I', 'Douglas Fairbanks', 'The Seven Stars'' Symphony, op. 132: I. Douglas Fairbanks', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5022b1fc-0d01-4c02-a409-b9307037d4e8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Lilian Harvey', part.name_en = 'The Seven Stars'' Symphony, op. 132: II. Lilian Harvey',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:60fd1ee1-ea67-46ad-9486-5d0713950687' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:60fd1ee1-ea67-46ad-9486-5d0713950687', 2, 'II', 'Lilian Harvey', 'The Seven Stars'' Symphony, op. 132: II. Lilian Harvey', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:60fd1ee1-ea67-46ad-9486-5d0713950687'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Greta Garbo', part.name_en = 'The Seven Stars'' Symphony, op. 132: III. Greta Garbo',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e6684b1b-f26e-43e7-8946-d05d9e2b58ea' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e6684b1b-f26e-43e7-8946-d05d9e2b58ea', 3, 'III', 'Greta Garbo', 'The Seven Stars'' Symphony, op. 132: III. Greta Garbo', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e6684b1b-f26e-43e7-8946-d05d9e2b58ea'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Clara Bow et la joyeuse Californie', part.name_en = 'The Seven Stars'' Symphony, op. 132: IV. Clara Bow et la joyeuse Californie',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3003fe69-1d19-4e3b-b89e-aa0d93ae4b45' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3003fe69-1d19-4e3b-b89e-aa0d93ae4b45', 4, 'IV', 'Clara Bow et la joyeuse Californie', 'The Seven Stars'' Symphony, op. 132: IV. Clara Bow et la joyeuse Californie', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3003fe69-1d19-4e3b-b89e-aa0d93ae4b45'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'Marlene Dietrich', part.name_en = 'The Seven Stars'' Symphony, op. 132: V. Marlene Dietrich',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:faffea85-4e90-42f4-8d49-6feeaef5d688' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:faffea85-4e90-42f4-8d49-6feeaef5d688', 5, 'V', 'Marlene Dietrich', 'The Seven Stars'' Symphony, op. 132: V. Marlene Dietrich', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:faffea85-4e90-42f4-8d49-6feeaef5d688'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = 'VI',
    part.name_ko = 'Emil Jannings', part.name_en = 'The Seven Stars'' Symphony, op. 132: VI. Emil Jannings',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5681f667-ceea-4645-8614-b0bfac21d391' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5681f667-ceea-4645-8614-b0bfac21d391', 6, 'VI', 'Emil Jannings', 'The Seven Stars'' Symphony, op. 132: VI. Emil Jannings', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5681f667-ceea-4645-8614-b0bfac21d391'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = 'VII',
    part.name_ko = 'Charlie Chaplin', part.name_en = 'The Seven Stars'' Symphony, op. 132: VII. Charlie Chaplin',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23423 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:787cd2ea-67d3-41b7-9366-99bb6c5ae68f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:787cd2ea-67d3-41b7-9366-99bb6c5ae68f', 7, 'VII', 'Charlie Chaplin', 'The Seven Stars'' Symphony, op. 132: VII. Charlie Chaplin', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23423 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:787cd2ea-67d3-41b7-9366-99bb6c5ae68f'
);


-- Op. 91 Trio (Divertissement)

UPDATE pieces piece
SET piece.title = 'Trio (Divertissement)', piece.title_en = 'Trio (Divertissement), op. 91',
    piece.type = 'album', piece.opus_number = 'Op. 91',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25400 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Très calme', part.name_en = 'Trio (Divertissement), op. 91: I. Très calme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:080337ce-c80c-4274-8c6d-d2e35abe9798' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:080337ce-c80c-4274-8c6d-d2e35abe9798', 1, 'I', 'Très calme', 'Trio (Divertissement), op. 91: I. Très calme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:080337ce-c80c-4274-8c6d-d2e35abe9798'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Allegretto quasi andante (sans lenteur)', part.name_en = 'Trio (Divertissement), op. 91: II. Allegretto quasi andante (sans lenteur)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:291a69fd-578f-49a3-922a-45f138088057' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:291a69fd-578f-49a3-922a-45f138088057', 2, 'II', 'Allegretto quasi andante (sans lenteur)', 'Trio (Divertissement), op. 91: II. Allegretto quasi andante (sans lenteur)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:291a69fd-578f-49a3-922a-45f138088057'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final: Allegro con moto. bien décidé', part.name_en = 'Trio (Divertissement), op. 91: III. Final: Allegro con moto. bien décidé',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:927d3147-18a1-475b-8811-9fca29b74e38' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:927d3147-18a1-475b-8811-9fca29b74e38', 3, 'III', 'Final: Allegro con moto. bien décidé', 'Trio (Divertissement), op. 91: III. Final: Allegro con moto. bien décidé', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:927d3147-18a1-475b-8811-9fca29b74e38'
);


-- Op. 92 Trio pour flûte, clarinette et basson

UPDATE pieces piece
SET piece.title = 'Trio pour flûte, clarinette et basson', piece.title_en = 'Trio pour flûte, clarinette et basson, op. 92',
    piece.type = 'album', piece.opus_number = 'Op. 92',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24580 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Lent (quasi adagio)', part.name_en = 'Trio pour flûte, clarinette et basson, op. 92: I. Lent (quasi adagio)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24580 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:67a6dbe4-a25c-4b8b-bb1d-21c95ccc0dc8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:67a6dbe4-a25c-4b8b-bb1d-21c95ccc0dc8', 1, 'I', 'Lent (quasi adagio)', 'Trio pour flûte, clarinette et basson, op. 92: I. Lent (quasi adagio)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24580 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:67a6dbe4-a25c-4b8b-bb1d-21c95ccc0dc8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Moderato sans lenteur', part.name_en = 'Trio pour flûte, clarinette et basson, op. 92: II. Moderato sans lenteur',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24580 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0e62fb33-12eb-404e-8ffb-2183fa415fb7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0e62fb33-12eb-404e-8ffb-2183fa415fb7', 2, 'II', 'Moderato sans lenteur', 'Trio pour flûte, clarinette et basson, op. 92: II. Moderato sans lenteur', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24580 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0e62fb33-12eb-404e-8ffb-2183fa415fb7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Final: Fugue - Allegro con moto', part.name_en = 'Trio pour flûte, clarinette et basson, op. 92: III. Final: Fugue - Allegro con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24580 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:acc4269b-014a-47da-b079-1d1723c006a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:acc4269b-014a-47da-b079-1d1723c006a3', 3, 'III', 'Final: Fugue - Allegro con moto', 'Trio pour flûte, clarinette et basson, op. 92: III. Final: Fugue - Allegro con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24580 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:acc4269b-014a-47da-b079-1d1723c006a3'
);


-- Op. 34 Trois Pièces Op. 34

UPDATE pieces piece
SET piece.title = 'Trois Pièces Op. 34', piece.title_en = 'Trois Pièces, op. 34',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '34',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24464 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Lent', part.name_en = 'Trois Pièces, op. 34: No. 1. Lent',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24464 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b7bee954-86e1-4ac5-a818-cd2a8654ab63' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b7bee954-86e1-4ac5-a818-cd2a8654ab63', 1, NULL, 'Lent', 'Trois Pièces, op. 34: No. 1. Lent', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24464 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b7bee954-86e1-4ac5-a818-cd2a8654ab63'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante moderato', part.name_en = 'Trois Pièces, op. 34: No. 2. Andante moderato',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24464 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:6ffe9618-16a4-40d4-a42b-c2f666ed7c7b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6ffe9618-16a4-40d4-a42b-c2f666ed7c7b', 2, NULL, 'Andante moderato', 'Trois Pièces, op. 34: No. 2. Andante moderato', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24464 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6ffe9618-16a4-40d4-a42b-c2f666ed7c7b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Andante sostenuto', part.name_en = 'Trois Pièces, op. 34: No. 3. Andante sostenuto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24464 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:34e74b47-89eb-4a83-9197-3bdd6a2c9174' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:34e74b47-89eb-4a83-9197-3bdd6a2c9174', 3, NULL, 'Andante sostenuto', 'Trois Pièces, op. 34: No. 3. Andante sostenuto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24464 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:34e74b47-89eb-4a83-9197-3bdd6a2c9174'
);


-- Op. 107 Trois Sonatines pour orgue Op. 107

UPDATE pieces piece
SET piece.title = 'Trois Sonatines pour orgue Op. 107', piece.title_en = 'Trois Sonatines pour orgue, op. 107',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '107',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23400 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sonatine pour orgue, op. 107 no. 1', part.name_en = 'Sonatine pour orgue, op. 107 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d', 1, NULL, 'Sonatine pour orgue, op. 107 no. 1', 'Sonatine pour orgue, op. 107 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Sonatine pour orgue, op. 107 no. 1: I. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ce632a89-a989-4c4c-b4d4-9c64e51fc489' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:ce632a89-a989-4c4c-b4d4-9c64e51fc489', 1, NULL, 'Allegretto', 'Sonatine pour orgue, op. 107 no. 1: I. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ce632a89-a989-4c4c-b4d4-9c64e51fc489'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto', part.name_en = 'Sonatine pour orgue, op. 107 no. 1: II. Allegretto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:5ed934c7-7b17-491c-8679-467f2131594f' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:5ed934c7-7b17-491c-8679-467f2131594f', 2, NULL, 'Allegretto', 'Sonatine pour orgue, op. 107 no. 1: II. Allegretto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:5ed934c7-7b17-491c-8679-467f2131594f'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Pastorale', part.name_en = 'Sonatine pour orgue, op. 107 no. 1: III. Pastorale',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b8cfd457-f250-457a-9023-f6362d9e596c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:b8cfd457-f250-457a-9023-f6362d9e596c', 3, NULL, 'Pastorale', 'Sonatine pour orgue, op. 107 no. 1: III. Pastorale', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:5d36a27d-3a01-4f8f-b5bd-b8d50036005d'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b8cfd457-f250-457a-9023-f6362d9e596c'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Sonatine pour orgue, op. 107 no. 2', part.name_en = 'Sonatine pour orgue, op. 107 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3', 2, NULL, 'Sonatine pour orgue, op. 107 no. 2', 'Sonatine pour orgue, op. 107 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Pastorale – Fanfare', part.name_en = 'Sonatine pour orgue, op. 107 no. 2: I. Pastorale – Fanfare',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a3ab8304-a729-4e62-9600-f6dcff792606' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a3ab8304-a729-4e62-9600-f6dcff792606', 1, NULL, 'Pastorale – Fanfare', 'Sonatine pour orgue, op. 107 no. 2: I. Pastorale – Fanfare', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a3ab8304-a729-4e62-9600-f6dcff792606'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegro vivace', part.name_en = 'Sonatine pour orgue, op. 107 no. 2: II. Allegro vivace',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:a23b18c6-bfe1-400d-89df-59672b5c40f5' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:a23b18c6-bfe1-400d-89df-59672b5c40f5', 2, NULL, 'Allegro vivace', 'Sonatine pour orgue, op. 107 no. 2: II. Allegro vivace', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:a23b18c6-bfe1-400d-89df-59672b5c40f5'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Calme et doux', part.name_en = 'Sonatine pour orgue, op. 107 no. 2: III. Calme et doux',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2a2edbb1-6662-4f95-8567-e8a6ada2eede' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:2a2edbb1-6662-4f95-8567-e8a6ada2eede', 3, NULL, 'Calme et doux', 'Sonatine pour orgue, op. 107 no. 2: III. Calme et doux', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2a2edbb1-6662-4f95-8567-e8a6ada2eede'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Andante', part.name_en = 'Sonatine pour orgue, op. 107 no. 2: IV. Andante',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:09665cd1-4cbf-4c58-b013-ce6b1b0ac059' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:09665cd1-4cbf-4c58-b013-ce6b1b0ac059', 4, NULL, 'Andante', 'Sonatine pour orgue, op. 107 no. 2: IV. Andante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:09665cd1-4cbf-4c58-b013-ce6b1b0ac059'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Quasi adagio', part.name_en = 'Sonatine pour orgue, op. 107 no. 2: V. Quasi adagio',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:618e7f1f-010f-4cfc-a4c5-96685e0c33cd' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:618e7f1f-010f-4cfc-a4c5-96685e0c33cd', 5, NULL, 'Quasi adagio', 'Sonatine pour orgue, op. 107 no. 2: V. Quasi adagio', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:e1959463-2e16-49d6-8aab-b60e24fd15b3'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:618e7f1f-010f-4cfc-a4c5-96685e0c33cd'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Sonatine pour orgue, op. 107 no. 3', part.name_en = 'Sonatine pour orgue, op. 107 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf', 3, NULL, 'Sonatine pour orgue, op. 107 no. 3', 'Sonatine pour orgue, op. 107 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Large et soutenu', part.name_en = 'Sonatine pour orgue, op. 107 no. 3: I. Large et soutenu',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:42d669f8-a026-4c01-8e9c-75905573c81b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:42d669f8-a026-4c01-8e9c-75905573c81b', 1, NULL, 'Large et soutenu', 'Sonatine pour orgue, op. 107 no. 3: I. Large et soutenu', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:42d669f8-a026-4c01-8e9c-75905573c81b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Allegretto scherzando', part.name_en = 'Sonatine pour orgue, op. 107 no. 3: II. Allegretto scherzando',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:105f5078-b719-4daa-85ec-d2acaef66bd0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:105f5078-b719-4daa-85ec-d2acaef66bd0', 2, NULL, 'Allegretto scherzando', 'Sonatine pour orgue, op. 107 no. 3: II. Allegretto scherzando', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:105f5078-b719-4daa-85ec-d2acaef66bd0'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
SET part.parent_part_id = parent.id,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Allegro solide', part.name_en = 'Sonatine pour orgue, op. 107 no. 3: III. Allegro solide',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23400 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9bc2fca7-09cb-4be0-bfb0-0c10e89351e0' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, parent.id, NULL, 'musicbrainz:9bc2fca7-09cb-4be0-bfb0-0c10e89351e0', 3, NULL, 'Allegro solide', 'Sonatine pour orgue, op. 107 no. 3: III. Allegro solide', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
JOIN piece_parts parent
    ON parent.piece_id = p.id AND parent.part_key = 'musicbrainz:62a7f10e-c6e9-4661-b2c0-e4d730445bdf'
WHERE p.id = 23400 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9bc2fca7-09cb-4be0-bfb0-0c10e89351e0'
);


-- Op. 17 Trois mélodies Op. 17

UPDATE pieces piece
SET piece.title = 'Trois mélodies Op. 17', piece.title_en = 'Trois mélodies, op. 17',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '17',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25240 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Le Colibri, op. 17 no. 1', part.name_en = 'Le Colibri, op. 17 no. 1',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25240 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:0b1ee8d6-9f32-463e-9342-983fce1d8927' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b1ee8d6-9f32-463e-9342-983fce1d8927', 1, NULL, 'Le Colibri, op. 17 no. 1', 'Le Colibri, op. 17 no. 1', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25240 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b1ee8d6-9f32-463e-9342-983fce1d8927'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'La Prière du mort, op. 17 no. 2', part.name_en = 'La Prière du mort, op. 17 no. 2',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25240 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b43eb5c6-b791-4550-8ce1-8307093ff642' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b43eb5c6-b791-4550-8ce1-8307093ff642', 2, NULL, 'La Prière du mort, op. 17 no. 2', 'La Prière du mort, op. 17 no. 2', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25240 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b43eb5c6-b791-4550-8ce1-8307093ff642'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Epiphanie, op. 17 no. 3', part.name_en = 'Epiphanie, op. 17 no. 3',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 25240 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:691cfe8e-1aa2-4818-925f-33f770ccdc6c' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:691cfe8e-1aa2-4818-925f-33f770ccdc6c', 3, NULL, 'Epiphanie, op. 17 no. 3', 'Epiphanie, op. 17 no. 3', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 25240 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:691cfe8e-1aa2-4818-925f-33f770ccdc6c'
);


-- Op. 98a Trois réalisations sur une basse donnée de Renée Philippart Op. 98a

UPDATE pieces piece
SET piece.title = 'Trois réalisations sur une basse donnée de Renée Philippart Op. 98a', piece.title_en = 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '98a',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 24798 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Moderato allant et bien lié', part.name_en = 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a: No. 1. Moderato allant et bien lié',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24798 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:e31646cc-ea7f-465d-a26a-5ee0d91ee8dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:e31646cc-ea7f-465d-a26a-5ee0d91ee8dc', 1, NULL, 'Moderato allant et bien lié', 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a: No. 1. Moderato allant et bien lié', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24798 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:e31646cc-ea7f-465d-a26a-5ee0d91ee8dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Un peu plus calme (que I) et très expressif', part.name_en = 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a: No. 2. Un peu plus calme (que I) et très expressif',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24798 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:c4ee50f2-5693-44c9-bf9c-837264301cc7' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:c4ee50f2-5693-44c9-bf9c-837264301cc7', 2, NULL, 'Un peu plus calme (que I) et très expressif', 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a: No. 2. Un peu plus calme (que I) et très expressif', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24798 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:c4ee50f2-5693-44c9-bf9c-837264301cc7'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Très adagio (très doux et très lié dans toutes les parties)', part.name_en = 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a: No. 3. Très adagio (très doux et très lié dans toutes les parties)',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 24798 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2efb60d6-7c3c-4806-9cf3-fba720060b13' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2efb60d6-7c3c-4806-9cf3-fba720060b13', 3, NULL, 'Très adagio (très doux et très lié dans toutes les parties)', 'Trois réalisations sur une basse donnée de Renée Philippart, op. 98a: No. 3. Très adagio (très doux et très lié dans toutes les parties)', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 24798 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2efb60d6-7c3c-4806-9cf3-fba720060b13'
);


-- Op. 173bis 2개의 클라리넷과 피아노를 위한 소품 Op. 173bis

UPDATE pieces piece
SET piece.title = '2개의 클라리넷과 피아노를 위한 소품 Op. 173bis', piece.title_en = 'Two Pieces for Clarinet and Piano, op. 173bis',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '173bis',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23638 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Sur un chante donné de Fauré', part.name_en = 'Two Pieces for Clarinet and Piano, op. 173bis: No. 1. Sur un chante donné de Fauré',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23638 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:ea77f38c-455e-4579-8d47-92de258ef661' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:ea77f38c-455e-4579-8d47-92de258ef661', 1, NULL, 'Sur un chante donné de Fauré', 'Two Pieces for Clarinet and Piano, op. 173bis: No. 1. Sur un chante donné de Fauré', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23638 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:ea77f38c-455e-4579-8d47-92de258ef661'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Andante con moto', part.name_en = 'Two Pieces for Clarinet and Piano, op. 173bis: No. 2. Andante con moto',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23638 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b3e8db00-db6c-49dc-811c-2402c4c0d487' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b3e8db00-db6c-49dc-811c-2402c4c0d487', 2, NULL, 'Andante con moto', 'Two Pieces for Clarinet and Piano, op. 173bis: No. 2. Andante con moto', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23638 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b3e8db00-db6c-49dc-811c-2402c4c0d487'
);


-- Op. 129 Vers la voûte étoilée

UPDATE pieces piece
SET piece.title = 'Vers la voûte étoilée', piece.title_en = 'Vers la voûte étoilée, op. 129',
    piece.type = 'song', piece.opus_number = 'Op. 129',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23891 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 174 Vers le soleil Op. 174

UPDATE pieces piece
SET piece.title = 'Vers le soleil Op. 174', piece.title_en = 'Vers le soleil, op. 174',
    piece.type = 'album', piece.opus_number = NULL,
    piece.catalogue_system = 'Op.', piece.catalogue_number = '174',
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 26006 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = NULL,
    part.name_ko = 'Réveil dans la lumière', part.name_en = 'Vers le soleil, op. 174 : 1. Réveil dans la lumière',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:b87dd657-5321-498f-b5d7-d7c5b26b5aed' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:b87dd657-5321-498f-b5d7-d7c5b26b5aed', 1, NULL, 'Réveil dans la lumière', 'Vers le soleil, op. 174 : 1. Réveil dans la lumière', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:b87dd657-5321-498f-b5d7-d7c5b26b5aed'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = NULL,
    part.name_ko = 'Berceuse marine', part.name_en = 'Vers le soleil, op. 174 : 2. Berceuse marine',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:7f37d81d-be3f-476e-8b7e-a8062fe6cf3b' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:7f37d81d-be3f-476e-8b7e-a8062fe6cf3b', 2, NULL, 'Berceuse marine', 'Vers le soleil, op. 174 : 2. Berceuse marine', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:7f37d81d-be3f-476e-8b7e-a8062fe6cf3b'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = NULL,
    part.name_ko = 'Les Mouettes', part.name_en = 'Vers le soleil, op. 174 : 3. Les Mouettes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:9ea13b25-cf37-4cc1-867b-1bff6f1f94dc' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:9ea13b25-cf37-4cc1-867b-1bff6f1f94dc', 3, NULL, 'Les Mouettes', 'Vers le soleil, op. 174 : 3. Les Mouettes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:9ea13b25-cf37-4cc1-867b-1bff6f1f94dc'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = NULL,
    part.name_ko = 'Repos', part.name_en = 'Vers le soleil, op. 174 : 4. Repos',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:88bc38b5-eec6-465e-8cd4-d69b572a9c21' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:88bc38b5-eec6-465e-8cd4-d69b572a9c21', 4, NULL, 'Repos', 'Vers le soleil, op. 174 : 4. Repos', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:88bc38b5-eec6-465e-8cd4-d69b572a9c21'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = NULL,
    part.name_ko = 'Vers le soleil, op. 174 : 5. ....', part.name_en = 'Vers le soleil, op. 174 : 5. ....',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:d53b6a85-a472-4763-b136-6718d45b0916' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:d53b6a85-a472-4763-b136-6718d45b0916', 5, NULL, 'Vers le soleil, op. 174 : 5. ....', 'Vers le soleil, op. 174 : 5. ....', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:d53b6a85-a472-4763-b136-6718d45b0916'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 6, part.movement_number = NULL,
    part.name_ko = 'Les Sirènes', part.name_en = 'Vers le soleil, op. 174 : 6. Les Sirènes',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:af4ea2ce-1b9a-48a9-90c8-e91eb9242554' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:af4ea2ce-1b9a-48a9-90c8-e91eb9242554', 6, NULL, 'Les Sirènes', 'Vers le soleil, op. 174 : 6. Les Sirènes', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:af4ea2ce-1b9a-48a9-90c8-e91eb9242554'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 7, part.movement_number = NULL,
    part.name_ko = 'Final', part.name_en = 'Vers le soleil, op. 174 : 7. Final',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 26006 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:2434e261-b1a4-4e86-a54a-fc4f99d9e0bf' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:2434e261-b1a4-4e86-a54a-fc4f99d9e0bf', 7, NULL, 'Final', 'Vers le soleil, op. 174 : 7. Final', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 26006 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:2434e261-b1a4-4e86-a54a-fc4f99d9e0bf'
);


-- Op. 164 Épitaphe de Jean Harlow

UPDATE pieces piece
SET piece.title = 'Épitaphe de Jean Harlow', piece.title_en = 'Épitaphe de Jean Harlow, op. 164',
    piece.type = 'song', piece.opus_number = 'Op. 164',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 25317 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;


-- Op. 46 Études antiques

UPDATE pieces piece
SET piece.title = 'Études antiques', piece.title_en = 'Études antiques, op. 46',
    piece.type = 'album', piece.opus_number = 'Op. 46',
    piece.catalogue_system = NULL, piece.catalogue_number = NULL,
    piece.composition_year = COALESCE(NULL, piece.composition_year),
    piece.editor_locked = 1
WHERE piece.id = 23352 AND piece.composer_id = 397
  AND piece.origin = 'seed' AND piece.editor_locked = 0;

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 1, part.movement_number = 'I',
    part.name_ko = 'Les Temples, le Soir, au bord de la mer', part.name_en = 'Études antiques, op. 46: I. Les Temples, le Soir, au bord de la mer',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23352 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:50129b5a-9c38-4db0-b28d-06b6e1f075d4' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:50129b5a-9c38-4db0-b28d-06b6e1f075d4', 1, 'I', 'Les Temples, le Soir, au bord de la mer', 'Études antiques, op. 46: I. Les Temples, le Soir, au bord de la mer', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23352 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:50129b5a-9c38-4db0-b28d-06b6e1f075d4'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 2, part.movement_number = 'II',
    part.name_ko = 'Soir au bord du lac', part.name_en = 'Études antiques, op. 46: II. Soir au bord du lac',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23352 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:3650954b-e74b-40e5-bd69-8c9b57fc8dd8' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3650954b-e74b-40e5-bd69-8c9b57fc8dd8', 2, 'II', 'Soir au bord du lac', 'Études antiques, op. 46: II. Soir au bord du lac', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23352 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3650954b-e74b-40e5-bd69-8c9b57fc8dd8'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 3, part.movement_number = 'III',
    part.name_ko = 'Le Cortège d''Amphitrite', part.name_en = 'Études antiques, op. 46: III. Le Cortège d''Amphitrite',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23352 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:625310e6-5086-4c2b-a134-cbf5ee9af0a3' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:625310e6-5086-4c2b-a134-cbf5ee9af0a3', 3, 'III', 'Le Cortège d''Amphitrite', 'Études antiques, op. 46: III. Le Cortège d''Amphitrite', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23352 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:625310e6-5086-4c2b-a134-cbf5ee9af0a3'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 4, part.movement_number = 'IV',
    part.name_ko = 'Épitaphe d''une jeune femme', part.name_en = 'Études antiques, op. 46: IV. Épitaphe d''une jeune femme',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23352 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:28e6b8b8-b412-484d-9768-a9e660ee0d25' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:28e6b8b8-b412-484d-9768-a9e660ee0d25', 4, 'IV', 'Épitaphe d''une jeune femme', 'Études antiques, op. 46: IV. Épitaphe d''une jeune femme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23352 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:28e6b8b8-b412-484d-9768-a9e660ee0d25'
);

UPDATE piece_parts part
JOIN pieces p ON p.id = part.piece_id

SET part.parent_part_id = NULL,
    part.linked_piece_id = NULL,
    part.sequence_number = 5, part.movement_number = 'V',
    part.name_ko = 'La Joie païenne', part.name_en = 'Études antiques, op. 46: V. La Joie païenne',
    part.editorial_status = 'EDITOR_REVIEWED', part.editor_locked = 1
WHERE p.id = 23352 AND p.composer_id = 397 AND part.part_key = 'musicbrainz:f02ca6e0-6fc0-4a49-8b07-db0d9dd66781' AND (part.editor_locked = 0 OR (part.origin = 'manual' AND part.editorial_status = 'FACTS_VERIFIED'));

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:f02ca6e0-6fc0-4a49-8b07-db0d9dd66781', 5, 'V', 'La Joie païenne', 'Études antiques, op. 46: V. La Joie païenne', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.id = 23352 AND p.composer_id = 397
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:f02ca6e0-6fc0-4a49-8b07-db0d9dd66781'
);


-- Op. 20 Au loin

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Au loin', 'Au loin, op. 20', 'song', 'Op. 20', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 397
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Au loin'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55854141-2220-47c7-aeab-97d1ec40d3b9'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '55854141-2220-47c7-aeab-97d1ec40d3b9'
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'Au loin' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '55854141-2220-47c7-aeab-97d1ec40d3b9'
);


-- Op. 73bis Choral sur le nom de Fauré

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Choral sur le nom de Fauré', 'Choral sur le nom de Fauré, op. 73bis', 'song', 'Op. 73bis', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 397
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Choral sur le nom de Fauré'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cf2ef58-85d3-4cef-a77d-55c9b528193f'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '7cf2ef58-85d3-4cef-a77d-55c9b528193f'
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'Choral sur le nom de Fauré' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '7cf2ef58-85d3-4cef-a77d-55c9b528193f'
);


-- Op. 149 L'Album de Lilian II Op. 149

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'L''Album de Lilian II Op. 149', 'L''Album de Lilian II, op. 149', 'album', NULL, 'Op.', '149', NULL, 'manual', 1
FROM composers c
WHERE c.id = 397
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'L''Album de Lilian II Op. 149'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed5db768-479f-440e-9323-91cb4f46c2b8'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', 'ed5db768-479f-440e-9323-91cb4f46c2b8'
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = 'ed5db768-479f-440e-9323-91cb4f46c2b8'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3acb1872-3481-418b-a38f-75a833c9f959', 1, NULL, 'Sérénade à l''étoile errante', 'L''Album de Lilian II, op. 149: 1. Sérénade à l''étoile errante', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3acb1872-3481-418b-a38f-75a833c9f959'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:74a02b7a-71cf-4b9b-908b-d58b70fddaaa', 2, NULL, 'Habanera créole', 'L''Album de Lilian II, op. 149: 2. Habanera créole', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:74a02b7a-71cf-4b9b-908b-d58b70fddaaa'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e891d32-16f6-4798-b19b-5cb44bea825a', 3, NULL, 'Swimming', 'L''Album de Lilian II, op. 149: 3. Swimming', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e891d32-16f6-4798-b19b-5cb44bea825a'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:0b69beea-d4ea-4d1a-a2f1-2f0b9c6af4de', 4, NULL, 'Barcarolle monégasque', 'L''Album de Lilian II, op. 149: 4. Barcarolle monégasque', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:0b69beea-d4ea-4d1a-a2f1-2f0b9c6af4de'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:119f8927-d7ea-4281-8dcf-c54264f5ec7d', 5, NULL, 'Le Voyage chimérique', 'L''Album de Lilian II, op. 149: 5. Le Voyage chimérique', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:119f8927-d7ea-4281-8dcf-c54264f5ec7d'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:6e2b0674-2c03-4cc7-b76a-73020d217e10', 6, NULL, 'Sicilienne de rêve', 'L''Album de Lilian II, op. 149: 6. Sicilienne de rêve', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:6e2b0674-2c03-4cc7-b76a-73020d217e10'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:90c440d8-43fd-4b90-bb6f-74bb2c67bca9', 7, NULL, 'Les Jeux du clown', 'L''Album de Lilian II, op. 149: 7. Les Jeux du clown', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:90c440d8-43fd-4b90-bb6f-74bb2c67bca9'
);

INSERT INTO piece_parts
    (piece_id, parent_part_id, linked_piece_id, part_key, sequence_number, movement_number, name_ko, name_en, editorial_status, origin, editor_locked)
SELECT p.id, NULL, NULL, 'musicbrainz:3b5c7be6-54a9-4650-9bdb-dd6e3d398e83', 8, NULL, 'La Prière de l''homme', 'L''Album de Lilian II, op. 149: 8. La Prière de l''homme', 'EDITOR_REVIEWED', 'manual', 1
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'L''Album de Lilian II Op. 149' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_parts existing
    WHERE existing.piece_id = p.id AND existing.part_key = 'musicbrainz:3b5c7be6-54a9-4650-9bdb-dd6e3d398e83'
);


-- Op. 7 Quatre Poèmes d'Edmond Haraucourt

INSERT INTO pieces
    (composer_id, title, title_en, type, opus_number, catalogue_system, catalogue_number, composition_year, origin, editor_locked)
SELECT c.id, 'Quatre Poèmes d''Edmond Haraucourt', 'Quatre Poèmes d''Edmond Haraucourt, op. 7', 'song', 'Op. 7', NULL, NULL, NULL, 'manual', 1
FROM composers c
WHERE c.id = 397
AND NOT EXISTS (
    SELECT 1 FROM pieces existing
    WHERE existing.composer_id = c.id AND existing.title = 'Quatre Poèmes d''Edmond Haraucourt'
)
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95f469ce-3d76-4d23-8857-eafa65a6723c'
);

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT p.id, 'musicbrainz_work', '95f469ce-3d76-4d23-8857-eafa65a6723c'
FROM pieces p
WHERE p.composer_id = 397 AND p.title = 'Quatre Poèmes d''Edmond Haraucourt' AND p.origin = 'manual'
AND NOT EXISTS (
    SELECT 1 FROM piece_identifiers taken
    WHERE taken.namespace = 'musicbrainz_work' AND taken.external_id = '95f469ce-3d76-4d23-8857-eafa65a6723c'
);


-- 카탈로그에 대응이 없는 seed 작품 9개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = 397 AND piece.origin = 'seed' AND piece.hidden_reason IS NULL
  AND piece.id IN (
    23249, 23544, 23804, 24117, 24374, 25281, 25859, 25911, 25930
  )
  AND NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)
  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id);
