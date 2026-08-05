-- MusicBrainz 작품은 같은 namespace의 식별자를 둘 이상 가질 수 있습니다.
-- namespace + external_id의 전역 소유권은 기존 unique key로 계속 보장합니다.

ALTER TABLE piece_identifiers
    DROP INDEX uq_piece_identifiers_piece_namespace,
    ADD UNIQUE KEY uq_piece_identifiers_piece_namespace_value (
        piece_id, namespace, external_id
    );
