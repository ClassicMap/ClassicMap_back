"""genres.jsonl 을 장르 채움 마이그레이션 본문으로 바꾼다.

    python3 gen_sql.py > ../../../migrations/202611072002_fill_comparison_piece_genres.sql
"""

import json
import sys
from collections import defaultdict
from pathlib import Path

GENRES = ("symphony", "concerto", "piano", "chamber", "orchestral", "stage", "vocal")


def main() -> int:
    source = Path(__file__).with_name("genres.jsonl")
    by_genre: dict[str, list[int]] = defaultdict(list)
    seen: set[int] = set()
    for number, line in enumerate(source.read_text(encoding="utf-8").splitlines(), start=1):
        row = json.loads(line)
        piece_id = row["pieceId"]
        genre = row["genre"]
        if not isinstance(piece_id, int) or piece_id <= 0:
            print(f"{number}행: pieceId 가 양의 정수가 아님", file=sys.stderr)
            return 2
        if genre not in GENRES:
            print(f"{number}행: 모르는 장르 {genre!r}", file=sys.stderr)
            return 2
        if piece_id in seen:
            print(f"{number}행: pieceId {piece_id} 가 두 번 나옴", file=sys.stderr)
            return 2
        seen.add(piece_id)
        by_genre[genre].append(piece_id)

    out = sys.stdout
    out.write("-- 비교 작품 장르 채우기. seed_pipeline/curation/piece-genres-2026-11-07/gen_sql.py 가 만든다.\n")
    out.write(f"-- 원본: genres.jsonl ({len(seen)}곡). 손으로 고치지 말고 원본을 고쳐 새 마이그레이션을 만든다.\n")
    for genre in GENRES:
        ids = sorted(by_genre.get(genre, []))
        if not ids:
            continue
        out.write(f"\n-- {genre} {len(ids)}곡\n")
        out.write(f"UPDATE pieces SET genre = '{genre}' WHERE id IN (\n")
        chunks = [ids[index : index + 12] for index in range(0, len(ids), 12)]
        out.write(",\n".join("    " + ", ".join(str(value) for value in chunk) for chunk in chunks))
        out.write("\n);\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
