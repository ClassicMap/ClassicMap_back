"""A 배너 picks 와 손본 곳(출처 https, 초점)으로 artist-banners.jsonl 을 만든다.
사용: build_banners.py <picks.jsonl> <출력 jsonl>"""

from __future__ import annotations

import json
import sys
from pathlib import Path

SOURCE = {
    303: "https://michaelfabianotenor.com/",
    635: "https://debilly.com/",
    699: "https://lastagione.de/",
    833: "https://www.junge-philharmonie-koeln.com/",
    855: "https://www.l2artists.com/samuel-ramey/",
}
# 데스크톱 띠에서 머리 위가 잘려 위로 올린다
FOCAL = {761: "18% 0%"}

rows = {}
for line in Path(sys.argv[1]).read_text(encoding="utf-8").splitlines():
    if not line.strip():
        continue
    row = json.loads(line)
    row.pop("localFile", None)
    row["sourceUrl"] = SOURCE.get(row["id"], row["sourceUrl"])
    row["focal"] = FOCAL.get(row["id"], row["focal"])
    # http 그림은 https 앱에서 막힌다: 같은 주소의 https 를 쓴다(200·image 확인)
    if row["url"].startswith("http://"):
        row["url"] = "https://" + row["url"][len("http://") :]
    rows[row["id"]] = row
with Path(sys.argv[2]).open("w", encoding="utf-8") as handle:
    for aid in sorted(rows):
        handle.write(json.dumps(rows[aid], ensure_ascii=False) + "\n")
print("banners", len(rows))
