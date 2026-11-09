-- 곡 안 곡(악장 등)과 그 곡을 가진 곡에 Apple Music 트랙 링크를 채운다. 자료와 규칙은
-- seed_pipeline/curation/piece-link-audit-2026-11-09/(match.py, apple-review-nested-matches.jsonl).
-- 앨범 링크가 있는 세트의 곡 156곡 중 68곡.
-- 이미 링크가 있는 곡은 그대로 두고, id 와 함께 작품·부모 곡·순서가 같은 곡에만 넣는다.
-- 두 번 넣어도 같다.

CREATE TEMPORARY TABLE tmp_part_apple (
    part_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    piece_id INT NOT NULL,
    sequence_number INT NOT NULL,
    parent_part_id BIGINT UNSIGNED NULL,
    url VARCHAR(500) NOT NULL
);
INSERT INTO tmp_part_apple (part_id, piece_id, sequence_number, parent_part_id, url) VALUES
(41637, 27162, 1, 41636, 'https://music.apple.com/us/album/string-quartet-no-45-in-a-major-op-55-no-1-hob-iii-60-i-allegro/295538611?i=295539377'),
(41638, 27162, 2, 41636, 'https://music.apple.com/us/album/string-quartet-no-45-in-a-major-op-55-no-1-hob-iii-60-ii-adagio-cantabile/295538611?i=295539374'),
(41639, 27162, 3, 41636, 'https://music.apple.com/us/album/string-quartet-no-45-in-a-major-op-55-no-1-hob-iii-60-iii-menuetto/295538611?i=295539366'),
(41640, 27162, 4, 41636, 'https://music.apple.com/us/album/string-quartet-no-45-in-a-major-op-55-no-1-hob-iii-60-iv-finale-vivace/295538611?i=295539364'),
(41642, 27162, 1, 41641, 'https://music.apple.com/us/album/string-quartet-no-46-in-f-minor-op-55-no-2-hob-iii-61-the-razor-i-andante-o-piu-tosto-allegretto/295538611?i=295539325'),
(41643, 27162, 2, 41641, 'https://music.apple.com/us/album/string-quartet-no-46-in-f-minor-op-55-no-2-hob-iii-61-the-razor-ii-allegro/295538611?i=295539317'),
(41644, 27162, 3, 41641, 'https://music.apple.com/us/album/string-quartet-no-46-in-f-minor-op-55-no-2-hob-iii-61-the-razor-iii-menuetto-allegretto/295538611?i=295539313'),
(41645, 27162, 4, 41641, 'https://music.apple.com/us/album/string-quartet-no-46-in-f-minor-op-55-no-2-hob-iii-61-the-razor-iv-finale-presto/295538611?i=295539309'),
(41647, 27162, 1, 41646, 'https://music.apple.com/us/album/string-quartet-no-47-in-b-flat-major-op-55-no-3-hob-iii-62-i-vivace-assai/295538611?i=295539386'),
(41648, 27162, 2, 41646, 'https://music.apple.com/us/album/string-quartet-no-47-in-b-flat-major-op-55-no-3-hob-iii-62-ii-adagio-ma-non-troppo/295538611?i=295539388'),
(41649, 27162, 3, 41646, 'https://music.apple.com/us/album/string-quartet-no-47-in-b-flat-major-op-55-no-3-hob-iii-62-iii-menuetto/295538611?i=295539384'),
(41650, 27162, 4, 41646, 'https://music.apple.com/us/album/string-quartet-no-47-in-b-flat-major-op-55-no-3-hob-iii-62-iv-finale-presto/295538611?i=295539380'),
(45186, 28738, 1, NULL, 'https://music.apple.com/us/album/trio-sonata-no-1-in-g-minor-rv-73-i-preludio-grave/969394731?i=969394737'),
(45187, 28738, 1, 45186, 'https://music.apple.com/us/album/trio-sonata-no-1-in-g-minor-rv-73-i-preludio-grave/969394731?i=969394737'),
(45188, 28738, 2, 45186, 'https://music.apple.com/us/album/trio-sonata-no-1-in-g-minor-rv-73-ii-allemanda-allegro/969394731?i=969394738'),
(45189, 28738, 3, 45186, 'https://music.apple.com/us/album/trio-sonata-no-1-in-g-minor-rv-73-iii-adagio/969394731?i=969394739'),
(45190, 28738, 4, 45186, 'https://music.apple.com/us/album/trio-sonata-no-1-in-g-minor-rv-73-iv-capriccio-allegro/969394731?i=969394740'),
(45191, 28738, 5, 45186, 'https://music.apple.com/us/album/trio-sonata-no-1-in-g-minor-rv-73-v-gavotta-allegro/969394731?i=969394742'),
(45192, 28738, 2, NULL, 'https://music.apple.com/us/album/trio-sonata-no-2-in-e-minor-rv-67-i-grave/969394731?i=969396023'),
(45193, 28738, 1, 45192, 'https://music.apple.com/us/album/trio-sonata-no-2-in-e-minor-rv-67-i-grave/969394731?i=969396023'),
(45194, 28738, 2, 45192, 'https://music.apple.com/us/album/trio-sonata-no-2-in-e-minor-rv-67-ii-corrente-allegro/969394731?i=969396027'),
(45195, 28738, 3, 45192, 'https://music.apple.com/us/album/trio-sonata-no-2-in-e-minor-rv-67-iii-giga-allegro/969394731?i=969396129'),
(45196, 28738, 4, 45192, 'https://music.apple.com/us/album/trio-sonata-no-2-in-e-minor-rv-67-iv-gavotta-allegro/969394731?i=969396132'),
(45197, 28738, 3, NULL, 'https://music.apple.com/us/album/trio-sonata-no-3-in-c-major-rv-61-i-adagio/969394731?i=969395393'),
(45198, 28738, 1, 45197, 'https://music.apple.com/us/album/trio-sonata-no-3-in-c-major-rv-61-i-adagio/969394731?i=969395393'),
(45199, 28738, 2, 45197, 'https://music.apple.com/us/album/trio-sonata-no-3-in-c-major-rv-61-ii-allemanda-allegro/969394731?i=969395398'),
(45200, 28738, 3, 45197, 'https://music.apple.com/us/album/trio-sonata-no-3-in-c-major-rv-61-iii-adagio/969394731?i=969395538'),
(45201, 28738, 4, 45197, 'https://music.apple.com/us/album/trio-sonata-no-3-in-c-major-rv-61-iv-sarabanda-allegro/969394731?i=969395540'),
(45202, 28738, 4, NULL, 'https://music.apple.com/us/album/trio-sonata-no-4-in-e-major-rv-66-i-largo/969394731?i=969395547'),
(45203, 28738, 1, 45202, 'https://music.apple.com/us/album/trio-sonata-no-4-in-e-major-rv-66-i-largo/969394731?i=969395547'),
(45204, 28738, 2, 45202, 'https://music.apple.com/us/album/trio-sonata-no-4-in-e-major-rv-66-ii-allegro-adagio/969394731?i=969395554'),
(45205, 28738, 3, 45202, 'https://music.apple.com/us/album/trio-sonata-no-4-in-e-major-rv-66-iii-allemanda-allegro/969394731?i=969395594'),
(45206, 28738, 4, 45202, 'https://music.apple.com/us/album/trio-sonata-no-4-in-e-major-rv-66-iv-sarabanda-largo/969394731?i=969395690'),
(45207, 28738, 5, 45202, 'https://music.apple.com/us/album/trio-sonata-no-4-in-e-major-rv-66-v-giga-allegro/969394731?i=969395693'),
(45208, 28738, 5, NULL, 'https://music.apple.com/us/album/trio-sonata-no-5-in-f-major-rv-69-i-preludio-largo/969394731?i=969394897'),
(45209, 28738, 1, 45208, 'https://music.apple.com/us/album/trio-sonata-no-5-in-f-major-rv-69-i-preludio-largo/969394731?i=969394897'),
(45210, 28738, 2, 45208, 'https://music.apple.com/us/album/trio-sonata-no-5-in-f-major-rv-69-ii-allemanda-presto/969394731?i=969394900'),
(45211, 28738, 3, 45208, 'https://music.apple.com/us/album/trio-sonata-no-5-in-f-major-rv-69-iii-corrente-allegro/969394731?i=969394902'),
(45212, 28738, 4, 45208, 'https://music.apple.com/us/album/trio-sonata-no-5-in-f-major-rv-69-iv-gavotta-presto/969394731?i=969394904'),
(45213, 28738, 6, NULL, 'https://music.apple.com/us/album/trio-sonata-no-6-in-d-major-rv-62-i-preludio-grave/969394731?i=969395199'),
(45214, 28738, 1, 45213, 'https://music.apple.com/us/album/trio-sonata-no-6-in-d-major-rv-62-i-preludio-grave/969394731?i=969395199'),
(45215, 28738, 2, 45213, 'https://music.apple.com/us/album/trio-sonata-no-6-in-d-major-rv-62-ii-corrente-allegro/969394731?i=969395201'),
(45216, 28738, 3, 45213, 'https://music.apple.com/us/album/trio-sonata-no-6-in-d-major-rv-62-iii-adagio/969394731?i=969395202'),
(45217, 28738, 4, 45213, 'https://music.apple.com/us/album/trio-sonata-no-6-in-d-major-rv-62-iv-allemanda-allegro/969394731?i=969395203'),
(45218, 28738, 7, NULL, 'https://music.apple.com/us/album/trio-sonata-no-7-in-e-flat-major-rv-65-i-preludio-largo/969394731?i=969395385'),
(45219, 28738, 1, 45218, 'https://music.apple.com/us/album/trio-sonata-no-7-in-e-flat-major-rv-65-i-preludio-largo/969394731?i=969395385'),
(45220, 28738, 2, 45218, 'https://music.apple.com/us/album/trio-sonata-no-7-in-e-flat-major-rv-65-ii-allemanda-allegro/969394731?i=969395387'),
(45221, 28738, 3, 45218, 'https://music.apple.com/us/album/trio-sonata-no-7-in-e-flat-major-rv-65-iii-sarabanda-andante/969394731?i=969395388'),
(45222, 28738, 4, 45218, 'https://music.apple.com/us/album/trio-sonata-no-7-in-e-flat-major-rv-65-iv-giga-presto/969394731?i=969395391'),
(45223, 28738, 8, NULL, 'https://music.apple.com/us/album/trio-sonata-no-8-in-d-minor-rv-64-i-preludio-largo/969394731?i=969394840'),
(45224, 28738, 1, 45223, 'https://music.apple.com/us/album/trio-sonata-no-8-in-d-minor-rv-64-i-preludio-largo/969394731?i=969394840'),
(45225, 28738, 2, 45223, 'https://music.apple.com/us/album/trio-sonata-no-8-in-d-minor-rv-64-ii-corrente-allegro/969394731?i=969394842'),
(45226, 28738, 3, 45223, 'https://music.apple.com/us/album/trio-sonata-no-8-in-d-minor-rv-64-iii-grave/969394731?i=969394849'),
(45227, 28738, 4, 45223, 'https://music.apple.com/us/album/trio-sonata-no-8-in-d-minor-rv-64-iv-giga-allegro/969394731?i=969394864'),
(45228, 28738, 9, NULL, 'https://music.apple.com/us/album/trio-sonata-no-9-in-a-major-rv-75-i-preludio-allegro/969394731?i=969395207'),
(45229, 28738, 1, 45228, 'https://music.apple.com/us/album/trio-sonata-no-9-in-a-major-rv-75-i-preludio-allegro/969394731?i=969395207'),
(45230, 28738, 2, 45228, 'https://music.apple.com/us/album/trio-sonata-no-9-in-a-major-rv-75-ii-adagio/969394731?i=969395209'),
(45231, 28738, 3, 45228, 'https://music.apple.com/us/album/trio-sonata-no-9-in-a-major-rv-75-iii-allemanda-allegro/969394731?i=969395210'),
(45232, 28738, 4, 45228, 'https://music.apple.com/us/album/trio-sonata-no-9-in-a-major-rv-75-iv-corrente-presto/969394731?i=969395212'),
(45233, 28738, 10, NULL, 'https://music.apple.com/us/album/trio-sonata-no-10-in-b-flat-major-rv-78-i-preludio-adagio/969394731?i=969394907'),
(45234, 28738, 1, 45233, 'https://music.apple.com/us/album/trio-sonata-no-10-in-b-flat-major-rv-78-i-preludio-adagio/969394731?i=969394907'),
(45235, 28738, 2, 45233, 'https://music.apple.com/us/album/trio-sonata-no-10-in-b-flat-major-rv-78-ii-allemanda-allegro/969394731?i=969394909'),
(45236, 28738, 3, 45233, 'https://music.apple.com/us/album/trio-sonata-no-10-in-b-flat-major-rv-78-iii-gavotta-presto/969394731?i=969395032'),
(45237, 28738, 11, NULL, 'https://music.apple.com/us/album/trio-sonata-no-11-in-b-minor-rv-79-i-preludio-andante/969394731?i=969395700'),
(45238, 28738, 1, 45237, 'https://music.apple.com/us/album/trio-sonata-no-11-in-b-minor-rv-79-i-preludio-andante/969394731?i=969395700'),
(45239, 28738, 2, 45237, 'https://music.apple.com/us/album/trio-sonata-no-11-in-b-minor-rv-79-ii-corrente-allegro/969394731?i=969395946'),
(45240, 28738, 3, 45237, 'https://music.apple.com/us/album/trio-sonata-no-11-in-b-minor-rv-79-iii-giga-allegro/969394731?i=969396006'),
(45241, 28738, 4, 45237, 'https://music.apple.com/us/album/trio-sonata-no-11-in-b-minor-rv-79-iv-gavotta-presto/969394731?i=969396018');

UPDATE piece_parts part
JOIN tmp_part_apple link
    ON link.part_id = part.id
    AND link.piece_id = part.piece_id
    AND link.sequence_number = part.sequence_number
    AND part.parent_part_id <=> link.parent_part_id
SET part.apple_music_url = link.url
WHERE part.apple_music_url IS NULL;

DROP TEMPORARY TABLE tmp_part_apple;
