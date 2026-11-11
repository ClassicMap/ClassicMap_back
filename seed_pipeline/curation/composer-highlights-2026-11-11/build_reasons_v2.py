# ruff: noqa: E501 — SQL 머리 주석과 값 줄은 한 줄로 둔다.
"""reasons_v2.json 으로 「처음 듣는다면」 카드 이유를 다시 쓰는 마이그레이션을 만든다.

- 이유는 '무슨 곡인지'가 아니라 처음 듣는 사람이 붙잡을 지점(첫 소리, 귀에 익은 선율, 쓰인 곳, 짜임)을 짚는다.
- 자동 초안 줄(source auto)만 고친다. 사람이 고른 줄(source editor)은 건드리지 않는다.
- 작품 id 로 찾고, 같은 작품이 두 작곡가에게 걸리면 멈춘다.

사용: python3 build_reasons_v2.py --drafts drafts.jsonl --reasons reasons_v2.json --out <마이그레이션 파일>
"""

import argparse
import json
from pathlib import Path
from typing import TypedDict


class Draft(TypedDict):
    composer_id: int
    piece_id: int


def sql_text(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--drafts", type=Path, required=True)
    parser.add_argument("--reasons", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    args = parser.parse_args()

    drafts: list[Draft] = [
        json.loads(line)
        for line in args.drafts.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    composer_by_piece: dict[int, int] = {}
    for draft in drafts:
        if draft["piece_id"] in composer_by_piece:
            raise ValueError(f"작품이 두 번 나와요: {draft['piece_id']}")
        composer_by_piece[draft["piece_id"]] = draft["composer_id"]

    reasons: dict[str, list[str]] = json.loads(args.reasons.read_text(encoding="utf-8"))
    statements: list[str] = []
    for piece_key, pair in sorted(
        reasons.items(), key=lambda item: (composer_by_piece[int(item[0])], int(item[0]))
    ):
        piece = int(piece_key)
        reason, reason_en = pair
        if not reason or not reason_en:
            raise ValueError(f"이유가 비었어요: {piece}")
        if len(reason) > 255 or len(reason_en) > 255:
            raise ValueError(f"이유가 너무 길어요: {piece}")
        statements.append(
            f"UPDATE composer_highlights SET reason = {sql_text(reason)}, reason_en = {sql_text(reason_en)} "
            f"WHERE composer_id = {composer_by_piece[piece]} AND piece_id = {piece} AND source = 'auto';"
        )

    lines = [
        "-- 「처음 듣는다면」 카드 이유를 다시 쓴다(공개 435곡 전부).",
        "-- 무슨 곡인지 풀이하던 문장을, 처음 듣는 사람이 붙잡을 지점(첫 소리·귀에 익은 선율·쓰인 곳·짜임)을 짚는 문장으로 바꾼다.",
        "-- 'N곡 가운데 가장 많이 녹음된 곡'(MusicBrainz 녹음 수) 문구도 이걸로 없어진다.",
        "-- 원본은 seed_pipeline/curation/composer-highlights-2026-11-11/reasons_v2.json, 만든 스크립트는 build_reasons_v2.py.",
        "-- 자동 초안 줄(source auto)만 고친다. 사람이 고른 줄은 건드리지 않는다.",
        "",
        *statements,
        "",
    ]
    args.out.write_text("\n".join(lines), encoding="utf-8")
    print(json.dumps({"updated": len(statements)}))


if __name__ == "__main__":
    main()
