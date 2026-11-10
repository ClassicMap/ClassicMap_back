"""눈으로 본 P18 결정으로 연주자 얼굴 후보(위키미디어)를 jsonl 로 만든다."""

from __future__ import annotations

import json
import re
from pathlib import Path

BASE = Path(__file__).resolve().parent
REJECT = {878, 377, 378, 387, 425, 428, 439, 443, 448, 454, 478, 490, 506, 516, 544, 848, 883}
UNKNOWN = re.compile(
    r"unknown|anonymous|unidentified|non identifi|name is not written|not known", re.I
)
MAILTO = re.compile(r"\s*<mailto:[^>]*>")
meta = json.loads((BASE / "data/p18_meta.json").read_text(encoding="utf-8"))
files = json.loads((BASE / "data/commons_p18.json").read_text(encoding="utf-8"))
rows = {}
for line in (BASE.parent / "artists.tsv").read_text(encoding="utf-8").splitlines()[1:]:
    fields = line.split("\t")
    rows[int(fields[0])] = fields
out = []
for key, m in meta.items():
    if m["id"] in REJECT:
        continue
    info = files[m["file"]]
    url = info["url"].split("?", 1)[0]
    if info["mime"] == "image/tiff":
        head, name = url.rsplit("/", 1)
        head = head.replace("/wikipedia/commons/", "/wikipedia/commons/thumb/", 1)
        width = 960 if info["width"] >= 960 else 500
        url = f"{head}/{name}/lossy-page1-{width}px-{name}.jpg"
    raw_author = MAILTO.sub("", info.get("artist") or "").strip()
    author = None if not raw_author or UNKNOWN.search(raw_author) else raw_author
    fields = rows[m["id"]]
    out.append(
        {
            "id": m["id"],
            "name": fields[2],
            "englishName": fields[3],
            "tier": fields[1],
            "url": url,
            "width": info["width"],
            "height": info["height"],
            "sourceUrl": info["descriptionUrl"].split("?", 1)[0],
            "creditLine": None,
            "kind": "wikimedia",
            "author": author,
            "license": info["license"],
            "licenseUrl": info.get("licenseUrl"),
            "source": "wikidata-p18",
            "evidence": "Wikidata P18 of the linked item",
            "review": "p18grid/" + key,
        }
    )
out.sort(key=lambda row: row["id"])
with (BASE / "picks_p18.jsonl").open("w", encoding="utf-8") as handle:
    for row in out:
        handle.write(json.dumps(row, ensure_ascii=False) + "\n")
print("p18 picks", len(out))
