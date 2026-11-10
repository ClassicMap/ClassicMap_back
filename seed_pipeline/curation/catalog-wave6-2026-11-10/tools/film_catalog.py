"""6차: 영화·TV·게임·애니 작곡가의 큐 seed 를 MusicBrainz 음반(release group) 단위로 묶는다.

4차 규칙(auto_catalog.build)을 먼저 돌리고 그 위에 아래를 얹는다. 출력은 4차와 같은
catalog.json·seed_map.json 이라 생성기 gen_catalog.py 를 고치지 않고 그대로 쓴다.

- 연주회용 작품(MB 갈래가 교향곡·협주곡·오페라·칸타타 등이거나, 제목 갈래를 우리말로 옮길 수 있거나,
  갈래 없이 part 를 가진 묶음): 4차 규칙 그대로 둔다.
- 영화 단위 MB 작품(갈래 Soundtrack 이면서 part 를 가진 seed 작품): 4차 규칙 그대로 묶음으로 둔다.
- 나머지(큐, MB 갈래 Song, 4차가 편곡으로 본 큐): 그 큐의 녹음이 실린 음반(release group)에
  묶는다. 음반 하나가 한 줄 묶음 작품이 되고, 큐 seed 는 그 안 곡(linked_piece_id)이 된다.
  음반 안 곡 순서는 대표 판(공식·가장 이른 판)의 트랙 순서이고, seed 가 없는 이 작곡가의 곡도
  이름만 있는 곡으로 넣는다.
- 큐가 여러 음반에 실리면 모음집·라이브·리믹스가 아닌 음반, 이 작곡가 seed 가 많이 실린 음반,
  먼저 나온 음반 순으로 하나만 고른다.
- 어느 음반에도 없는 큐는 숨긴다(hidden_reason='catalog_unmatched', 지우지 않음).
  MB 갈래 Song 은 음반에 없으면 4차 규칙대로 보이게 둔다. 4차가 중복으로 본 seed,
  리믹스·리워크 seed 는 4차 규칙대로 숨긴다.
- 이 작곡가 seed 가 하나만 이어지는 음반은 묶지 않고 그 곡을 낱곡으로 둔다(숨기지 않음).
- 묶음 제목: 영화 사운드트랙(위키데이터에서 이 작곡가가 음악을 맡은 영화와 이름이 같거나,
  음반 제목에 영화임이 드러나거나, --films 에 적은 음반)은 「영화 <원제> 사운드트랙」.
  한국 개봉 제목은 그 영화의 한국어 위키백과 문서 제목(또는 --ko-titles)이 있을 때만 쓴다.
  모음집·TV·게임·애니·일반 음반은 음반 원제 그대로. 영어 제목은 늘 음반 원제다.
  운영 작품 제목과 겹치면 「(음반)」을 붙인다.

사용(seed_pipeline 에서):
    uv run python <이 파일> --composer-id 419 --slug terry-plumeri --db <덤프> --out <폴더> \
        --wikidata <작곡가 QID> [--films films.tsv] [--ko-titles ko_titles.tsv]
"""

import argparse
import csv
import importlib.util
import json
import os
import re
import sys
from collections import Counter, defaultdict
from types import ModuleType
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
AUTO_PATH = os.path.join(
    os.path.dirname(os.path.dirname(HERE)), "catalog-wave4-2026-10-12", "auto", "auto_catalog.py"
)
sys.path.insert(0, HERE)
import fetch  # noqa: E402

sys.modules["fetch"] = fetch
csv.field_size_limit(10_000_000)


def load_auto() -> ModuleType:
    spec = importlib.util.spec_from_file_location("auto_catalog", AUTO_PATH)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


auto = load_auto()

CONCERT_TYPES = {
    "symphony",
    "concerto",
    "sonata",
    "suite",
    "opera",
    "operetta",
    "cantata",
    "oratorio",
    "ballet",
    "song-cycle",
    "symphonic poem",
    "overture",
    "quartet",
    "quintet",
    "trio",
    "mass",
    "requiem",
    "madrigal",
    "motet",
    "partita",
    "zarzuela",
    "serenade",
    "variations",
    "étude",
    "prelude",
    "fantasia",
    "nocturne",
    "march",
    "chamber music",
}
FILMY_TITLE = re.compile(r"film score|soundtrack|\bOST\b|\bscore\b", re.IGNORECASE)
REMIX = re.compile(r"\b(re-?work|remix|rmx|re-?edit|re-?imagin\w*|bootleg|mash-?up)\b", re.I)
SIDE_TYPES = {"Compilation", "Live", "Remix", "DJ-mix", "Mixtape/Street", "Demo", "Interview"}
# 음반 제목만으로 영화 사운드트랙이라 볼 수 있는 말.
# 「The Film Scores」 같은 모음집은 빼려고 좁게 둔다.
FILM_WORDS = re.compile(
    r"motion picture|original (?:film|movie) (?:soundtrack|score)|music from the (?:film|movie)|"
    r"bande originale du film|colonna sonora (?:originale )?del film|映画",
    re.IGNORECASE,
)
SERIES = re.compile(r"\bseason\b|\bseries\b|\bepisode\b|\bvol(?:ume|\.)?\s*\d", re.IGNORECASE)
_TRACK_WORDS = (
    r"soundtrack|score|o\.?s\.?t\.?|music from|motion picture|bande originale|colonna sonora"
)
SOUNDTRACK_TAIL = re.compile(
    rf"\s*[(\[][^()\[\]]*\b(?:{_TRACK_WORDS})\b[^()\[\]]*[)\]]\s*$"
    rf"|\s*[:\u2013\u2014]\s*[^:\u2013\u2014]*\b(?:{_TRACK_WORDS})\b[^:\u2013\u2014]*$"
    rf"|\s+-\s+[^-]*\b(?:{_TRACK_WORDS})\b[^-]*$",
    re.IGNORECASE,
)


def film_title(rg_title: str) -> str:
    """음반 제목에서 사운드트랙 꼬리를 뗀 영화 제목.

    예: 「Taxi Driver (Original Soundtrack Recording)」,
    「Sicario: Original Motion Picture Soundtrack」.
    """
    title = rg_title.strip()
    for _ in range(3):
        stripped = SOUNDTRACK_TAIL.sub("", title).strip()
        if stripped == title or not stripped:
            break
        title = stripped
    title = re.sub(
        r"^(?:music from|bande originale du film|original soundtrack:?)\s+", "", title, flags=re.I
    )
    return title.strip(" :-\u2013\u2014") or rg_title


SCREEN_QUERY = """
SELECT ?work (SAMPLE(?f) AS ?film) (SAMPLE(?t) AS ?tv) (SAMPLE(?g) AS ?game)
       (SAMPLE(?kowikiTitle) AS ?kowiki)
       (GROUP_CONCAT(DISTINCT ?name; separator="\\u001f") AS ?names)
WHERE {
  ?work wdt:P86 wd:%s .
  BIND(EXISTS { ?work wdt:P31/wdt:P279* wd:Q11424 } AS ?f)
  BIND(EXISTS { ?work wdt:P31/wdt:P279* wd:Q15416 } AS ?t)
  BIND(EXISTS { ?work wdt:P31/wdt:P279* wd:Q7889 } AS ?g)
  OPTIONAL { ?article schema:about ?work ; schema:isPartOf <https://ko.wikipedia.org/> ;
             schema:name ?kowikiTitle . }
  { ?work rdfs:label ?name } UNION { ?work wdt:P1476 ?name } UNION { ?work skos:altLabel ?name }
}
GROUP BY ?work
"""


def screen_works(qid: str) -> list[dict[str, Any]]:
    """작곡가(P86)가 이 사람인 위키데이터 영화·TV·게임과 이름들, 한국어 위키백과 문서 제목."""
    import urllib.parse

    query = SCREEN_QUERY % qid
    url = "https://query.wikidata.org/sparql?" + urllib.parse.urlencode(
        {"query": query, "format": "json"}
    )
    body = fetch._cached_get("wd", url)
    if not body:
        return []
    out: list[dict[str, Any]] = []
    for row in json.loads(body)["results"]["bindings"]:
        value = {name: str(cell.get("value", "")) for name, cell in row.items()}
        out.append(
            {
                "qid": value.get("work", "").rsplit("/", 1)[-1],
                "film": value.get("film") == "true",
                "tv": value.get("tv") == "true",
                "game": value.get("game") == "true",
                "kowiki": value.get("kowiki", ""),
                "names": [n for n in value.get("names", "").split("\u001f") if n],
            }
        )
    return out


def match_screen(rg_title: str, screens: list[dict[str, Any]]) -> dict[str, Any] | None:
    """음반 제목(사운드트랙 꼬리를 뗀 것)과 이름이 같은 위키데이터 작품.

    하나뿐이면 그것, 여럿인데 모두 영화면(리메이크 등) 한국 제목 없이 영화로만 본다.
    """
    wanted = {auto.normal_title(rg_title), auto.normal_title(film_title(rg_title))} - {""}
    # 사운드트랙 음반 항목도 P86 을 달고 있으니 영화·TV·게임만 본다
    found = [
        s
        for s in screens
        if (s["film"] or s["tv"] or s["game"])
        and wanted & {auto.normal_title(n) for n in s["names"]}
    ]
    if len(found) == 1:
        return found[0]
    if found and all(s["film"] and not s["tv"] for s in found):
        qids = ",".join(sorted(s["qid"] for s in found))
        titles = {korean_title(s["kowiki"]) for s in found}
        # 리메이크처럼 여러 편이 같은 한국 제목이면 그 제목을 쓴다
        # (「싸이코 (1960년 영화)」·「싸이코 (1998년 영화)」)
        kowiki = next(iter(titles)) if len(titles) == 1 and None not in titles else ""
        return {
            "qid": qids,
            "film": True,
            "tv": False,
            "game": False,
            "kowiki": kowiki or "",
            "names": [],
        }
    return None


def korean_title(kowiki: str) -> str | None:
    """한국어 위키백과 문서 제목에서 「(1972년 영화)」 같은 꼬리를 뗀다."""
    if not kowiki:
        return None
    return re.sub(r"\s*\((?:[^()]*영화|[^()]*애니메이션)\)\s*$", "", kowiki).strip() or None


def read_tsv_map(path: str | None) -> dict[str, str]:
    if not path:
        return {}
    out: dict[str, str] = {}
    with open(path, encoding="utf-8") as handle:
        for line in handle:
            if not line.strip() or line.startswith("#"):
                continue
            key, _, value = line.rstrip("\n").partition("\t")
            out[key.strip()] = value.strip()
    return out


def browse_releases(artist: str) -> list[dict[str, Any]]:
    out: list[dict[str, Any]] = []
    offset = 0
    while True:
        page = fetch.mb(
            "release",
            {"artist": artist, "limit": 100, "offset": offset, "inc": "release-groups"},
        )
        if not page:
            break
        out.extend(page["releases"])
        offset += 100
        if offset >= page["release-count"]:
            break
    return out


def release_rank(release: dict[str, Any]) -> tuple[bool, str, str]:
    return (release.get("status") != "Official", release.get("date") or "9999", release["id"])


def album_tracks(release_id: str) -> list[tuple[str, str]]:
    """대표 판의 (work id, work 제목)을 트랙 순서대로. 녹음에 이어진 작품이 여럿이면 모두."""
    data = fetch.mb("release/" + release_id, {"inc": "recordings+work-rels+recording-level-rels"})
    tracks: list[tuple[str, str]] = []
    for medium in (data or {}).get("media", []):
        for track in medium.get("tracks", []):
            for rel in (track.get("recording") or {}).get("relations", []):
                if rel.get("target-type") == "work" and rel.get("type") == "performance":
                    tracks.append((rel["work"]["id"], rel["work"]["title"]))
    return tracks


def track_name(name: str, rg_title: str) -> str:
    """음반 안 곡 이름: 앞에 음반·영화 제목이 붙어 있으면 뗀다. 나머지는 원제 그대로."""
    for head in (rg_title, film_title(rg_title)):
        for sep in (":", " -", " \u2013", ","):
            if name.lower().startswith(head.lower() + sep) and len(name) > len(head) + len(sep):
                return name[len(head) + len(sep) :].strip()
    return name.strip() or rg_title


def work_class(entry: dict[str, Any], works: dict[str, dict[str, Any]]) -> str:
    genre = entry.get("genre") or ""
    title = str(entry["mbTitle"])
    if genre in CONCERT_TYPES:
        return "concert"
    if entry["kind"] != "single":
        if genre == "soundtrack" or FILMY_TITLE.search(title):
            return "film_work"
        return "concert"
    head, _ = auto.split_title(title)
    _, translated = auto.translate(head, works.get(entry["mbid"] or "", {}).get("type"))
    if translated:
        return "concert"
    if genre == "song":
        return "song"
    return "cue"


def build(
    composer_id: int,
    slug: str,
    artist: str,
    rows: list[dict[str, str]],
    taken: dict[str, int],
    films: dict[str, str],
    ko_titles: dict[str, str],
    screens: list[dict[str, Any]],
) -> tuple[list[dict[str, Any]], list[dict[str, Any]], dict[str, Any], list[dict[str, Any]]]:
    catalog, seed_map, auto_stats = auto.build(composer_id, slug, artist, rows, taken)
    stats: Counter[str] = Counter(auto_stats)
    works = auto.fetch_works(artist)
    by_key = {w["key"]: w for w in catalog}
    seeds = {e["pieceId"]: e for e in seed_map}
    rowmap = {int(r["id"]): r for r in rows}

    # 1. seed 마다 갈래를 정한다
    seed_class: dict[int, str] = {}
    for pid, entry in seeds.items():
        if entry["mapping"] in ("work", "part"):
            cls = work_class(by_key[entry["key"]], works)
            if entry["mapping"] == "part":
                cls = "concert" if cls == "concert" else "film_work"
            seed_class[pid] = cls
        elif entry["reason"] == "duplicate":
            seed_class[pid] = "duplicate"
        elif entry["reason"] == "popular" and (
            REMIX.search(entry["title"])
            or any(
                REMIX.search(works.get(m, {}).get("disambiguation") or "") for m in entry["mbids"]
            )
        ):
            seed_class[pid] = "remix"
        else:
            # 4차가 편곡·대중음악(가나 제목)·판단 보류로 둔 큐도 음반에 실렸으면 묶는다
            seed_class[pid] = "cue"
    groupable = {pid for pid, cls in seed_class.items() if cls in ("cue", "song")}
    seed_by_work: dict[str, set[int]] = defaultdict(set)
    for pid in groupable:
        for mbid in seeds[pid]["mbids"]:
            seed_by_work[mbid].add(pid)

    # 2. 음반(release group)과 대표 판의 트랙
    releases = browse_releases(artist)
    groups: dict[str, dict[str, Any]] = {}
    for release in sorted(releases, key=release_rank):
        rg = release.get("release-group") or {}
        if rg.get("id") and rg["id"] not in groups:
            groups[rg["id"]] = {"rg": rg, "release": release["id"]}
    mine = {wid for wid, w in works.items() if auto.is_composer(w, artist)}
    for info in groups.values():
        ordered: list[tuple[str, str]] = []
        seen: set[str] = set()
        for wid, wtitle in album_tracks(info["release"]):
            if wid in seen or (wid not in mine and wid not in seed_by_work):
                continue
            seen.add(wid)
            ordered.append((wid, wtitle))
        info["tracks"] = ordered
        info["candidates"] = {pid for wid, _ in ordered for pid in seed_by_work.get(wid, set())}

    # 3. seed 마다 음반 하나를 고른다
    def rank(rgid: str) -> tuple[bool, int, str, str]:
        info = groups[rgid]
        side = bool(set(info["rg"].get("secondary-types") or []) & SIDE_TYPES)
        return (
            side,
            -len(info["candidates"]),
            info["rg"].get("first-release-date") or "9999",
            rgid,
        )

    # 묶음에 seed 가 둘 이상 이어지는 음반만 쓴다. 하나뿐인 음반은 빼고 다시 고르기를 되풀이하고,
    # 끝내 묶이지 않은 seed 는 음반에 실린 곡이므로 숨기지 않고 낱곡으로 둔다.
    banned: set[str] = set()
    while True:
        assigned: dict[int, str] = {}
        for rgid in sorted(
            (g for g in groups if groups[g]["candidates"] and g not in banned), key=rank
        ):
            for pid in groups[rgid]["candidates"]:
                assigned.setdefault(pid, rgid)
        sizes = Counter(assigned.values())
        small = {rgid for rgid, size in sizes.items() if size < 2}
        if not small:
            break
        banned |= small
    on_album = {pid for info in groups.values() for pid in info["candidates"]}
    solo: set[int] = on_album - set(assigned)

    # 4. 카탈로그에서 큐·노래 작품을 빼고 음반 묶음을 더한다
    grouped_keys = {seeds[pid]["key"] for pid in assigned if seeds[pid]["mapping"] == "work"}
    dropped_cue_keys = {
        seeds[pid]["key"]
        for pid in groupable
        if pid not in assigned
        and pid not in solo
        and seed_class[pid] == "cue"
        and seeds[pid]["mapping"] == "work"
    }
    kept: list[dict[str, Any]] = []
    for entry in catalog:
        if entry["key"] in grouped_keys or entry["key"] in dropped_cue_keys:
            continue
        cls = work_class(entry, works)
        if not entry.get("existingPieceId") and cls in ("cue", "song", "film_work"):
            # seed 가 없는 큐·노래·영화 작품은 새로 넣지 않는다(음반 묶음 안 곡으로만 보인다)
            stats["film_dropped_new_" + cls] += 1
            continue
        kept.append(entry)

    reserved = {r["title"] for r in rows} | {str(w["titleKo"]) for w in kept}
    report: list[dict[str, Any]] = []
    new_entries: list[dict[str, Any]] = []
    for rgid in sorted({*assigned.values()}, key=rank):
        info = groups[rgid]
        rg = info["rg"]
        rg_title = str(rg["title"])
        members = {pid for pid, g in assigned.items() if g == rgid}
        screen = match_screen(rg_title, screens)
        compilation = "Compilation" in (rg.get("secondary-types") or [])
        if rgid in films:
            is_film = True
        elif compilation:
            # 모음집은 영화 한 편의 음반이 아니다(「Citizen Kane: The Essential … Collection」)
            is_film = False
        elif screen is not None:
            is_film = screen["film"] and not SERIES.search(rg_title)
        else:
            is_film = bool(FILM_WORDS.search(rg_title))
        ko = None
        if is_film:
            name = films.get(rgid) or film_title(rg_title)
            ko = ko_titles.get(rgid) or (korean_title(screen["kowiki"]) if screen else None)
            title = f"영화 <{ko or name}> 사운드트랙"
        else:
            title = rg_title
        for candidate in (title, f"{title} (음반)", f"{title} (음반 {rgid[:8]})"):
            if candidate[:250] not in reserved:
                title = candidate[:250]
                break
        else:
            raise SystemExit(f"묶음 제목을 정하지 못함: {rg_title}")
        reserved.add(title)
        key = f"{slug}-rg-{rgid[:8]}"
        parts: list[dict[str, Any]] = []
        for seq, (wid, wtitle) in enumerate(info["tracks"], start=1):
            linked = next(
                (pid for pid in sorted(seed_by_work.get(wid, set())) if pid in members), None
            )
            name = rowmap[linked]["title"] if linked else wtitle
            nice = track_name(name, rg_title)
            if linked:
                members.discard(linked)
                seeds[linked].update(
                    mapping="part",
                    key=key,
                    path=[seq],
                    reason=None,
                    note=f"음반 <{rg_title}> 트랙",
                )
            parts.append(
                {
                    "seq": seq,
                    "mbid": wid,
                    "mbTitle": wtitle,
                    "nameKo": nice[:500],
                    "nameEn": wtitle[:500],
                    "movementNumber": None,
                    "catalogueAlt": None,
                    "existingPieceId": linked,
                    "existingPartId": None,
                    "children": [],
                }
            )
        if members:
            # 같은 작품을 가리키는 seed 가 둘이면 하나만 잇고 나머지는 중복으로 숨긴다
            for pid in members:
                assigned.pop(pid, None)
                seed_class[pid] = "duplicate"
        new_entries.append(
            {
                "key": key,
                "kind": "collection",
                "catalogue": None,
                "catalogueAlt": None,
                "titleKo": title,
                "titleEn": rg_title[:250],
                "year": None,
                "yearText": None,
                "genre": "soundtrack"
                if "Soundtrack" in (rg.get("secondary-types") or [])
                else None,
                "authenticity": "authentic",
                "mbid": None,
                "mbTitle": rg_title,
                "existingPieceId": None,
                "parts": parts,
            }
        )
        report.append(
            {
                "releaseGroup": rgid,
                "release": info["release"],
                "rgTitle": rg_title,
                "types": [rg.get("primary-type"), *(rg.get("secondary-types") or [])],
                "firstRelease": rg.get("first-release-date"),
                "film": is_film,
                "wikidata": screen["qid"] if screen else None,
                "screenKind": (
                    None
                    if screen is None
                    else "film"
                    if screen["film"]
                    else "tv"
                    if screen["tv"]
                    else "game"
                    if screen["game"]
                    else "other"
                ),
                "kowiki": screen["kowiki"] if screen else None,
                "koTitle": ko,
                "title": title,
                "tracks": len(parts),
                "linked": sum(1 for p in parts if p["existingPieceId"]),
            }
        )

    # 5. 한 곡짜리 음반의 곡은 낱곡으로 둔다. 4차가 숨기려던 seed 면 원제 그대로 낱곡 작품을 만든다
    for pid in sorted(solo):
        entry = seeds[pid]
        if entry["mapping"] == "work":
            continue
        row = rowmap[pid]
        key = f"{slug}-solo-{pid}"
        title_en = row["title_en"] if row["title_en"] not in ("", "NULL") else row["title"]
        new_entries.append(
            {
                "key": key,
                "kind": "single",
                "catalogue": None,
                "catalogueAlt": None,
                "titleKo": row["title"],
                "titleEn": title_en,
                "year": None,
                "yearText": None,
                "genre": None,
                "authenticity": "authentic",
                "mbid": None,
                "mbTitle": row["title"],
                "existingPieceId": pid,
                "parts": [],
            }
        )
        entry.update(mapping="work", key=key, path=None, reason=None, note="한 곡짜리 음반의 곡")

    # 6. 음반에 없는 큐는 숨긴다. 노래는 음반에 없으면 4차 규칙대로 둔다
    for pid, entry in seeds.items():
        if pid in assigned or pid in solo:
            continue
        cls = seed_class[pid]
        if cls == "cue" or (cls == "duplicate" and entry["mapping"] in ("work", "part")):
            entry.update(
                mapping="unmatched",
                key=None,
                path=None,
                reason="film_cue" if cls == "cue" else "duplicate",
                note="어느 음반에도 실리지 않은 큐"
                if cls == "cue"
                else "같은 작품 seed 가 이미 묶임",
            )
    final = kept + new_entries
    # 묶음에서 빠진 작품을 가리키던 seed 는 위에서 이미 다시 정했다
    live_keys = {w["key"] for w in final}
    for entry in seeds.values():
        if entry["mapping"] in ("work", "part") and entry["key"] not in live_keys:
            raise SystemExit(f"seed {entry['pieceId']} 가 없어진 작품 {entry['key']} 를 가리킴")
    counts = Counter(
        "film_" + (e["mapping"] if e["mapping"] != "unmatched" else e["reason"])
        for e in seeds.values()
    )
    stats.update(counts)
    stats["film_groups"] = sum(1 for w in new_entries if w["kind"] == "collection")
    stats["film_solo"] = len(solo)
    stats["film_concert_kept"] = sum(1 for w in kept if w.get("existingPieceId"))
    return final, list(seeds.values()), dict(stats), report


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--composer-id", type=int, required=True)
    parser.add_argument("--slug", required=True)
    parser.add_argument("--db", required=True)
    parser.add_argument("--out", required=True)
    parser.add_argument("--films", help="영화 사운드트랙으로 볼 release group id<TAB>영화 원제")
    parser.add_argument("--ko-titles", help="release group id<TAB>확인한 한국 개봉 제목")
    parser.add_argument(
        "--wikidata", help="작곡가 위키데이터 QID(영화·TV 구분과 한국어 위키백과 제목)"
    )
    args = parser.parse_args()
    with open(os.path.join(args.db, "composers.tsv"), encoding="utf-8") as handle:
        composers = {
            int(r["id"]): r for r in csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE)
        }
    artist = composers[args.composer_id]["mb_artist"]
    with open(os.path.join(args.db, "pieces.tsv"), encoding="utf-8") as handle:
        rows = [
            r
            for r in csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE)
            if int(r["composer_id"]) == args.composer_id
        ]
    with open(os.path.join(args.db, "all_mbids_taken.tsv"), encoding="utf-8") as handle:
        taken = {
            r["external_id"]: int(r["piece_id"]) for r in csv.DictReader(handle, delimiter="\t")
        }
    qid = composers[args.composer_id].get("wikidata") or args.wikidata
    catalog, seed_map, stats, report = build(
        args.composer_id,
        args.slug,
        artist,
        rows,
        taken,
        read_tsv_map(args.films),
        read_tsv_map(args.ko_titles),
        screen_works(qid) if qid else [],
    )
    os.makedirs(args.out, exist_ok=True)
    for name, data in (
        ("catalog.json", catalog),
        ("seed_map.json", seed_map),
        ("stats.json", stats),
        ("groups.json", report),
    ):
        with open(os.path.join(args.out, name), "w", encoding="utf-8") as handle:
            json.dump(data, handle, ensure_ascii=False, indent=1)
    print(args.slug, json.dumps(stats, ensure_ascii=False))


if __name__ == "__main__":
    main()
