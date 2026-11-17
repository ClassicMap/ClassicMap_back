# ruff: noqa: E501 — SQL 줄은 한 줄로 둔다.
"""비제·마스네 오페라의 대본 대목이 따로 작품 줄로 보이는 것(「Carmen: Act I. "…"」 꼴)을 숨긴다.

4차 자동 카탈로그(202610120064 등)가 오페라 작품과 그 part 를 만들면서, 같은 MusicBrainz work 를
낱개 작품으로도 넣었다. 작곡가 화면 맨 위에 대본 대목이 한 줄씩 흩어져 '기타'로 보인다.

- 오페라 작품의 보이는 part 와 MBID 가 같은 줄: 그 part 와 같은 곡이라 hidden_reason='duplicate'.
- MBID 가 다른 줄(독일어 「Die Perlenfischer」, 이탈리아어 「Manon」): MB 에서 원어 작품과 이어지지 않은
  번역판 work 다. 같은 번역판 전곡(11541 「Die Perlenfischer」)처럼 hidden_reason='catalog_unmatched'.

part 의 linked_piece_id 로 잇지 않는다. 이어진 part 는 화면에서 그 작품의 링크를 대신 쓰는데
(front features/composer/components/piece-row.tsx PiecePartRow), 대목 줄에는 링크가 없고 part 에는
곡별 Apple Music·Spotify 링크가 있어 오페라 안 곡의 링크가 사라진다.

숨김 SQL 은 그 줄을 가리키는 행(식별자 빼고)이 하나도 없을 때만 숨긴다. 식별자(MBID)는 part 수준
work 라 오페라 작품으로 옮기지 않고 숨긴 줄에 둔다.

사용(seed_pipeline 에서):
    uv run python curation/piece-genre-fill-2026-11-17/opera_excerpts.py --db <덤프 폴더> \\
        --parts <piece_parts.tsv> --out curation/piece-genre-fill-2026-11-17/opera_excerpts.json \\
        --migration ../migrations/202611170001_hide_opera_libretto_excerpt_rows.sql
<piece_parts.tsv> 는 ../catalog-wave6-2026-11-10/tools/dump.sh 가 만든다.
"""

import argparse
import csv
import json
import re
from collections import Counter
from pathlib import Path

csv.field_size_limit(10_000_000)

# (작곡가 id, 대목 제목 앞부분) → 같은 오페라 작품 id
OPERAS: dict[tuple[int, str], int] = {
    (44, "Carmen"): 193,
    (44, "Die Perlenfischer"): 33156,
    (62, "Cendrillon"): 8783,
    (62, "Manon"): 33216,
}
EXCERPT = re.compile(
    r"^(?P<opera>Carmen|Die Perlenfischer|Cendrillon|Manon)\s?: (Act|Akt|Acte|Atto) [IVX]+\. "
)
VISIBLE_PART = ("EDITOR_REVIEWED", "PUBLISHED")
# 숨기기 전에 비어 있어야 하는 참조(표, 칸). piece_identifiers 는 숨긴 줄에 그대로 둔다.
REFERENCES: list[tuple[str, str]] = [
    ("performance_sectors", "piece_id"),
    ("performances", "piece_id"),
    ("composer_highlights", "piece_id"),
    ("composer_major_pieces", "piece_id"),
    ("popular_comparisons", "piece_id"),
    ("screen_music_cues", "piece_id"),
    ("track_piece_links", "piece_id"),
    ("piece_aliases", "piece_id"),
    ("piece_instrumentation", "piece_id"),
    ("piece_reco_features", "piece_id"),
    ("piece_relations", "from_piece_id"),
    ("piece_relations", "to_piece_id"),
    ("piece_parts", "piece_id"),
    ("piece_parts", "linked_piece_id"),
    ("user_favorite_pieces", "piece_id"),
    ("user_taste_seed_pieces", "piece_id"),
    ("user_listening_events", "piece_id"),
]


def null(value: str | None) -> str:
    return "" if value in (None, "NULL") else str(value)


def read_tsv(path: Path) -> list[dict[str, str]]:
    with path.open(encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))


def q(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--db", type=Path, required=True)
    parser.add_argument("--parts", type=Path, required=True)
    parser.add_argument("--out", type=Path, required=True)
    parser.add_argument("--migration", type=Path, required=True)
    args = parser.parse_args()

    pieces = {int(r["id"]): r for r in read_tsv(args.db / "classify_input.tsv")}
    part_mbids: dict[int, dict[str, str]] = {}
    for part in read_tsv(args.parts):
        owner = int(part["piece_id"])
        if owner in OPERAS.values() and part["editorial_status"] in VISIBLE_PART:
            mbid = part["part_key"].removeprefix("musicbrainz:")
            part_mbids.setdefault(owner, {})[mbid] = part["id"]

    decisions: list[dict[str, object]] = []
    for pid, row in sorted(pieces.items()):
        cid = int(row["composer_id"])
        match = EXCERPT.match(null(row["title"]))
        if not match or (cid, match["opera"]) not in OPERAS:
            continue
        if (
            null(row["genre"])
            or null(row["form_key"])
            or int(row["linked_from"])
            or int(row["sec"])
        ):
            continue
        # 4차 자동이 만든 줄(origin='manual')만. 9/10 시드 줄(11443 「Carmen: Act II. Entr'acte…」)은 낱말 규칙이 다룬다
        if row["origin"] != "manual":
            continue
        opera = OPERAS[(cid, match["opera"])]
        if opera not in pieces:
            raise SystemExit(f"오페라 작품 {opera} 이 보이지 않음")
        mbids = [m for m in null(row["mbids"]).split(",") if m]
        same = [part_mbids.get(opera, {})[m] for m in mbids if m in part_mbids.get(opera, {})]
        if same:
            reason, why = "duplicate", f"오페라 {opera} 의 part {same[0]} 와 MBID 가 같음"
        else:
            reason, why = (
                "catalog_unmatched",
                f"오페라 {opera} 의 원어 part 와 이어지지 않은 번역판 MB work",
            )
        decisions.append(
            {
                "pieceId": pid,
                "composerId": cid,
                "title": null(row["title"]),
                "opera": opera,
                "operaTitle": null(pieces[opera]["title"]),
                "mbids": mbids,
                "partId": int(same[0]) if same else None,
                "hiddenReason": reason,
                "why": why,
            }
        )
    args.out.write_text(
        json.dumps(decisions, ensure_ascii=False, indent=1) + "\n", encoding="utf-8"
    )

    counts = Counter((d["operaTitle"], d["hiddenReason"]) for d in decisions)
    guards = "\n".join(
        f"  AND NOT EXISTS (SELECT 1 FROM {table} ref WHERE ref.{column} = piece.id)"
        for table, column in REFERENCES
    )
    lines = [
        "-- 비제·마스네 오페라 대본 대목이 따로 작품 줄로 보이던 것을 숨긴다(지우지 않음, 상세는 열림).",
        "-- 근거: seed_pipeline/curation/piece-genre-fill-2026-11-17/(README.md, opera_excerpts.py, opera_excerpts.json).",
        "--   duplicate: 오페라 작품의 보이는 part 와 MusicBrainz work 가 같은 줄(그 곡은 오페라 안 part 로 이미 보인다).",
        "--   catalog_unmatched: MB 에서 원어 작품과 이어지지 않은 번역판 work(같은 번역판 전곡 11541 선례).",
        "--   part 에 잇지 않는다: 이으면 part 의 곡별 링크 대신 링크 없는 이 줄의 링크를 써서 오페라 안 곡 링크가 사라진다.",
        "--   보이고, 갈래가 비고, 제목이 같고, 식별자 말고 이 줄을 가리키는 행이 없을 때만 숨긴다. 두 번 넣어도 같다.",
        f"-- 작품 {len(decisions)}줄: "
        + ", ".join(f"{t} {r} {n}" for (t, r), n in sorted(counts.items(), key=str)),
        "",
    ]
    for d in decisions:
        lines.append(
            f"UPDATE pieces piece SET piece.hidden_reason = {q(str(d['hiddenReason']))}\n"
            f"WHERE piece.id = {d['pieceId']} AND piece.composer_id = {d['composerId']} AND piece.title = {q(str(d['title']))}\n"
            "  AND piece.hidden_reason IS NULL AND piece.genre IS NULL AND piece.form_key IS NULL\n"
            "  AND piece.spotify_url IS NULL AND piece.apple_music_url IS NULL AND piece.youtube_music_url IS NULL\n"
            "  AND (piece.description IS NULL OR piece.description = '')\n"
            f"{guards};"
        )
    args.migration.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(len(decisions), dict(counts))


if __name__ == "__main__":
    main()
