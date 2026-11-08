"""작품 앨범 링크가 다른 작품 앨범을 가리키는지 어림한다.

세트 작품번호(Op. 11 같은)가 앨범 트랙 이름 어디에도 없으면 의심 목록에 올린다. 앨범이 작품번호를
트랙 이름에 안 적는 경우(라벨마다 다름)도 걸리므로 사람이 보고 고른다. 트랙을 못 받은 앨범(모음집,
지역 제한 등)은 따로 센다.
사용: python3 check_albums.py --parts <parts.tsv> --raw <트랙 JSON 폴더> > suspect_albums.tsv
"""

from __future__ import annotations

import argparse
import csv
import json
import re
import sys
from collections import defaultdict

from match import catalogue_regex, norm, tracks_of


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--parts", required=True)
    parser.add_argument("--raw", required=True)
    args = parser.parse_args()

    sets: dict[int, dict[str, str]] = {}
    with open(args.parts, encoding="utf-8") as handle:
        for row in csv.DictReader(handle, delimiter="\t"):
            sets.setdefault(int(row["piece_id"]), row)

    counts: dict[str, int] = defaultdict(int)
    out = csv.writer(sys.stdout, delimiter="\t", lineterminator="\n")
    out.writerow(["piece_id", "title", "catalogue", "album_name", "apple_music_url"])
    for piece_id, row in sorted(sets.items()):
        m = re.search(r"/(\d+)$", row["apple_music_url"].strip())
        tracks = tracks_of(args.raw, m.group(1)) if m else []
        if not tracks:
            counts["noTracks"] += 1
            continue
        cat = catalogue_regex(row["catalogue"])
        if not cat:
            counts["noCatalogue"] += 1
            continue
        if any(re.search(cat, norm(str(t.get("trackName", "")))) for t in tracks):
            counts["ok"] += 1
            continue
        counts["suspect"] += 1
        album = str(tracks[0].get("collectionName", ""))
        out.writerow([piece_id, row["title"], row["catalogue"], album, row["apple_music_url"]])
    print(json.dumps(counts), file=sys.stderr)


if __name__ == "__main__":
    main()
