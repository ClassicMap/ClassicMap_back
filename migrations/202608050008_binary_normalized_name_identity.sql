-- canonical natural key는 accent를 보존하므로 normalized identity도 binary 비교를 사용한다.
-- 동일 길이/nullability를 유지하고 기존 값의 binary 중복을 먼저 unique 임시표로 검증한다.

CREATE TEMPORARY TABLE tmp_entity_name_binary_identity (
    authority_entity_id CHAR(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    locale VARCHAR(35) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    name_kind VARCHAR(32) NOT NULL,
    normalized_value VARCHAR(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    UNIQUE KEY uq_tmp_entity_name_binary (
        authority_entity_id, locale, name_kind, normalized_value
    )
) ENGINE=InnoDB;

INSERT INTO tmp_entity_name_binary_identity (
    authority_entity_id, locale, name_kind, normalized_value
)
SELECT authority_entity_id, locale, name_kind, normalized_value
FROM entity_names;

DROP TEMPORARY TABLE tmp_entity_name_binary_identity;

ALTER TABLE entity_names
    DROP INDEX uq_entity_names_identity,
    MODIFY COLUMN normalized_value
        VARCHAR(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    ADD UNIQUE KEY uq_entity_names_identity (
        authority_entity_id, locale, name_kind, normalized_value
    );

CREATE TEMPORARY TABLE tmp_piece_alias_binary_identity (
    piece_id INT NOT NULL,
    locale VARCHAR(35) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    alias_kind VARCHAR(32) NOT NULL,
    normalized_value VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    UNIQUE KEY uq_tmp_piece_alias_binary (
        piece_id, locale, alias_kind, normalized_value(255)
    )
) ENGINE=InnoDB;

INSERT INTO tmp_piece_alias_binary_identity (
    piece_id, locale, alias_kind, normalized_value
)
SELECT piece_id, locale, alias_kind, normalized_value
FROM piece_aliases;

DROP TEMPORARY TABLE tmp_piece_alias_binary_identity;

ALTER TABLE piece_aliases
    DROP INDEX uq_piece_aliases_identity,
    MODIFY COLUMN normalized_value
        VARCHAR(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
    ADD UNIQUE KEY uq_piece_aliases_identity (
        piece_id, locale, alias_kind, normalized_value(255)
    );
