"""남은 seed 정리용 SQL 조각. 모두 가드가 있어 두 번 넣어도 바뀌지 않는다."""

from collections.abc import Iterable

SEED_GUARD = "piece.origin = 'seed' AND piece.editor_locked = 0"
NOT_PINNED = (
    "NOT EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = piece.id)\n"
    "  AND NOT EXISTS (SELECT 1 FROM piece_parts linking WHERE linking.linked_piece_id = piece.id)"
)


def q(value: str | int | None) -> str:
    if value is None:
        return "NULL"
    if isinstance(value, int):
        return str(value)
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def hide(composer_id: int, piece_ids: Iterable[int], why: str) -> str:
    ids = sorted(set(piece_ids))
    if not ids:
        return ""
    chunks = ",\n    ".join(
        ", ".join(str(pid) for pid in ids[i : i + 20]) for i in range(0, len(ids), 20)
    )
    return f"""-- {why} seed {len(ids)}개를 목록에서 숨긴다(지우지 않음).
UPDATE pieces piece
SET piece.hidden_reason = 'catalog_unmatched'
WHERE piece.composer_id = {composer_id} AND piece.hidden_reason IS NULL AND {SEED_GUARD}
  AND piece.id IN (
    {chunks}
  )
  AND {NOT_PINNED};
"""


def link_existing_part(
    composer_id: int,
    piece_id: int,
    part_key: str,
    seed_id: int,
    title: str,
    title_en: str,
) -> str:
    """기존 작품의 비어 있는 part 에 seed 를 잇고, seed 제목을 「<작품> 중 "<곡>"」으로 바꾼다.

    part 가 이미 다른 작품을 가리키면 잇지 않고, 그때는 seed 제목도 그대로 둔다.
    """
    seed_ok = (
        f"(SELECT seed.id FROM pieces seed WHERE seed.id = {seed_id}"
        f" AND seed.composer_id = {composer_id} AND seed.origin = 'seed')"
    )
    return f"""UPDATE piece_parts part
JOIN pieces owner ON owner.id = part.piece_id
SET part.linked_piece_id = {seed_ok}
WHERE owner.id = {piece_id} AND owner.composer_id = {composer_id}
  AND part.part_key = {q(part_key)} AND part.linked_piece_id IS NULL;

UPDATE pieces piece
SET piece.title = {q(title[:300])}, piece.title_en = {q(title_en[:300])}, piece.editor_locked = 1
WHERE piece.id = {seed_id} AND piece.composer_id = {composer_id} AND {SEED_GUARD}
  AND EXISTS (
    SELECT 1 FROM piece_parts part
    WHERE part.piece_id = {piece_id} AND part.part_key = {q(part_key)}
      AND part.linked_piece_id = piece.id
  );
"""


def set_genre(composer_id: int, title: str, genre: str, form_key: str) -> str:
    """새로 넣은 작품(manual, 제목으로 찾음)에 장르·형식이 비어 있으면 채운다."""
    return f"""UPDATE pieces piece
SET piece.genre = {q(genre)}, piece.form_key = {q(form_key)}
WHERE piece.composer_id = {composer_id} AND piece.title = {q(title)} AND piece.origin = 'manual'
  AND piece.genre IS NULL AND piece.form_key IS NULL;
"""
