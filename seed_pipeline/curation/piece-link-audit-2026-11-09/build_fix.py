"""판정(audit.jsonl)과 새로 고른 앨범(picks-final.jsonl)으로 작품 링크를 바로잡는다.

결정(jsonl)과 마이그레이션 SQL, match.py 입력을 만든다.

작품마다(서비스마다):
- replace: 새 앨범이 작품 트랙을 곡 수 이상 담고(exact·more·kept), audit.judge 로 다시 봐도
  ok·loose·named 이다. 지금 링크가 트랙이면 새 앨범의 첫 작품 트랙으로 바꾼다.
  - 지금 링크가 틀림·없어짐이면, 앨범 이름이 이 작품을 가리키는 partial 앨범도 쓴다.
  - 지금 링크가 의심·어긋남·전집 상자면, 곡 수가 꼭 맞거나(exact) 앨범 이름이 이 작품을 가리킬 때만
    바꾼다(다른 전집 상자·편곡 모음으로 바꾸지 않는다).
  - 같은 성의 다른 작곡가 앨범(안톤 ↔ 요한 슈타미츠, J. C. ↔ J. S. 바흐)은 쓰지 않는다.
  - album_pick 이 못 고르면(「Hob. III:77」처럼 콜론 번호, 제목 꼴이 다른 작품) 검색 결과를 앨범별로
    audit 의 규칙으로 세어 고른다(fallback).
- clear: 새 앨범이 없고 지금 링크가 틀림·없어짐이다.
- keep: 그 밖(의심·어긋남·전집 상자인데 더 나은 앨범이 없다).

replace·clear 한 작품은 그 서비스의 곡 링크(맨 위 곡과 곡 안 곡)를 다 비운다. replace 는 새 앨범으로
match.py 를 다시 돌려 채운다(build_fix.py 는 그 입력 parts tsv 를 쓴다).
작품 링크는 지금 값이 판정 때 본 값과 같을 때만 바꾼다(그사이 사람이 고쳤으면 그대로).

사용: uv run python build_fix.py apple|spotify <audit.jsonl> <candidates.tsv> <picks-final.jsonl>
      <새 앨범 트랙 폴더> <fix_parts.tsv> <out 폴더> <마이그레이션.sql> <search_raw 폴더>
"""

from __future__ import annotations

import csv
import importlib.util
import json
import re
import sys
from collections import Counter
from pathlib import Path
from types import ModuleType
from typing import Any

COLUMN = {"apple": "apple_music_url", "spotify": "spotify_url"}
SERVICE = {"apple": "Apple Music", "spotify": "Spotify"}
FIXED = ("wrong", "gone")
USABLE = ("ok", "loose", "named")


def _load(path: Path, name: str) -> ModuleType:
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise ImportError(str(path))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


audit = _load(Path(__file__).resolve().parent / "audit.py", "audit")
fetch_links = _load(Path(__file__).resolve().parent / "fetch_links.py", "fetch_links")
plain = audit.plain

# 같은 성을 쓰는 음악가 집안. 앨범에 다른 이름(머리글자)이 적혀 있으면 다른 사람이다
FAMILY = {
    "bach", "mozart", "stamitz", "strauss", "haydn", "scarlatti", "couperin", "schumann",
    "mendelssohn", "boulanger", "gabrieli", "benda",
}  # fmt: skip
GIVEN = {
    "johann", "johannes", "carl", "karl", "philipp", "emanuel", "christian", "sebastian",
    "friedemann", "christoph", "wilhelm", "leopold", "wolfgang", "amadeus", "anton", "richard",
    "josef", "joseph", "michael", "alessandro", "domenico", "francois", "louis", "clara", "robert",
    "fanny", "felix", "nadia", "lili", "andrea", "giovanni", "franz", "georg", "eduard", "jiri",
    "frantisek", "carlo", "pietro",
}  # fmt: skip


def initials_of(name: str) -> str:
    words = re.sub(r"[^a-z ]", " ", plain(name)).split()
    words = [w for w in words if w not in {"ii", "iii", "jr", "sr", "the", "younger", "elder"}]
    return "".join(w[0] for w in words[:-1])


def surname(name: str) -> str:
    words = re.sub(r"[^a-z ]", " ", plain(name)).split()
    words = [w for w in words if w not in {"ii", "iii", "jr", "sr"}]
    return words[-1] if words else ""


def other_family(row: dict[str, str], text: str) -> bool:
    """앨범·아티스트 이름에 같은 성의 다른 사람이 적혀 있다(「Stamitz, Johann」「J. S. Bach」)."""
    last = surname(row["composer_en"])
    if last not in FAMILY:
        return False
    mine = initials_of(row["composer_en"])
    text = plain(text)
    found: set[str] = set()
    for m in re.finditer(rf"((?:\b[a-z]\.\s*){{1,3}})\s*{last}\b", text):
        found.add(re.sub(r"[^a-z]", "", m.group(1)))
    for m in re.finditer(rf"\b((?:[a-z]{{3,}}\s+){{1,3}}){last}\b", text):
        words = m.group(1).split()
        while words and words[0] not in GIVEN:
            words = words[1:]
        if words and all(w in GIVEN for w in words):
            found.add("".join(w[0] for w in words))
    for m in re.finditer(
        rf"\b{last},\s*((?:[a-z]\.\s*){{1,3}}|[a-z]{{3,}}(?:\s+[a-z]{{3,}})?)", text
    ):
        value = m.group(1)
        if "." in value:
            found.add(re.sub(r"[^a-z]", "", value))
        elif value.split()[0] in GIVEN:
            found.add("".join(w[0] for w in value.split() if w in GIVEN))
    found.discard("")
    if not found or not mine:
        return False
    # 우리 이름이 더 길 수 있다(「Johann Georg Leopold Mozart」 ↔ 「L. Mozart」).
    # 머리글자가 차례대로 들어 있으면 같은 사람이다
    return not any(subsequence(f, mine) or subsequence(mine, f) for f in found)


def subsequence(short: str, long: str) -> bool:
    letters = iter(long)
    return all(c in letters for c in short)


KOREAN_NAME = re.compile(r"^([A-Z][a-z]+) ([A-Z][a-z]+)-([a-z]+)$")


def korean_name_ok(row: dict[str, str], text: str) -> bool:
    """「Hong Nan-pa」처럼 성이 앞인 한국 이름은 이름(「Nan-pa」)까지 있어야 한다. 아니면 늘 참."""
    m = KOREAN_NAME.match(row["composer_en"].strip())
    if not m:
        return True
    given = rf"{m.group(2).lower()}[\s-]?{m.group(3)}"
    return re.search(given, plain(text)) is not None


ARRANGED = re.compile(r"\barr\.|arranged|transcri|\bversion for\b")


def credited(row: dict[str, str], album_name: str, artists: str) -> bool:
    """작곡가가 앨범 이름의 「성:」이나 「이름 성」, 또는 아티스트에 있다.

    짧은 제목은 앨범 이름의 우연한 낱말에 걸린다(케이지 「Waiting」 ↔ 「Waiting for the Cage」).
    """
    last = surname(row["composer_en"])
    album = plain(album_name)
    given = re.sub(r"[^a-z ]", " ", plain(row["composer_en"])).split()[:1]
    if re.search(rf"\b{last}\s*[:,]", album) or (given and f"{given[0]} {last}" in album):
        return True
    return bool(audit.has_composer(last, plain(artists)))


def dedicated(row: dict[str, str], album_name: str, artist: str) -> bool:
    """앨범 이름이 이 작곡가의 이 작품을 가리킨다(제목 낱말 반 넘게 + 작곡가)."""
    if audit.album_pick.names_work(row, album_name):
        return True
    words = audit.loose_words(row["title_en"])
    album_words = audit.word_set(album_name)
    hit = sum(w in album_words for w in words)
    return (
        bool(words)
        and hit * 2 >= len(words)
        and audit.has_composer(
            audit.surname_of(row["composer_en"]), plain(f"{album_name} {artist}")
        )
    )


def search_results(service: str, path: str) -> list[dict[str, Any]]:
    try:
        with open(path, encoding="utf-8") as handle:
            data: dict[str, Any] = json.load(handle)
    except OSError:
        return []
    if service == "apple":
        return [r for r in data.get("results", []) if r.get("wrapperType") == "track"]
    items = (((data.get("data") or {}).get("searchV2") or {}).get("tracksV2") or {}).get(
        "items"
    ) or []
    out = []
    for item in items:
        track = (item.get("item") or {}).get("data") or {}
        album = track.get("albumOfTrack") or {}
        track_id = str(track.get("uri", "")).rsplit(":", 1)[-1]
        if not track_id or not album.get("id"):
            continue
        artists = ", ".join(
            a.get("profile", {}).get("name", "")
            for a in (track.get("artists") or {}).get("items", [])
        )
        out.append(
            {
                "wrapperType": "track",
                "trackId": track_id,
                "trackName": track.get("name", ""),
                "trackViewUrl": f"https://open.spotify.com/track/{track_id}",
                "collectionId": album["id"],
                "collectionName": album.get("name", ""),
                "artistName": artists,
            }
        )
    return out


SURNAMES: set[str] = set()


def many_composers(row: dict[str, str], album_name: str) -> bool:
    """앨범 이름에 이 작곡가 말고 다른 작곡가 성(우리 목록)이 있다(여러 작곡가 독주회 음반)."""
    mine = audit.surname_of(row["composer_en"])
    words = set(re.sub(r"[^a-z ]", " ", plain(album_name)).split())
    return any(other in words for other in SURNAMES if other != mine and len(other) >= 4)


def fallback(
    row: dict[str, str], results: list[dict[str, Any]], want: int
) -> dict[str, Any] | None:
    """검색 결과를 앨범별로 audit 규칙(작품 트랙·느슨한 트랙)으로 세어 고른다."""
    albums: dict[str, list[dict[str, Any]]] = {}
    arranged = re.compile(r"\barr\.|arranged|transcri|\bversion for\b")
    allow_arranged = bool(arranged.search(audit.norm(row["title_en"])))
    surname_ = audit.surname_of(row["composer_en"])
    for track in results:
        # 편곡 트랙은 원곡 링크로 쓰지 않는다(「Messe des pauvres (Arr. … for …)」)
        if not allow_arranged and arranged.search(audit.norm(str(track.get("trackName", "")))):
            continue
        if audit.NOT_ORIGINAL.search(audit.norm(str(track.get("collectionName", "")))):
            continue
        albums.setdefault(str(track.get("collectionId")), []).append(track)
    best: tuple[int, int, int] | None = None
    chosen: dict[str, Any] | None = None
    for album, tracks in albums.items():
        work = set(audit.work_indexes(row, tracks)) | set(audit.loose_indexes(row, tracks)[0])
        if not work:
            continue
        first = tracks[0]
        name = str(first.get("collectionName", ""))
        if other_family(row, f"{name} {first.get('artistName', '')}"):
            continue
        # 검색으로 고를 때는 작곡가가 앨범·아티스트·트랙 이름 어딘가에 있어야 한다
        who = plain(
            " ".join(f"{t.get('artistName', '')} {t.get('trackName', '')}" for t in tracks)
            + f" {name}"
        )
        if not audit.has_composer(surname_, who):
            continue
        # 갈래 이름뿐인 제목(「Etude for guitar no. 8」)은 여러 작곡가 음반에서 고르지 않는다
        strong = [w for w in audit.loose_words(row["title_en"]) if w not in audit.WEAK]
        if not strong and many_composers(row, name):
            continue
        score = (
            int(len(work) >= want),
            int(dedicated(row, name, str(first.get("artistName", "")))),
            len(work),
        )
        if best is None or score > best:
            best = score
            chosen = {"albumId": album, "albumName": name, "workTracks": len(work)}
    return chosen


def ensure_tracks(service: str, album: str, raw: str) -> list[dict[str, Any]]:
    tracks: list[dict[str, Any]] = audit.tracks_of(raw, album)
    if tracks:
        return tracks
    if service == "apple":
        results = fetch_links.apple_page_album(album)
    else:
        results = fetch_links._load_spotify().fetch(album)
    if results is None:
        return []
    with open(f"{raw}/{album}.json", "w", encoding="utf-8") as handle:
        json.dump({"results": results}, handle, ensure_ascii=False)
    fetched: list[dict[str, Any]] = audit.tracks_of(raw, album)
    return fetched


def album_link(service: str, album: str, tracks: list[dict[str, Any]]) -> str:
    if service == "spotify":
        return f"https://open.spotify.com/album/{album}"
    name = str(tracks[0].get("collectionName", "")) if tracks else ""
    slug = re.sub(r"[^a-z0-9]+", "-", plain(name)).strip("-") or "album"
    return f"https://music.apple.com/us/album/{slug}/{album}"


def sql_text(value: str) -> str:
    return "'" + value.replace("\\", "\\\\").replace("'", "''") + "'"


def album_of(url: str) -> str | None:
    m = re.search(r"/album/(?:[^/?]+/)?([A-Za-z0-9]+)(?:\?.*)?$", url)
    return m.group(1) if m else None


def main() -> None:
    service, audit_path, candidates_path, picks_path, raw, parts_path, out, migration, search = (
        sys.argv[1:10]
    )
    column = COLUMN[service]
    with open(audit_path, encoding="utf-8") as handle:
        verdicts = {
            int(item["pieceId"]): item
            for item in map(json.loads, handle)
            if item["service"] == service
        }
    with open(candidates_path, encoding="utf-8") as handle:
        rows = {int(r["piece_id"]): r for r in csv.DictReader(handle, delimiter="\t")}
    links = Path(audit_path).parent / "links.tsv"
    if links.exists():
        with open(links, encoding="utf-8") as handle:
            SURNAMES.update(
                audit.surname_of(r["composer_en"]) for r in csv.DictReader(handle, delimiter="\t")
            )
    picks: dict[int, dict[str, Any]] = {}
    with open(picks_path, encoding="utf-8") as handle:
        for line in handle:
            if line.strip():
                pick = json.loads(line)
                picks[int(pick["pieceId"])] = pick
    parts: dict[int, list[dict[str, str]]] = {}
    with open(parts_path, encoding="utf-8") as handle:
        for part in csv.DictReader(handle, delimiter="\t"):
            parts.setdefault(int(part["piece_id"]), []).append(part)

    decisions: list[dict[str, Any]] = []
    for piece_id, row in sorted(rows.items()):
        seen = verdicts[piece_id]
        current = seen["url"]
        top = [p for p in parts.get(piece_id, []) if not p["parent_part_id"]]
        want = max(int(row["nparts"]), 1)
        pick = picks.get(piece_id)
        decision: dict[str, Any] = {
            "pieceId": piece_id,
            "title": row["title_en"],
            "composer": row["composer_en"],
            "verdict": seen["verdict"],
            "why": seen.get("why", ""),
            "current": current,
            "currentAlbum": seen.get("albumName", ""),
        }
        new_url = None
        options: list[tuple[str, str, str]] = []
        # 다시 판정해 보니 맞는 링크면 건드리지 않는다
        if seen["verdict"] not in (*FIXED, "conflict", "doubt", "box"):
            pick = None
        if pick and pick["albumId"] != album_of(current):
            options.append((str(pick["albumId"]), str(pick["status"]), "pick"))
        backup = (
            fallback(row, search_results(service, f"{search}/{piece_id}.json"), want)
            if seen["verdict"] in (*FIXED, "conflict", "doubt", "box")
            else None
        )
        if backup and backup["albumId"] != album_of(current):
            options.append((backup["albumId"], "", "fallback"))
        for album, status, source in options:
            tracks = ensure_tracks(service, album, raw)
            if not tracks:
                continue
            judged = audit.judge(row, top, tracks, want)
            name = str(tracks[0].get("collectionName", ""))
            artist = str(tracks[0].get("artistName", ""))
            enough = len(audit.work_indexes(row, tracks)) >= want
            status = status or ("exact" if judged.get("workTracks") == want else "")
            is_dedicated = dedicated(row, name, artist)
            if other_family(row, f"{name} {artist}"):
                continue
            strong = [w for w in audit.loose_words(row["title_en"]) if w not in audit.WEAK]
            artists = " ".join(str(t.get("artistName", "")) for t in tracks)
            if len(strong) <= 1 and not credited(row, name, artists):
                continue
            # 고른 트랙이 편곡이면 원곡 링크로 쓰지 않는다
            picked = judged.get("tracks", [])[:1]
            if (
                picked
                and ARRANGED.search(audit.norm(picked[0]))
                and not ARRANGED.search(audit.norm(row["title_en"]))
            ):
                continue
            credits = " ".join(
                f"{t.get('artistName', '')} {t.get('trackName', '')}" for t in tracks
            )
            if not korean_name_ok(row, f"{name} {credits}"):
                continue
            if judged["verdict"] == "partial":
                if not (seen["verdict"] in FIXED and is_dedicated):
                    continue
            elif judged["verdict"] not in USABLE:
                continue
            # 지금 링크가 의심·어긋남·전집 상자면 확실한 앨범으로만 바꾼다
            if seen["verdict"] not in FIXED and not (
                (judged["verdict"] == "ok" and status == "exact") or is_dedicated
            ):
                continue
            # 제목에 조성이 있으면 고른 트랙도 같은 조성이어야 한다
            key = audit.key_of(row["title_en"])
            keys = {audit.key_of(name_) for name_ in judged.get("tracks", [])} - {None}
            if key and keys and key not in keys:
                continue
            if seen["kind"] == "track":
                work = audit.work_indexes(row, tracks) or audit.loose_indexes(row, tracks)[0]
                if not work:
                    continue
                # 여러 악장이면 1악장 트랙(「…: I. Allegro」)으로
                first = [
                    i
                    for i in work
                    if audit.match.index_of(str(tracks[i].get("trackName", ""))) == 1
                ]
                chosen = (first or work)[0]
                new_url = re.sub(r"&uo=\d+$", "", str(tracks[chosen]["trackViewUrl"]))
            else:
                new_url = (
                    str(pick["albumUrl"])
                    if pick and source == "pick" and service == "spotify"
                    else album_link(service, album, tracks)
                )
            decision |= {
                "albumId": album,
                "source": source,
                "newAlbum": name,
                "newStatus": status,
                "newVerdict": judged["verdict"],
                "enough": enough,
                "newTracks": judged.get("tracks", [])[:2],
            }
            break
        if new_url:
            decision |= {"action": "replace", "new": new_url}
        elif seen["verdict"] in FIXED:
            decision["action"] = "clear"
        else:
            decision["action"] = "keep"
        decisions.append(decision)

    with open(f"{out}/{service}-decisions.jsonl", "w", encoding="utf-8") as handle:
        for item in decisions:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")

    changed = [d for d in decisions if d["action"] in ("replace", "clear")]
    # match.py 입력: 바꾸는 작품의 곡 전부, 앨범은 새 앨범, 지금 곡 링크는 비운 것으로 본다
    # (맨 위 곡만 → match.py, 전부 → match.py --nested)
    fields = list(next(iter(parts.values()))[0].keys()) if parts else []
    with (
        open(f"{out}/{service}-match-parts.tsv", "w", encoding="utf-8", newline="") as handle,
        open(f"{out}/{service}-match-top.tsv", "w", encoding="utf-8", newline="") as top_handle,
    ):
        writer = csv.DictWriter(handle, fieldnames=fields, delimiter="\t")
        top_writer = csv.DictWriter(top_handle, fieldnames=fields, delimiter="\t")
        writer.writeheader()
        top_writer.writeheader()
        for item in changed:
            if item["action"] != "replace":
                continue
            album_url = (
                item["new"]
                if "/album/" in item["new"] and "?i=" not in item["new"]
                else (
                    f"https://music.apple.com/us/album/x/{item['albumId']}"
                    if service == "apple"
                    else f"https://open.spotify.com/album/{item['albumId']}"
                )
            )
            for part in parts.get(item["pieceId"], []):
                fixed = part | {column: album_url, "part_apple": "", "part_spotify": ""}
                writer.writerow(fixed)
                if not part["parent_part_id"]:
                    top_writer.writerow(fixed)

    values = ",\n".join(
        f"({d['pieceId']}, {sql_text(d['current'])}, "
        + (sql_text(d["new"]) if d["action"] == "replace" else "NULL")
        + ")"
        for d in changed
    )
    temp = f"tmp_fix_piece_{service}"
    sql = [
        f"-- 작품 {SERVICE[service]} 링크 바로잡기. 자료와 규칙은",
        "-- seed_pipeline/curation/piece-link-audit-2026-11-09/(audit.py, build_fix.py,",
        f"-- {service}-decisions.jsonl).",
        f"-- 바꿈 {sum(d['action'] == 'replace' for d in changed)}곳, "
        f"지움 {sum(d['action'] == 'clear' for d in changed)}곳.",
        "-- 지금 값이 판정 때 본 값과 같을 때만 바꾸고, 그 작품의 곡 링크는 비운다",
        "-- (새 앨범에서 다시 채움).",
        "",
        f"CREATE TEMPORARY TABLE {temp} (",
        "    piece_id INT NOT NULL PRIMARY KEY,",
        "    old_url VARCHAR(500) NOT NULL,",
        "    new_url VARCHAR(500) NULL",
        ");",
    ]
    if changed:
        sql.append(f"INSERT INTO {temp} (piece_id, old_url, new_url) VALUES\n{values};")
    sql += [
        "",
        "UPDATE piece_parts part",
        f"JOIN {temp} fix ON fix.piece_id = part.piece_id",
        "JOIN pieces piece ON piece.id = fix.piece_id",
        f"SET part.{column} = NULL",
        f"WHERE piece.{column} = fix.old_url;",
        "",
        "UPDATE pieces piece",
        f"JOIN {temp} fix ON fix.piece_id = piece.id",
        f"SET piece.{column} = fix.new_url",
        f"WHERE piece.{column} = fix.old_url;",
        "",
        f"DROP TEMPORARY TABLE {temp};",
        "",
    ]
    with open(migration, "w", encoding="utf-8") as handle:
        handle.write("\n".join(sql))
    print(json.dumps(Counter(d["action"] for d in decisions), ensure_ascii=False))


if __name__ == "__main__":
    main()
