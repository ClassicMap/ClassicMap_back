# ruff: noqa: E501 — 한국어 설명과 원어 문장부호를 그대로 둔다.
"""옛 작품 링크 바로잡기(fixes.tsv)와, 작품 링크는 있는데 안 곡 링크가 빈 작품의 안 곡 채우기.

1. 작품 링크: fixes.tsv(작품, 서비스, 앨범 id, 트랙 id, 까닭)를 지금 운영 값(top.tsv)과 견줘
   비어 있으면 채우고(fill), 값이 있으면 바꾼다(replace, 지금 값이 그대로일 때만). 주소는 받아 둔 앨범 트랙에서 만든다.
2. 안 곡: 작품의 앨범(바꾸면 새 앨범)의 전체 트랙에 ../new-catalog-links-2026-11-12/pick.match_parts
   (match.py 의 match_set·match_children 과 이름이 어긋나는 짝 거르기)를 돌린다. 곡마다 제 작품번호가 있는
   묶음(타펠무지크 「TWV 55:e1」「TWV 43:G2」…, 파리 사중주)은 그 번호의 트랙 안에서 악장을 한 번 더 맞춘다.
   - 먼저 앨범이 작품을 다 담았는지 본다: pick.evaluate 가 exact·more 이거나, 맨 위 곡의 8할 이상이 맞는다.
     아니면 채우지 않고 incomplete 로 적는다.
   - 빈 곡은 채우고, 작품 링크를 바꾼 서비스에서 옛 앨범 트랙을 가리키던 곡은 새 트랙으로 바꾼다(옛 값이 그대로일 때만).
결과: <작업 폴더>/decisions.jsonl

사용: uv run python fix.py <작업 폴더>(top.tsv, parts.tsv, apple_albums/, spotify_albums/)
      uv run python fix.py <작업 폴더> fixes-0603.tsv decisions-0603.jsonl   (두 번째 묶음: 그 파일의 작품·서비스만)
"""

from __future__ import annotations

import importlib.util
import json
import os
import re
import sys
from collections import defaultdict
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
NEW = os.path.join(os.path.dirname(HERE), "new-catalog-links-2026-11-12")


def load_module(name: str, path: str) -> Any:
    if os.path.dirname(path) not in sys.path:
        sys.path.insert(0, os.path.dirname(path))
    if name in sys.modules:
        return sys.modules[name]
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec and spec.loader
    module: Any = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


common: Any = load_module("common", os.path.join(NEW, "common.py"))
pick: Any = load_module("pick", os.path.join(NEW, "pick.py"))
read_tsv = common.read_tsv

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}
PART_COLUMN = {"apple": "part_apple", "spotify": "part_spotify"}
OWN = re.compile(r"\bTWV\s*\d+\s*:\s*[A-Za-z]*\s*\d+")


def album_id_of(url: str, service: str) -> str | None:
    if service == "apple":
        m = re.search(r"/album/(?:[^/?]*/)?(\d{6,})", url)
    else:
        m = re.search(r"open\.spotify\.com/album/([A-Za-z0-9]{22})", url)
    return m.group(1) if m else None


def fixed_url(work: str, fix: dict[str, str]) -> tuple[str, list[dict[str, Any]]]:
    """fixes.tsv 한 줄의 새 주소(트랙 id 가 있으면 트랙, 없으면 앨범)와 그 앨범 트랙."""
    tracks = pick.full_tracks(work, fix["service"], fix["album_id"]) or []
    if not tracks:
        raise SystemExit(f"앨범 트랙이 없다: {fix['service']} {fix['album_id']}")
    if fix["track_id"]:
        hit = next(t for t in tracks if str(t.get("trackId")) == fix["track_id"])
        return pick.track_url(hit), tracks
    return pick.album_url(tracks[0]), tracks


def match_own(
    parts: list[dict[str, str]], tracks: list[dict[str, Any]]
) -> dict[int, tuple[str, str, str]]:
    """곡마다 제 작품번호(「TWV 55:e1」)가 있는 묶음: 그 번호가 적힌 트랙 안에서 곡 안 곡을 악장 번호·이름으로 맞추고,
    곡에는 첫 악장 트랙을, 악장이 없는 곡(「Conclusion, TWV 50:5」)에는 하나뿐인 그 번호 트랙을 준다."""
    out: dict[int, tuple[str, str, str]] = {}
    children_of: dict[str, list[dict[str, str]]] = defaultdict(list)
    for p in parts:
        if p["parent_part_id"]:
            children_of[p["parent_part_id"]].append(p)
    for top in (p for p in parts if not p["parent_part_id"]):
        own = OWN.search(top["name_en"])
        if not own:
            continue
        cat = pick.catalogue_regex(own.group(0))
        if not cat:
            continue
        sub = [t for t in tracks if re.search(cat, pick.match.norm(str(t.get("trackName", ""))))]
        kids = sorted(
            (
                pick.match.with_movement(dict(c, catalogue=own.group(0)))
                for c in children_of.get(top["part_id"], [])
            ),
            key=lambda r: int(r["seq"]),
        )
        if not kids:
            if len(sub) == 1:
                out[int(top["part_id"])] = (
                    pick.match.track_url(sub[0]),
                    str(sub[0].get("trackName", "")),
                    "own",
                )
            continue
        found = pick.match.match_set(kids, sub)
        for part_id, hit in found.items():
            out[part_id] = (hit[0], hit[1], f"own-{hit[2]}")
        first = int(kids[0]["part_id"])
        if first in found:
            out[int(top["part_id"])] = (found[first][0], found[first][1], "own-first")
    return out


def match_all(
    row: dict[str, str], parts: list[dict[str, str]], tracks: list[dict[str, Any]], service: str
) -> dict[int, tuple[str, str, str]]:
    """pick.match_parts 에 더해 셋을 더 본다. 더한 짝도 이름이 어긋나거나 한 곡의 뒷부분이면 버린다.
    - 곡마다 제 작품번호가 있는 묶음(match_own)
    - 악장 번호 칸이 있는데 트랙은 「Z.570: No. 1 in D Minor, Ouverture」처럼 No. 로 적은 앨범: 악장 칸을 비우고 번호로
    - 트랙에 작품번호가 없는 앨범(「Symphony No. 3 in G "The Great National"」): 조성을 뗀 본제목 구절을 작품번호처럼"""
    found: dict[int, tuple[str, str, str]] = pick.match_parts(
        service, parts, tracks, row["catalogue"]
    )
    existing = PART_COLUMN[service]
    by_id = {int(p["part_id"]): p for p in parts}
    extra: dict[int, tuple[str, str, str]] = dict(match_own(parts, tracks))
    tops = sorted((p for p in parts if not p["parent_part_id"]), key=lambda p: int(p["seq"]))
    cat = row["catalogue"]
    if tops and any(p["movement"].strip() for p in tops):
        cleared = [dict(p, movement="", catalogue=cat) for p in tops]
        for pid, hit in pick.match.match_set(cleared, tracks).items():
            extra.setdefault(pid, (hit[0], hit[1], f"number-{hit[2]}"))
    cat_re = (
        pick.catalogue_regex(cat) if cat and not pick.RANGE.search(pick.match.norm(cat)) else None
    )
    names = [pick.match.norm(str(t.get("trackName", ""))) for t in tracks]
    if tops and not (cat_re and any(re.search(cat_re, n) for n in names)):
        core = pick.match.KEY_EN.sub(
            " ", pick.match.norm(pick.pick_row(row)["title_en"].split(",", 1)[0])
        )
        core = " ".join(core.replace('"', " ").split()).strip(" ,.")
        if len(core.split()) >= 2:
            pattern = re.escape(core).replace(r"\ ", r"\s*") + r"(?![\d])"
            rows = [dict(p, catalogue="") for p in tops]
            for pid, hit in pick.match.match_set(rows, tracks, pattern).items():
                extra.setdefault(pid, (hit[0], hit[1], f"title-{hit[2]}"))
    for pid, hit in extra.items():
        part = by_id.get(pid)
        if not part or pid in found or part[existing]:
            continue
        if pick.names_disagree(part, (hit[0], hit[1], "movement")) or pick.later_section(part, hit):
            continue
        found[pid] = hit
    return found


def in_order(
    parts: list[dict[str, str]],
    found: dict[int, tuple[str, str, str]],
    tracks: list[dict[str, Any]],
) -> dict[int, tuple[str, str, str]]:
    """같은 곡 안의 악장(같은 부모 아래, 맨 위 곡이 악장이면 맨 위 곡끼리)은 앨범에서도 차례로 놓여야 한다.
    앞 악장보다 앞 트랙을 가리키는 짝은 버린다. 괴벨판 타펠무지크 Spotify 에서 플루트 소나타 IV. Allegro 가
    「TWV 41:h4」로 잘못 적힌 트리오 IV. Allegro(앞 트랙)에 붙던 일을 막는다.
    서로 다른 곡(부모와 그 첫 곡은 빼고)이 같은 트랙을 가리키면 둘 다 버린다."""
    position = {pick.match.track_url(t): i for i, t in enumerate(tracks)}
    groups: dict[str, list[dict[str, str]]] = defaultdict(list)
    for p in parts:
        groups[p["parent_part_id"]].append(p)
    tops = groups.get("", [])
    movement_tops = bool(tops) and all(
        p["movement"].strip() or re.match(r"^\s*[IVXL]+\.\s", p["name_en"].rsplit(": ", 1)[-1])
        for p in tops
    )
    drop: set[int] = set()
    for parent, members in groups.items():
        if parent == "" and not movement_tops:
            continue
        last = -1
        for p in sorted(members, key=lambda m: int(m["seq"])):
            hit = found.get(int(p["part_id"]))
            where = position.get(hit[0]) if hit else None
            if where is None:
                continue
            if where <= last:
                drop.add(int(p["part_id"]))
                continue
            last = where
    parent_of = {int(p["part_id"]): p["parent_part_id"] for p in parts}
    by_url: dict[str, list[int]] = defaultdict(list)
    for pid, hit in found.items():
        by_url[hit[0]].append(pid)
    for pids in by_url.values():
        family = {pid for pid in pids if parent_of.get(pid) and int(parent_of[pid]) in pids}
        rest = [
            pid
            for pid in pids
            if pid not in family and not any(parent_of.get(o) == str(pid) for o in pids)
        ]
        if len(rest) > 1:
            drop.update(rest)
    return {pid: hit for pid, hit in found.items() if pid not in drop}


def linked(
    part: dict[str, str], found: dict[int, tuple[str, str, str]], album: str, service: str
) -> bool:
    """이번에 맞은 곡이거나, 이미 이 앨범 트랙을 가리키는 곡(0502 가 붙인 타펠무지크 Apple 안 곡)."""
    return int(part["part_id"]) in found or bool(album and album in part[PART_COLUMN[service]])


def complete(row: dict[str, str], tracks: list[dict[str, Any]]) -> tuple[bool, str]:
    """트랙 이름으로 센 작품 트랙이 곡 수 이상인가(pick.evaluate 의 exact·more).
    제목이 다른 말로 적힌 앨범(「Transfigured Night, Op. 4」 ↔ 「Verklärte Nacht」)은 작품번호가 적힌 트랙 수로도 센다."""
    found, _ = pick.evaluate(row, tracks)
    if found and found["status"] in ("exact", "more"):
        return True, f"{found['status']} {found['workTracks']}"
    cat = row["catalogue"]
    cat_re = (
        pick.catalogue_regex(cat) if cat and not pick.RANGE.search(pick.match.norm(cat)) else None
    )
    want = int(row.get("leaves") or row["nparts"] or 0)
    if cat_re and want:
        n = sum(
            1 for t in tracks if re.search(cat_re, pick.match.norm(str(t.get("trackName", ""))))
        )
        if n >= want:
            return True, f"catalogue {n}/{want}"
    return False, (f"{found['status']} {found['workTracks']}" if found else "no-work-tracks")


def main() -> None:
    work = sys.argv[1]
    # 두 번째 묶음(0603): fix.py <작업 폴더> fixes-0603.tsv decisions-0603.jsonl — 그 파일에 적은 작품·서비스만 본다
    fixes_file = sys.argv[2] if len(sys.argv) > 2 else "fixes.tsv"
    out_name = sys.argv[3] if len(sys.argv) > 3 else "decisions.jsonl"
    only = fixes_file != "fixes.tsv"
    rows = {r["piece_id"]: r for r in pick.load_rows(work)}
    parts_of: dict[str, list[dict[str, str]]] = defaultdict(list)
    for part in read_tsv(os.path.join(work, "parts.tsv")):
        parts_of[part["piece_id"]].append(part)
    fixes = {(f["piece_id"], f["service"]): f for f in read_tsv(os.path.join(HERE, fixes_file))}
    out: list[dict[str, Any]] = []
    for piece_id, row in rows.items():
        for service in ("apple", "spotify"):
            col = COLUMN[service]
            old = row[col]
            fix = fixes.get((piece_id, service))
            if only and not fix:
                continue
            old_album = album_id_of(old, service) if old else None
            if fix:
                new, tracks = fixed_url(work, fix)
                out.append(
                    {
                        "kind": "piece",
                        "pieceId": int(piece_id),
                        "composerId": int(row["composer_id"]),
                        "title": row["title_en"],
                        "service": service,
                        "decision": "replace" if old else "fill",
                        "old": old or None,
                        "new": new,
                        "albumName": str(tracks[0].get("collectionName", "")),
                        "why": fix["why"],
                    }
                )
            else:
                tracks = (pick.full_tracks(work, service, old_album) or []) if old_album else []
            parts = parts_of.get(piece_id, [])
            if not parts:
                continue
            if not tracks:
                out.append(
                    {
                        "kind": "incomplete",
                        "pieceId": int(piece_id),
                        "title": row["title_en"],
                        "service": service,
                        "why": "작품 링크가 앨범이 아니거나 트랙을 못 받음",
                        "album": old,
                    }
                )
                continue
            album_name = str(tracks[0].get("collectionName", ""))
            # 작품 링크로 이미 고른(사람이 넣었거나 이번에 고른) 앨범이라 작곡가 표기 거르기(요한 슈타미츠의 「Johann」)는 앨범 이름으로 믿는다
            row = dict(row, trusted=pick.match.norm(album_name))
            replace_ok = bool(fix and old_album)
            base = [dict(p, **{PART_COLUMN[service]: ""}) for p in parts] if replace_ok else parts
            found = in_order(base, match_all(row, base, tracks, service), tracks)
            ok, why = complete(row, tracks)
            # 트랙 이름으로 작품 트랙을 다 못 세는 앨범(타펠무지크처럼 곡마다 번호가 다른 묶음, 악장 이름만 적힌 앨범)은
            # 맨 위 곡의 8할 이상(그 곡이나 그 안 곡)이 맞으면 다 든 것으로 본다. 반만 든 「Vol. 1」은 여기서 걸린다
            tops = [p for p in parts if not p["parent_part_id"]]
            this_album = album_id_of(pick.album_url(tracks[0]), service) or ""

            covered = sum(
                1
                for t in tops
                if linked(t, found, this_album, service)
                or any(
                    linked(c, found, this_album, service)
                    for c in parts
                    if c["parent_part_id"] == t["part_id"]
                )
            )
            if not ok and tops and covered >= 0.8 * len(tops):
                ok, why = True, f"coverage {covered}/{len(tops)}"
            if not ok:
                out.append(
                    {
                        "kind": "incomplete",
                        "pieceId": int(piece_id),
                        "title": row["title_en"],
                        "service": service,
                        "why": why,
                        "album": album_name,
                    }
                )
                continue
            for part in parts:
                pid = int(part["part_id"])
                hit = found.get(pid)
                if not hit:
                    continue
                current = part[PART_COLUMN[service]]
                if not current:
                    decision = "fill"
                elif replace_ok and old_album and old_album in current and current != hit[0]:
                    decision = "replace"
                else:
                    continue
                out.append(
                    {
                        "kind": "part",
                        "pieceId": int(piece_id),
                        "partId": pid,
                        "parentPartId": int(part["parent_part_id"])
                        if part["parent_part_id"]
                        else None,
                        "name": (part["name_en"] or part["name_ko"])[-80:],
                        "service": service,
                        "decision": decision,
                        "old": current or None,
                        "new": hit[0],
                        "track": hit[1][-100:],
                        "rule": hit[2],
                        "album": album_name,
                        "albumCheck": why,
                    }
                )
    with open(os.path.join(work, out_name), "w", encoding="utf-8") as handle:
        for item in out:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    counts: dict[str, int] = defaultdict(int)
    for item in out:
        counts[f"{item['kind']} {item['service']} {item.get('decision', '')}".strip()] += 1
    for key in sorted(counts):
        print(key, counts[key])


if __name__ == "__main__":
    main()
