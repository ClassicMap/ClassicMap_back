-- Wikidata authority entity는 같은 namespace의 유효한 외부 ID를 복수 보유할 수 있다.
-- namespace+external_id 전역 unique는 유지해 서로 다른 entity의 자동 병합은 계속 막는다.

ALTER TABLE external_identifiers
    ADD INDEX idx_external_identifiers_entity (authority_entity_id),
    DROP INDEX uq_external_identifiers_entity_namespace;
