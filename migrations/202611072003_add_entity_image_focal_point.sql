-- 배너처럼 잘라 쓰는 그림에서 얼굴이 오게 할 초점. CSS object-position 값("50% 30%")을 그대로 둔다.
-- 프로필 사진은 비워 둔다.
ALTER TABLE entity_images
    ADD COLUMN focal_point VARCHAR(16) NULL AFTER credit_line;
