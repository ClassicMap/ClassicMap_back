# ruff: noqa: E501 — 한국어 설명을 그대로 둔다.
"""사운드트랙 맨 위 작품마다 Apple Music·Spotify 앨범을 고르고, 안 곡(piece_parts)과 안 곡으로 이어진 작품의 트랙 링크를 정한다.

앨범으로 쓰는 조건(둘 다)
- 작곡가: 앨범 이름·아티스트·트랙 아티스트에 작곡가 성이 있다.
- 작품: 앨범 이름에 작품 핵심 제목(6차 음반 묶음은 음반 이름)이 있거나, 안 곡이 셋 이상 또는 절반 이상 트랙과 맞는다.
  안 곡 없는 영화음악(쇼스타코비치 「햄릿」 등)은 트랙 이름이 핵심 제목으로 시작하는(또는 「from <제목>」「<제목> op」「<제목> suite」)
  모음 음반도 쓴다. 「Friends」가 「Girl Friends」에 걸리지 않게 앞에서부터 본다.
- Apple 은 Lookup 이 빈 앨범(없어진 앨범)을 쓰지 않는다. MusicBrainz url-rels 의 옛 iTunes id 가 그렇다.
고르는 순서: 맞은 안 곡 수 → 앨범 이름에 제목 → 이 작품 트랙 수 → MusicBrainz url-rels 에 있음 → 트랙 수가 안 곡 수에 가까움.
「<영화>: Michael Nyman 5」 같은 낱곡은 그 곡 트랙이 있는 앨범의 트랙 링크를 쓴다.

곡 맞추기: 「(From …)」「- Remastered」 꼬리·앞 번호·관사(the/a/an)를 뗀 이름이 같거나 비슷하면(difflib 0.88 이상,
같은 자리 번호면 0.75 이상) 한 트랙에 한 곡만.

링크를 바꾸는 범위
- 맨 위 작품·안 곡·이어진 작품: 비어 있으면 채운다.
- 맨 위 작품의 지금 링크: 작곡가가 없거나 이 작품이 아닌 앨범(이름에 제목이 없고, 트랙에도 이 작품·안 곡이 없음)이면
  고른 앨범으로 바꾸고, 고른 것이 없으면 지운다.
- 이어진 작품(음반 묶음 안 곡)의 지금 링크: 고른 앨범도 아니고 이름에 묶음 제목도 없는 앨범(예전 검색 1위로 붙은
  같은 작곡가의 다른 음반 — 「Human Target」 곡 「The Devil's Mouth」가 같은 이름의 다른 영화 음반)이면
  고른 앨범에서 맞은 트랙으로 바꾸고, 맞은 트랙이 없으면 그 앨범에 같은 이름 트랙도 없을 때만 지운다.
결과: <작업 폴더>/decisions.jsonl (piece·part 마다 service·old·new·why)

사용: uv run python pick.py <작업 폴더>
"""

from __future__ import annotations

import difflib
import json
import os
import re
import sys
import time
import urllib.parse
from typing import Any

from common import key_title, norm, read_tsv, track_name_core, wave6_groups
from fetch_albums import (
    display_key,
    embed_album,
    get_json,
    split_cue,
    spotify_tracks_of_search,
    surname,
)

APPLE_ID = re.compile(r"/album/(?:[^/?]*/)?(\d{6,})")
SPOTIFY_ALBUM = re.compile(r"open\.spotify\.com/album/([A-Za-z0-9]{22})")
STOP = {"the", "a", "an", "from", "theme", "main", "title"}
# 편곡·커버·피아노 독주판·태교 음반은 사운드트랙 링크로 쓰지 않는다
NOT_SCORE = re.compile(
    # 쇼스타코비치 영화 모음곡은 아톰얀이 엮은 것이 표준이라 「arr. Atovmyan」은 편곡으로 보지 않는다
    r"\barr\b(?!\.?\s*(l\.?\s*)?atovmyan)|\b(arranged|arrangements?|transcri\w*|for solo piano|solo piano|piano solo|piano version|cover|covers|tribute|lullab\w*|karaoke|music box|8[- ]?bit)\b",
    re.I,
)
# 「<제목> op」 앞에 와도 되는 낱말(작곡가 성은 트랙 이름 맨 앞에 자주 붙는다)
BEFORE_KEY = {
    "from",
    "to",
    "for",
    "shostakovich",
    "prokofiev",
    "williams",
    "britten",
    "glass",
    "rota",
    "herrmann",
    "nyman",
    "kilar",
    "davies",
    "petrassi",
    "gershwin",
}
KEY_STOP = {"the", "a", "an", "of", "and", "de", "la", "le", "il", "di", "e", "s"}


def core(name: str) -> str:
    words = [w for w in track_name_core(name).split() if w not in STOP]
    return " ".join(words)


def load(path: str) -> Any:
    with open(path, encoding="utf-8") as handle:
        return json.load(handle)


class Albums:
    """받아 둔 앨범(Apple Lookup·Spotify 임베드)을 같은 꼴로 읽는다: name, artists, tracks[{id,name,url}], url."""

    def __init__(self, work: str) -> None:
        self.work = work

    def apple(self, album_id: str) -> dict[str, Any] | None:
        path = os.path.join(self.work, "apple_albums", f"{album_id}.json")
        if not os.path.exists(path):
            self.fetch_apple([album_id])
        items = load(path)["results"]
        coll = next((i for i in items if i.get("wrapperType") == "collection"), None)
        if not coll:
            return None
        base = str(coll["collectionViewUrl"]).split("?")[0]
        tracks = [
            {
                "id": str(i["trackId"]),
                "name": str(i.get("trackName", "")),
                "url": f"{base}?i={i['trackId']}",
                "artists": str(i.get("artistName", "")),
            }
            for i in items
            if i.get("wrapperType") == "track" and i.get("kind", "song") == "song"
        ]
        return {
            "id": album_id,
            "name": str(coll.get("collectionName", "")),
            "artists": str(coll.get("artistName", "")),
            "tracks": tracks,
            "url": base,
        }

    def fetch_apple(self, ids: list[str]) -> None:
        album_dir = os.path.join(self.work, "apple_albums")
        os.makedirs(album_dir, exist_ok=True)
        todo = [a for a in ids if not os.path.exists(os.path.join(album_dir, f"{a}.json"))]
        for start in range(0, len(todo), 20):
            chunk = todo[start : start + 20]
            query = urllib.parse.urlencode(
                {"id": ",".join(chunk), "entity": "song", "limit": 200, "country": "us"}
            )
            data = get_json(f"https://itunes.apple.com/lookup?{query}")
            by_album: dict[str, list[dict[str, Any]]] = {a: [] for a in chunk}
            for item in data.get("results", []):
                album = str(item.get("collectionId"))
                if album in by_album:
                    by_album[album].append(item)
            for album, items in by_album.items():
                with open(
                    os.path.join(album_dir, f"{album}.json"), "w", encoding="utf-8"
                ) as handle:
                    json.dump({"results": items}, handle, ensure_ascii=False)
            time.sleep(3.3)

    def spotify(self, album_id: str) -> dict[str, Any] | None:
        path = os.path.join(self.work, "spotify_albums", f"{album_id}.json")
        if not os.path.exists(path):
            data = embed_album(album_id)
            if data is None:
                return None
            os.makedirs(os.path.dirname(path), exist_ok=True)
            with open(path, "w", encoding="utf-8") as handle:
                json.dump(data, handle, ensure_ascii=False)
            time.sleep(0.8)
        data = load(path)
        if data.get("gone") or not data.get("tracks"):
            return None
        tracks = [
            {
                "id": t["id"],
                "name": t["name"],
                "url": f"https://open.spotify.com/track/{t['id']}",
                "artists": t.get("artists", ""),
            }
            for t in data["tracks"]
        ]
        return {
            "id": album_id,
            "name": data["name"],
            "artists": data.get("artists", ""),
            "tracks": tracks,
            "url": f"https://open.spotify.com/album/{album_id}",
        }


def has_composer(album: dict[str, Any], sur: str) -> bool:
    text = norm(album["name"]) + " " + norm(album["artists"])
    if sur in text:
        return True
    return any(sur in norm(t.get("artists", "")) for t in album["tracks"][:30])


def track_has_work(track: str, key: str) -> bool:
    """트랙이 이 영화음악에서 나온 곡인가. 「The Family」가 다른 음반의 같은 이름 곡에, 「Friends」가 「Girl Friends」에
    걸리지 않게, 「from <제목>」 꼴이거나 「<제목> op/suite/film/music」 앞이 트랙 맨 앞·작곡가 이름·from·to 일 때만,
    또는 세 낱말 이상 제목으로 시작할 때만 본다."""
    name = norm(track)
    if not key or NOT_SCORE.search(track):
        return False
    if f"from {key}" in name or (len(key.split()) >= 3 and name.startswith(key)):
        return True
    words = name.split()
    size = len(key.split())
    for index in range(len(words) - size + 1):
        if " ".join(words[index : index + size]) != key:
            continue
        after = words[index + size] if index + size < len(words) else ""
        before = words[index - 1] if index else ""
        if after in {"op", "suite", "film", "music"} and (index == 0 or before in BEFORE_KEY):
            return True
    return False


def significant(text: str) -> list[str]:
    return [w for w in text.split() if w not in KEY_STOP and len(w) >= 3]


def named(album_name: str, key: str) -> bool:
    """앨범 이름이 이 작품(영화·음반)을 가리키나. 한 낱말 제목(「Friends」「Eureka」)은 이름만으로 보지 않는다.
    철자가 조금 다른 제목(「Draughtman's」↔「Draughtsman's」)은 낱말마다 0.85 이상 비슷하면 같다고 본다."""
    if not key or NOT_SCORE.search(album_name):
        return False
    name = norm(album_name)
    key_words = significant(key)
    if len(key_words) < 2:
        return False
    if key in name:
        return True
    name_words = name.split()
    return all(
        any(difflib.SequenceMatcher(None, w, n).ratio() >= 0.85 for n in name_words)
        for w in key_words
    )


def match_parts(
    parts: list[dict[str, str]], tracks: list[dict[str, Any]]
) -> dict[str, dict[str, Any]]:
    """part_id → 트랙. 이름이 같거나 비슷한 것부터, 한 트랙에 한 곡."""
    pairs: list[tuple[float, str, int]] = []
    for part in parts:
        names = {part["name_en"], part["name_ko"]}
        if part.get("linked_title_en") and ": " in part["linked_title_en"]:
            names.add(part["linked_title_en"].rsplit(": ", 1)[1])
        cores = {core(n) for n in names if n and core(n)}
        seq = int(part["sequence_number"] or 0)
        for index, track in enumerate(tracks):
            tcore = core(track["name"])
            if not tcore:
                continue
            best = max(
                (difflib.SequenceMatcher(None, c, tcore).ratio() for c in cores), default=0.0
            )
            same_slot = seq == index + 1
            if best >= 0.88 or (same_slot and best >= 0.75):
                pairs.append((best + (0.01 if same_slot else 0), part["part_id"], index))
    pairs.sort(reverse=True)
    used_parts: set[str] = set()
    used_tracks: set[int] = set()
    out: dict[str, dict[str, Any]] = {}
    for _score, part_id, index in pairs:
        if part_id in used_parts or index in used_tracks:
            continue
        used_parts.add(part_id)
        used_tracks.add(index)
        out[part_id] = tracks[index]
    return out


def candidates(
    service: str, work: str, row: dict[str, str], group: dict[str, Any] | None, mb: dict[str, Any]
) -> list[str]:
    sur = norm(surname(row["english_name"]))
    key = key_title(display_key(row, group))
    ids: list[str] = list(mb.get(service, []))
    if service == "apple":
        for item in load(os.path.join(work, "apple_search", f"{row['id']}.json")).get(
            "results", []
        ):
            text = norm(item.get("collectionName", ""))
            if (
                (sur in norm(item.get("artistName", "")) or sur in text)
                and key
                and (key in text or text in key)
            ):
                ids.append(str(item["collectionId"]))
        song_path = os.path.join(work, "apple_search_song", f"{row['id']}.json")
        if os.path.exists(song_path):
            for item in load(song_path).get("results", []):
                text = norm(item.get("collectionName", "")) + " " + norm(item.get("artistName", ""))
                if sur in text and key and key in norm(item.get("trackName", "")):
                    ids.append(str(item["collectionId"]))
    else:
        for item in spotify_tracks_of_search(
            load(os.path.join(work, "spotify_search", f"{row['id']}.json"))
        ):
            text = norm(item["album"])
            if not (sur in norm(item["artists"]) or sur in text) or not key:
                continue
            if key in text or text in key or (not group and key in norm(item["track"])):
                ids.append(item["albumId"])
    return list(dict.fromkeys(ids))


def choose(
    service: str,
    albums: Albums,
    ids: list[str],
    row: dict[str, str],
    group: dict[str, Any] | None,
    parts: list[dict[str, str]],
    mb_ids: list[str],
) -> tuple[dict[str, Any] | None, dict[str, dict[str, Any]], str]:
    sur = norm(surname(row["english_name"]))
    key = key_title(display_key(row, group))
    cue = split_cue(row)[1] if not group else ""
    best: (
        tuple[tuple[int, int, int, int, int], dict[str, Any], dict[str, dict[str, Any]], str] | None
    ) = None
    for album_id in ids:
        album = albums.apple(album_id) if service == "apple" else albums.spotify(album_id)
        if (
            not album
            or not album["tracks"]
            or not has_composer(album, sur)
            or NOT_SCORE.search(album["name"])
        ):
            continue
        is_named = named(album["name"], key)
        matched = match_parts(parts, album["tracks"]) if parts else {}
        work_tracks = sum(1 for t in album["tracks"] if track_has_work(t["name"], key))
        why = ""
        if cue:
            hit = next((t for t in album["tracks"] if core(t["name"]) == core(cue)), None)
            if not hit or not (is_named or work_tracks):
                continue
            album = dict(album, url=hit["url"])
            why = "cue-track"
        elif parts:
            if not (is_named or len(matched) >= 3 or len(matched) * 2 >= len(parts)):
                continue
            # 이름만 맞고 곡이 거의 안 맞으면(같은 이름의 다른 시즌·크리스마스 음반) 쓰지 않는다
            if is_named and len(parts) >= 4 and len(matched) * 4 < len(parts):
                continue
            why = "named" if is_named else "parts"
        elif is_named:
            why = "named"
        elif work_tracks:
            why = "track"
        else:
            continue
        closeness = -abs(len(album["tracks"]) - len(parts)) if parts else 0
        rank = (len(matched), int(is_named), work_tracks, int(album_id in mb_ids), closeness)
        if best is None or rank > best[0]:
            best = (rank, album, matched, why)
    if best is None:
        return None, {}, ""
    return best[1], best[2], best[3]


def album_fits(album: dict[str, Any], key: str, parts: list[dict[str, str]]) -> bool:
    """지금 링크의 앨범이 이 작품을 담았다고 볼 수 있나(지울지 판단용, 고를 때보다 너그럽게):
    편곡·커버 음반이 아니고, 이름에 제목이 있거나(한 낱말 제목도) 트랙에 이 작품·안 곡이 하나라도 있다."""
    if NOT_SCORE.search(album["name"]):
        return False
    if named(album["name"], key) or (key and key in norm(album["name"])):
        return True
    if any(track_has_work(t["name"], key) for t in album["tracks"]):
        return True
    return bool(parts) and len(match_parts(parts, album["tracks"])) >= 1


def existing_album(service: str, albums: Albums, url: str) -> dict[str, Any] | None:
    if service == "apple":
        m = APPLE_ID.search(url)
        return albums.apple(m.group(1)) if m else None
    m = SPOTIFY_ALBUM.search(url)
    return albums.spotify(m.group(1)) if m else None


def main() -> None:
    work = sys.argv[1]
    rows = read_tsv(os.path.join(work, "top.tsv"))
    all_parts = read_tsv(os.path.join(work, "parts.tsv"))
    mb_urls: dict[str, dict[str, Any]] = load(os.path.join(work, "mb_urls.json"))
    groups = wave6_groups()
    albums = Albums(work)
    # 지금 링크가 가리키는 Apple 앨범을 한꺼번에 받아 둔다
    existing_ids = {m.group(1) for r in rows if (m := APPLE_ID.search(r["apple_music_url"]))}
    existing_ids |= {m.group(1) for p in all_parts if (m := APPLE_ID.search(p["linked_apple"]))}
    albums.fetch_apple(sorted(existing_ids))
    by_piece: dict[str, list[dict[str, str]]] = {}
    for part in all_parts:
        by_piece.setdefault(part["piece_id"], []).append(part)
    out: list[dict[str, Any]] = []
    for row in rows:
        group = groups.get((row["composer_id"], row["title"]))
        parts = [p for p in by_piece.get(row["id"], []) if not p["parent_part_id"]]
        sur = norm(surname(row["english_name"]))
        for service, col, part_col, linked_col in (
            ("apple", "apple_music_url", "apple_music_url", "linked_apple"),
            ("spotify", "spotify_url", "spotify_url", "linked_spotify"),
        ):
            mb = mb_urls.get(row["id"], {})
            ids = candidates(service, work, row, group, mb)
            album, matched, why = choose(
                service, albums, ids, row, group, parts, list(mb.get(service, []))
            )
            old = row[col]
            new = album["url"] if album else ""
            key = key_title(display_key(row, group))
            decision = ""
            if not old and new:
                decision = "fill"
            elif old and old != new:
                current = existing_album(service, albums, old)
                if current is None:
                    wrong = "gone" if service == "apple" else ""
                elif not has_composer(current, sur) or not album_fits(current, key, parts):
                    wrong = "wrong"
                else:
                    wrong = ""
                if wrong:
                    decision = f"replace-{wrong}" if new else f"clear-{wrong}"
            if decision:
                out.append(
                    {
                        "kind": "piece",
                        "pieceId": int(row["id"]),
                        "composer": row["english_name"],
                        "title": row["title"],
                        "service": service,
                        "old": old,
                        "new": new or None,
                        "decision": decision,
                        "why": why,
                        "album": album["name"] if album else None,
                    }
                )
            elif not old and not new:
                out.append(
                    {
                        "kind": "piece",
                        "pieceId": int(row["id"]),
                        "composer": row["english_name"],
                        "title": row["title"],
                        "service": service,
                        "old": old,
                        "new": None,
                        "decision": "not-found",
                        "why": "",
                        "album": None,
                    }
                )
            chosen_id = album["id"] if album else None
            for part in parts:
                track = matched.get(part["part_id"])
                if track and not part[part_col]:
                    out.append(
                        {
                            "kind": "part",
                            "pieceId": int(row["id"]),
                            "partId": int(part["part_id"]),
                            "name": part["name_en"] or part["name_ko"],
                            "service": service,
                            "old": "",
                            "new": track["url"],
                            "decision": "fill",
                            "track": track["name"],
                        }
                    )
                linked = part["linked_piece_id"]
                if not linked:
                    continue
                linked_old = part[linked_col]
                if track and not linked_old:
                    out.append(
                        {
                            "kind": "linked",
                            "pieceId": int(linked),
                            "partId": int(part["part_id"]),
                            "title": part["linked_title"],
                            "service": service,
                            "old": "",
                            "new": track["url"],
                            "decision": "fill",
                            "track": track["name"],
                        }
                    )
                elif linked_old and (not track or linked_old != track["url"]):
                    current = existing_album(service, albums, linked_old)
                    base = {
                        "kind": "linked",
                        "pieceId": int(linked),
                        "partId": int(part["part_id"]),
                        "title": part["linked_title"],
                        "service": service,
                        "old": linked_old,
                    }
                    if current is None:
                        if service == "apple":
                            out.append(
                                dict(
                                    base,
                                    new=track["url"] if track else None,
                                    decision="replace-gone" if track else "clear-gone",
                                    track=track["name"] if track else None,
                                )
                            )
                        continue
                    if current["id"] == chosen_id:
                        continue
                    if (
                        has_composer(current, sur)
                        and not NOT_SCORE.search(current["name"])
                        and (
                            named(current["name"], key)
                            or (bool(key) and key in norm(current["name"]))
                        )
                    ):
                        continue
                    if track:
                        out.append(
                            dict(
                                base,
                                new=track["url"],
                                decision="replace-other-album",
                                track=track["name"],
                                wrongAlbum=current["name"],
                            )
                        )
                        continue
                    own = core(part["name_en"] or part["name_ko"])
                    if not has_composer(current, sur) or not any(
                        core(t["name"]) == own for t in current["tracks"]
                    ):
                        out.append(
                            dict(
                                base,
                                new=None,
                                decision="clear-other-album",
                                track=None,
                                wrongAlbum=current["name"],
                            )
                        )
    with open(os.path.join(work, "decisions.jsonl"), "w", encoding="utf-8") as handle:
        for item in out:
            handle.write(json.dumps(item, ensure_ascii=False) + "\n")
    counts: dict[str, int] = {}
    for item in out:
        k = f"{item['kind']}:{item['service']}:{item['decision']}"
        counts[k] = counts.get(k, 0) + 1
    for k in sorted(counts):
        print(k, counts[k])


if __name__ == "__main__":
    main()
