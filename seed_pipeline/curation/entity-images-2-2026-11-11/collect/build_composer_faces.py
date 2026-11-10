"""작곡가 얼굴 picks + 검토 결정(김동진 출처, 수리스 추가)으로 composer-faces.jsonl 을 만든다.
사용: build_composer_faces.py <picks.jsonl> <출력 jsonl>"""

from __future__ import annotations

import json
import sys
from pathlib import Path

CREDIT = {
    103: "조선일보 · 일러스트 이철원",
    177: "X @sweeney1_b",
    190: "jeancatoire.com",
    251: "albertguinovart.com",
    289: "大中恩音楽記念館",
    299: "SoundCloud (Franck Bedrossian)",
    313: "meinrad-schuetter.ch",
    319: "zdenekzahradnik.cz",
    368: "bruceduffie.com",
    141: "Store norske leksikon · NTB",
    443: "Wikipedia (he)",
    385: "markoconnor.com",
    388: "Discogs",
    470: "YouTube · Ken-Pの音楽学校",
}
SOURCE = {368: "https://www.bruceduffie.com/wild.html"}
EXTRA = [
    {
        "id": 160,
        "name": "André Souris",
        "englishName": "André Souris",
        "url": "https://www.oprl.be/sites/default/files/styles/max_2600x2600/public/2018-08/"
        "Rameau%20Souris%20sans%20texte.jpg?itok=h8M3NpXk",
        "width": 1280,
        "height": 720,
        "sourceUrl": "https://www.oprl.be/fr/actualites/"
        "oprl-live-la-video-de-la-semaine-en-ligne-49",
        "creditLine": "OPRL (Orchestre Philharmonique Royal de Liège)",
        "kind": "web",
        "author": None,
        "license": None,
        "licenseUrl": None,
        "evidence": "OPRL page about its Rameau/Souris video; 20th-century single portrait "
        "matching other Souris photos (Forum des Compositeurs 448x336, musiwall)",
        "note": "face 0.78 inside the centre square; accepted under the relaxed rule",
    }
]

rows = {}
for line in Path(sys.argv[1]).read_text(encoding="utf-8").splitlines():
    if not line.strip():
        continue
    r = json.loads(line)
    if r["kind"] == "wikimedia" and not r.get("license"):
        # 다른 언어 위키백과의 비자유 파일: 자유 라이선스가 아니므로 출처 이름으로 남긴다
        r["kind"] = "web"
    if r.get("creditLine") == "Spotify artist image":
        r["creditLine"] = "Spotify"
    credit = (
        (r.get("creditLine") or "")
        .replace(" · Photo: unknown / ", " · ")
        .replace(" · Photo: ", " · ")
    )
    r["creditLine"] = CREDIT.get(r["id"], credit)
    r["sourceUrl"] = SOURCE.get(r["id"], r["sourceUrl"])
    rows[r["id"]] = r
for r in EXTRA:
    rows.setdefault(r["id"], r)
with open(sys.argv[2], "w", encoding="utf-8") as handle:
    for cid in sorted(rows):
        handle.write(json.dumps(rows[cid], ensure_ascii=False) + "\n")
print("composer faces", len(rows))
