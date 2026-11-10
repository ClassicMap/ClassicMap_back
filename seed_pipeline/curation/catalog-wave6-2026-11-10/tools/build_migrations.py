"""자동 카탈로그 SQL 을 마이그레이션 파일로 묶는다.

작곡가마다 머리 주석 + 카탈로그 SQL(<slug>.sql) + 숨김 SQL(<slug>_hide.sql) 을 잇고,
작곡가 여러 명을 한 파일에 넣는다(마이그레이션 번호를 아끼려고).

사용: python3 build_migrations.py --work <작업 폴더> --list composers.txt --target <migrations 폴더>
        --first 202611100201 --per-file 20 --name small_composer_catalogs --wave 6차
"""

import argparse
import csv
import json
import os
import re
from collections import Counter

csv.field_size_limit(10_000_000)

COMMON = """--
-- {wave}는 4차 규칙(사람·에이전트 판단 없음)을 그대로 썼다. 규칙은
-- seed_pipeline/curation/catalog-wave4-2026-10-12/auto/auto_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/{folder}/<작곡가>/(catalog.json·seed_map.json).
--   작품: MusicBrainz 에서 이 작곡가가 composer 인 work 중 다른 work 의 part 가 아니고
--     편곡·다른 판·발췌·단편·리믹스 표시가 없는 것. part 는 MB parts 순서대로 두 겹까지.
--   제목: 「Symphony no. 5 in C minor」 꼴은 「교향곡 5번 C단조」로 옮기고,
--     못 읽으면 원제를 둔다(MB 갈래가 가곡·오페라 등이면 「가곡 <원제>」).
--   seed 작품: MBID 가 작품이면 그 자리(제목을 위 꼴로 고치고 잠금), part 면 part 로 잇고,
--     편곡·다른 판·중복·리믹스면 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     판단이 서지 않는 seed 는 손대지 않고 보이게 둔다. 숨길 seed 가 카탈로그 제목을
--     쥐고 있으면 그 seed 제목 뒤에 까닭을 붙여 자리를 비운다(숨긴 작품이라 안 보임).
--   manual 작품: 제목·설명·링크는 바꾸지 않는다. MBID 가 엉뚱한 work 를 가리키면
--     (제목이 전혀 다름) 잇지 않고, MBID 가 없으면 영어 제목이 같은 작품에 잇는다
--     (식별자는 더하지 않음).
--   비교 구간이 있거나 part 가 가리키는 작품은 숨기지 않는다. 두 번 돌려도 같다.
"""


FILM_COMMON = """--
-- 영화·TV·게임·애니 작곡가는 4차 규칙 위에 음반 묶음을 얹었다(사람·에이전트 판단 없음).
-- 규칙은 seed_pipeline/curation/{folder}/tools/film_catalog.py, 작곡가별 자료는
-- seed_pipeline/curation/{folder}/<작곡가>/(catalog.json·seed_map.json·groups.json).
--   연주회용 작품(MB 갈래 교향곡·협주곡·오페라·칸타타 등, 우리말로 옮길 수 있는 갈래 제목,
--     갈래 없는 다악장·묶음)과 영화 단위 MB 작품(갈래 Soundtrack 이면서 part 가 있는 seed)은
--     4차 규칙 그대로 둔다.
--   큐·노래 seed 는 녹음이 실린 MusicBrainz 음반(release group) 하나에 묶는다. 음반이
--     한 줄 묶음 작품(type album, manual)이 되고 seed 는 그 안 곡(piece_parts.linked_piece_id)이
--     되며 제목은 「<묶음> 중 "<곡>"」으로 바뀐다. 곡 순서는 대표 판의 트랙 순서이고,
--     seed 가 없는 곡은 이름만 넣는다. seed 가 하나만 이어지는 음반은 묶지 않고 낱곡으로 둔다.
--   묶음 제목: 위키데이터에서 이 작곡가가 음악을 맡은 영화이면 「영화 <원제> 사운드트랙」,
--     그 영화의 한국어 위키백과 문서가 있으면 문서 제목을 한국 개봉 제목으로 쓴다.
--     모음집·TV·게임·애니·일반 음반은 음반 원제 그대로. 운영 작품 제목과 겹치면 「(음반)」.
--   어느 음반에도 없는 큐는 hidden_reason='catalog_unmatched' 로 숨긴다(지우지 않음).
--     노래는 음반에 없어도 보이게 둔다. 비교 구간이 있거나 part 가 가리키는 작품은
--     숨기지 않는다. 두 번 돌려도 같다.
"""


def read_names(path: str) -> dict[str, str]:
    with open(path, encoding="utf-8") as handle:
        return {
            r["id"]: r["name"]
            for r in csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE)
        }


def composer_block(
    work: str, cid: str, slug: str, name: str, wave: str, film: bool
) -> tuple[str, Counter[str]]:
    out = os.path.join(work, "out")
    with open(os.path.join(work, slug, "catalog.json"), encoding="utf-8") as handle:
        kinds = Counter(entry["kind"] for entry in json.load(handle))
    film_stats: dict[str, int] = {}
    if film:
        with open(os.path.join(work, slug, "stats.json"), encoding="utf-8") as handle:
            film_stats = json.load(handle)
    with open(os.path.join(work, slug, "seed_map.json"), encoding="utf-8") as handle:
        seeds = Counter(
            e["mapping"] if e["mapping"] != "unmatched" else e["reason"] for e in json.load(handle)
        )
    with open(os.path.join(out, slug + ".stats.json"), encoding="utf-8") as handle:
        stat = Counter(json.loads(handle.read().strip().splitlines()[-1]))
    with open(os.path.join(out, slug + ".sql"), encoding="utf-8") as handle:
        body = handle.read().strip()
    with open(os.path.join(out, slug + "_hide.sql"), encoding="utf-8") as handle:
        hide = handle.read().strip()
    match = re.search(r"seed 작품 (\d+)개를 목록에서 숨긴다", hide)
    hidden = int(match.group(1)) if match else 0
    total = sum(kinds.values())
    mapped = seeds["work"] + seeds["part"]
    head = [
        f"-- ===== {name} (composer_id {cid}) =====",
        f"-- 작품을 MusicBrainz 작품 구조로 다시 짠다({wave} 자동). 작품 {total}개"
        f"(묶음 {kinds['collection']}, 다악장 {kinds['multi_movement']}, 낱곡 {kinds['single']}),",
        f"-- 새 작품 {stat['pieces']}개, part {stat['parts']}개, 그 아래 {stat['children']}개.",
        f"-- seed {sum(seeds.values())}개 중 {mapped}개를 작품·part 에 잇고, {hidden}개를 숨기고,"
        f" {seeds['unreviewed']}개는 그대로 둔다.",
    ]
    if film:
        head[1] = (
            f"-- 큐를 음반 단위로 묶는다({wave}). 작품 {total}개 중 음반 묶음"
            f" {film_stats.get('film_groups', 0)}개, 그 밖(연주회용·영화 단위 MB 작품·노래·낱곡)"
            f" {total - film_stats.get('film_groups', 0)}개,"
        )
        head[3] = (
            f"-- seed {sum(seeds.values())}개 중 {seeds['part']}개를 음반 묶음 안 곡으로 잇고,"
            f" {seeds['work']}개는 낱개 작품으로 두고, {hidden}개를 숨긴다."
        )
    numbers: Counter[str] = Counter(
        works=total,
        new=stat["pieces"],
        seeds=sum(seeds.values()),
        mapped=mapped,
        hidden=hidden,
        kept=seeds["unreviewed"],
        retitled=stat["retitled_seed"],
    )
    parts = ["\n".join(head)]
    if body:
        parts.append(body)
    parts.append(hide)
    return "\n\n".join(parts) + "\n", numbers


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--work", required=True)
    parser.add_argument("--list", required=True)
    parser.add_argument("--target", required=True)
    parser.add_argument("--first", type=int, required=True)
    parser.add_argument("--per-file", type=int, default=20)
    parser.add_argument("--name", default="composer_catalogs")
    parser.add_argument("--wave", default="6차")
    parser.add_argument("--folder", default="catalog-wave6-2026-11-10")
    parser.add_argument("--film", action="store_true", help="film_catalog.py 결과(음반 묶음)")
    args = parser.parse_args()
    names = read_names(os.path.join(args.work, "db", "composers.tsv"))
    with open(args.list, encoding="utf-8") as handle:
        rows = [line.split()[:2] for line in handle if line.strip() and not line.startswith("#")]
    chunks = [rows[i : i + args.per_file] for i in range(0, len(rows), args.per_file)]
    for index, chunk in enumerate(chunks):
        blocks: list[str] = []
        totals: Counter[str] = Counter()
        for cid, slug in chunk:
            block, numbers = composer_block(args.work, cid, slug, names[cid], args.wave, args.film)
            blocks.append(block)
            totals.update(numbers)
        intro = (
            f"-- 작곡가 {len(chunk)}명의 작품을 MusicBrainz 작품 구조로 다시 짠다({args.wave} 자동,"
            f" {index + 1}/{len(chunks)}).\n"
            f"-- 작품 {totals['works']}개(새 {totals['new']}개), seed {totals['seeds']}개 중"
            f" 잇기 {totals['mapped']}·숨김 {totals['hidden']}·그대로 {totals['kept']}.\n"
        )
        common = (FILM_COMMON if args.film else COMMON).format(wave=args.wave, folder=args.folder)
        suffix = f"_{index + 1:02d}" if len(chunks) > 1 else ""
        if args.per_file == 1:
            suffix = "_" + chunk[0][1].replace("-", "_")
        path = os.path.join(args.target, f"{args.first + index}_add_{args.name}{suffix}.sql")
        with open(path, "w", encoding="utf-8") as handle:
            handle.write(intro + common + "\n" + "\n".join(blocks))
        print(os.path.basename(path), dict(totals))


if __name__ == "__main__":
    main()
