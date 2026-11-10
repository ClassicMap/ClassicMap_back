"""P18 로 못 채운 연주자의 애플 뮤직·스포티파이 그림 후보로 받을 목록과 격자 칸을 만든다."""

from __future__ import annotations

import json
from pathlib import Path
from typing import Any

BASE = Path(__file__).resolve().parent
TARGETS = BASE.parent / "artists.tsv"


def jsonl(*names: str) -> dict[str, dict[str, Any]]:
    rows: dict[str, dict[str, Any]] = {}
    for name in names:
        path = BASE / "data" / name
        if path.exists():
            for line in path.read_text(encoding="utf-8").splitlines():
                if line.strip():
                    row = json.loads(line)
                    rows[row["key"]] = row
    return rows


picks = (BASE / "picks_p18.jsonl").read_text(encoding="utf-8").splitlines()
done = {json.loads(line)["id"] for line in picks}
targets = {
    int(fields[0]): fields
    for fields in (
        line.split("\t") for line in TARGETS.read_text(encoding="utf-8").splitlines()[1:]
    )
}
apple = jsonl("apple.jsonl")
spotify = jsonl(*(f"sp_out{part}.jsonl" for part in range(7)))
download = []
cells = []
cands: list[dict[str, Any]] = []
for aid in targets:
    if aid in done:
        continue
    key = f"a{aid}"
    am = apple.get(key)
    if am and am.get("artwork"):
        url = am["artwork"]["template"].replace("{w}x{h}{c}.{f}", "600x600bb.jpg")
        download.append(f"{key}_am.jpg\t{url}")
        cands.append(
            {
                "key": key,
                "id": aid,
                "source": "apple_music",
                "url": url,
                "appleId": am["appleId"],
                "matched": am.get("matchedName"),
                "title": am.get("title"),
                "file": f"{key}_am.jpg",
            }
        )
    sp = spotify.get(key)
    if sp and sp.get("avatar"):
        url = sp["avatar"]["url"]
        download.append(f"{key}_sp.jpg\t{url}")
        cands.append(
            {
                "key": key,
                "id": aid,
                "source": "spotify",
                "url": url,
                "spotifyId": sp["spotifyId"],
                "matched": sp.get("matchedName"),
                "title": sp.get("name"),
                "followers": sp.get("followers"),
                "width": sp["avatar"].get("width"),
                "height": sp["avatar"].get("height"),
                "file": f"{key}_sp.jpg",
            }
        )
for cand in cands:
    fields = targets[cand["id"]]
    tag = "AM" if cand["source"] == "apple_music" else "SP"
    search = " search" if cand.get("matched") else ""
    cells.append(
        {
            "image": str(BASE / "dl/svc" / cand["file"]),
            "crop": [1, 1],
            "focal": "50% 50%",
            "lines": [
                f"{fields[1]}{cand['id']} {fields[2]}"[:30],
                f"{fields[3][:20]} {fields[4][:8]}",
                f"{tag}{search} {(cand.get('title') or '')[:20]}",
            ],
        }
    )
(BASE / "data/dl_svc.tsv").write_text("\n".join(download) + "\n", encoding="utf-8")
(BASE / "data/svc_cands.json").write_text(
    json.dumps(cands, ensure_ascii=False, indent=1), encoding="utf-8"
)
(BASE / "data/cells_svc.json").write_text(json.dumps(cells, ensure_ascii=False), encoding="utf-8")
print("candidates", len(cands), "artists", len({cand["id"] for cand in cands}))
