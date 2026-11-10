"""P18 picks + 서비스(애플·스포티파이) 결정 + 웹 picks 로 연주자 얼굴 목록(repo jsonl)을 만든다.
사용: build_artist_faces.py <출력 jsonl> <missing tsv>"""

from __future__ import annotations

import json
import sys
from pathlib import Path
from typing import Any

BASE = Path(__file__).resolve().parent
NO_IMAGE = "위키데이터 대표 그림·애플 뮤직·스포티파이·웹에서 쓸 그림 없음"


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    lines = path.read_text(encoding="utf-8").splitlines()
    return [json.loads(line) for line in lines if line.strip()]


rows = {}
for line in (BASE.parent / "artists.tsv").read_text(encoding="utf-8").splitlines()[1:]:
    fields = line.split("\t")
    rows[int(fields[0])] = fields
picks = {row["id"]: row for row in read_jsonl(BASE / "picks_p18.jsonl")}
decisions = json.loads((BASE / "svc_decisions.json").read_text(encoding="utf-8"))
cands = json.loads((BASE / "data/svc_cands.json").read_text(encoding="utf-8"))
by_key = {(cand["key"], cand["source"]): cand for cand in cands}
for key, source in decisions["accept"].items():
    aid = int(key[1:])
    if aid in picks:
        continue
    cand = by_key[(key, source)]
    fields = rows[aid]
    if source == "apple_music":
        page = f"https://music.apple.com/us/artist/{cand['appleId']}"
        credit = "Apple Music"
        evidence = (
            f"iTunes search exact name + genre: {cand['matched']}"
            if cand.get("matched")
            else "Apple Music artist id from DB/Wikidata P2850"
        )
    else:
        page = f"https://open.spotify.com/artist/{cand['spotifyId']}"
        credit = "Spotify"
        evidence = (
            f"Spotify search exact name: {cand['matched']}"
            if cand.get("matched")
            else "Wikidata P1902"
        )
    picks[aid] = {
        "id": aid,
        "name": fields[2],
        "englishName": fields[3],
        "tier": fields[1],
        "url": cand["url"],
        "width": 600 if source == "apple_music" else cand.get("width"),
        "height": 600 if source == "apple_music" else cand.get("height"),
        "sourceUrl": page,
        "creditLine": credit,
        "kind": "web",
        "author": None,
        "license": None,
        "licenseUrl": None,
        "source": source,
        "evidence": evidence,
        "review": cand["file"],
    }
web_path = BASE / "picks_web.jsonl"
for row in read_jsonl(web_path) if web_path.exists() else []:
    # cso.org 는 chicagosymphony.org 로 301 넘긴다: 최종 주소를 넣는다
    row["url"] = row["url"].replace("https://cso.org/media/", "https://chicagosymphony.org/media/")
    # 영어 위키백과 지역 파일(PD-RU)은 커먼스 자유 라이선스 칸 대신 출처 이름으로 남긴다
    if row["kind"] == "wikimedia" and row.get("license") == "PD-RU":
        row.update(kind="web", creditLine="Wikipedia (en)", license=None, licenseUrl=None)
    # 출처 페이지가 http 로 적힌 3곳(410·524·530)은 https 로 열리는 것을 확인했다
    if row["sourceUrl"].startswith("http://"):
        row["sourceUrl"] = "https://" + row["sourceUrl"][len("http://") :]
    if row["id"] not in picks:
        row.setdefault("tier", rows[row["id"]][1])
        row.setdefault("source", "web")
        picks[row["id"]] = row
with Path(sys.argv[1]).open("w", encoding="utf-8") as handle:
    for aid in sorted(picks):
        handle.write(json.dumps(picks[aid], ensure_ascii=False) + "\n")
reasons_path = BASE / "missing_reasons.json"
reasons = json.loads(reasons_path.read_text(encoding="utf-8")) if reasons_path.exists() else {}
with Path(sys.argv[2]).open("w", encoding="utf-8") as handle:
    handle.write("id\ttier\tname\tenglish_name\tcategory\treason\n")
    for aid, fields in sorted(rows.items()):
        if aid not in picks:
            reason = reasons.get(str(aid), NO_IMAGE)
            handle.write("\t".join([str(aid), *fields[1:5], reason]) + "\n")
print("faces", len(picks), "missing", len(rows) - len(picks))
