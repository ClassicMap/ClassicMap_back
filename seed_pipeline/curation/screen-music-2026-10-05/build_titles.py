"""조사 결과(research/*.json)를 적재 입력(titles.jsonl)으로 바꾼다.

곡 매핑(MAP)은 사람이 확인해서 적은 값이다. 키는 "slug#order".
값은 (pieceId 또는 None, sectorKey 또는 None, 카탈로그에 없을 때 쓸 한국어 곡 이름).
sectorKey 는 영화에 나온 대목이 그 비교 구간과 분명히 같을 때만 적는다.
"""
import json
import re
import unicodedata
import sys
from pathlib import Path

HERE = Path(__file__).parent
RESEARCH = HERE / "research"

COMPOSERS = {c["id"]: c for c in json.load(open(HERE / "composers.json"))}
PIECES = {p["id"]: p for p in json.load(open(HERE / "pieces.json"))}
COMPOSER_IDS = json.load(open(HERE / "composer-map.json"))
COMPOSER_IDS["Sergei Prokofiev"] = 84
# 카탈로그에 없는 작곡가의 한국어 이름(2026-10-07 에 여섯 다 migration 202610070004 로 들어와 비었다)
MISSING_COMPOSERS: dict[str, str] = {}

MAP = {
    # 베토벤
    "a-clockwork-orange#4": (76, "mv2-opening", None),
    "a-clockwork-orange#5": (76, None, None),
    "a-clockwork-orange#6": (76, None, None),
    "beethoven-virus#1": (76, "mv4-freude-chorus", None),
    "death-in-venice#3": (82, "whole-work", None),
    "detective-conan#1": (78, "mv1-adagio", None),
    "fantasia-2000#1": (75, "mv1-fate", None),
    "fantasia#5": (437, "mv1-opening", None),
    "for-horowitz#1": (80, None, None),
    "four-hands#4": (79, None, None),
    "keys-to-the-heart#1": (78, "mv3-presto", None),
    "neon-genesis-evangelion#3": (76, "mv4-freude-chorus", None),
    "nodame-cantabile-anime#2": (438, None, None),
    "nodame-cantabile-anime#3": (77, None, None),
    "secret-affair#2": (440, "mv3-allegro-ma-non-troppo", None),
    "the-kings-speech#2": (438, "mv2-allegretto", None),
    "the-kings-speech#3": (80, "mv2-opening", None),
    "the-pianist#3": (78, "mv1-adagio", None),
    "your-lie-in-april#1": (26029, None, None),
    # 쇼팽
    "for-horowitz#2": (127, "whole-work", None),
    "forest-of-piano#1": (26047, "whole-work", None),
    "forest-of-piano#2": (463, "no11-whole", None),
    "forest-of-piano#3": (26048, "whole-work", None),
    "forest-of-piano#4": (26049, "mv3-funeral-march", None),
    "forest-of-piano#5": (26050, None, None),
    "forest-of-piano#6": (132, None, None),
    "keys-to-the-heart#2": (132, None, None),
    "the-pianist#1": (445, "whole-work", None),
    "the-pianist#2": (26036, None, None),
    "the-pianist#4": (129, "whole-work", None),
    "your-lie-in-april#3": (463, "no5-whole", None),
    "your-lie-in-april#5": (129, "whole-work", None),
    # 모차르트
    "amadeus#1": (26041, None, None),
    "amadeus#2": (26042, None, None),
    "amadeus#3": (26043, None, None),
    "amadeus#4": (71, "confutatis", None),
    "amadeus#5": (71, "lacrimosa", None),
    "amadeus#6": (72, "mv2-romanze", None),
    "elvira-madigan#1": (26058, None, None),
    "nodame-cantabile-anime#1": (26046, None, None),
    "secret-affair#5": (26035, None, None),
    "the-kings-speech#1": (69, "overture", None),
    "the-penthouse#1": (70, "der-holle-rache", None),
    "the-shawshank-redemption#1": (69, "sull-aria", None),
    # 바그너
    "apocalypse-now#1": (144, "whole-work", None),
    "melancholia#1": (145, "prelude-opening", None),
    "wednesday#5": (144, "whole-work", None),
    "whats-opera-doc#1": (144, "whole-work", None),
    "whats-opera-doc#2": (26053, None, None),
    "whats-opera-doc#3": (26054, None, None),
    "whats-opera-doc#4": (26055, None, None),
    "whats-opera-doc#5": (147, "opening", None),
    # 바흐
    "fantasia#1": (16, None, None),
    "four-hands#3": (432, "whole-work", None),
    "four-hands#5": (14951, None, None),
    "neon-genesis-evangelion#1": (12, "suite1-prelude", None),
    "secret-affair#3": (10, "wtc1-no1-prelude", None),
    "tar#1": (10, "wtc1-no1-prelude", None),
    "the-silence-of-the-lambs#1": (461, "aria", None),
    "thirst#1": (15339, None, None),
    # 말러
    "death-in-venice#1": (216, "mv4-adagietto", None),
    "death-in-venice#2": (11933, None, None),
    "decision-to-leave#1": (216, "mv4-adagietto-climax", None),
    "legend-of-the-galactic-heroes#1": (11933, None, None),
    "legend-of-the-galactic-heroes#3": (11293, None, None),
    "legend-of-the-galactic-heroes#5": (217, None, None),
    "tar#2": (216, "mv4-adagietto", None),
    # 비발디
    "oldboy#1": (28, "winter-mv1", None),
    "sympathy-for-lady-vengeance#1": (26038, None, None),
    "sympathy-for-lady-vengeance#3": (26039, None, None),
    "sympathy-for-lady-vengeance#4": (29, None, None),
    "sympathy-for-lady-vengeance#5": (29, None, None),
    "sympathy-for-lady-vengeance#6": (26040, None, None),
    "wednesday#1": (28, "winter-mv1", None),
    # 차이콥스키
    "black-swan#1": (162, None, None),
    "black-swan#2": (162, None, None),
    "black-swan#3": (162, None, None),
    "fantasia#2": (161, "waltz-of-the-flowers", None),
    "keys-to-the-heart#4": (159, "mv1-opening", None),
    "secret-affair#4": (26034, None, None),
    # 라흐마니노프
    "brief-encounter#1": (225, "mv1-opening", None),
    "brief-encounter#2": (225, None, None),
    "for-horowitz#5": (225, "mv1-opening", None),
    "four-hands#1": (225, "mv1-opening", None),
    "nodame-cantabile-anime#4": (225, "mv1-opening", None),
    "secret-affair#6": (227, "var18", None),
    # 로시니
    "a-clockwork-orange#2": (169, "whole-work", None),
    "a-clockwork-orange#3": (168, None, None),
    "beethoven-virus#2": (168, "finale", None),
    "the-penthouse#3": (167, None, None),
    # 헨델
    "maestra-strings-of-truth#2": (26057, None, None),
    "neon-genesis-evangelion#2": (21, "hallelujah-chorus", None),
    "parasite#1": (26024, None, None),
    "parasite#2": (26024, None, None),
    # 푸치니
    "mission-impossible-rogue-nation#1": (211, "aria", None),
    "mission-impossible-rogue-nation#2": (211, None, None),
    "my-paparotti#2": (212, "e-lucevan-le-stelle", None),
    "my-paparotti#3": (211, "aria", None),
    # 베르디
    "my-paparotti#1": (149, "la-donna-e-mobile", None),
    "pretty-woman#1": (148, "act1-sempre-libera", None),
    "pretty-woman#2": (148, "act2-che-fai-amami", None),
    "wednesday#4": (152, "dies-irae", None),
    # 리게티
    "2001-a-space-odyssey#2": (26026, None, None),
    "2001-a-space-odyssey#4": (26027, None, None),
    "2001-a-space-odyssey#6": (26028, None, None),
    # 슈만
    "do-you-like-brahms#1": (464, "no7-traumerei", None),
    "do-you-like-brahms#2": (26032, "whole-work", None),
    "for-horowitz#3": (464, "no7-traumerei", None),
    # 엘가
    "fantasia-2000#5": (265, None, None),
    "tar#3": (266, None, None),
    "wednesday#2": (266, "mv1-opening", None),
    # 요한 슈트라우스 2세
    "2001-a-space-odyssey#3": (185, "intro-waltz1", None),
    "squid-game#2": (185, "intro-waltz1", None),
    # 무소르크스키
    "death-in-venice#4": (26045, None, None),
    "fantasia#6": (191, "whole-work", None),
    # 스트라빈스키
    "fantasia-2000#6": (310, "danse-infernale", None),
    "fantasia#4": (309, "part1-introduction", None),
    # 드뷔시
    "for-horowitz#4": (224, "whole-work", None),
    "oceans-eleven#1": (220, "whole-work", None),
    # 생상스
    "four-hands#2": (253, None, None),
    "your-lie-in-april#2": (26030, None, None),
    # 브람스
    "keys-to-the-heart#3": (155, "whole-work", None),
    "nodame-cantabile-anime#5": (153, None, None),
    # 브루크너
    "legend-of-the-galactic-heroes#4": (183, None, None),
    "legend-of-the-galactic-heroes#6": (26056, None, None),
    # 마스카니
    "raging-bull#1": (276, None, None),
    "raging-bull#2": (26059, None, None),
    # 슈베르트
    "secret-affair#1": (26033, None, None),
    "sky-castle#1": (117, "whole", None),
    # 리스트
    "the-cat-concerto#1": (141, "whole-work", None),
    "the-penthouse#2": (143, "whole-work", None),
    # 그 밖
    "2001-a-space-odyssey#1": (26025, None, None),
    "2001-a-space-odyssey#5": (2799, None, None),
    "a-clockwork-orange#1": (37, None, None),
    "fantasia-2000#2": (26052, None, None),
    "fantasia-2000#3": (332, "opening", None),
    "fantasia-2000#4": (458, "mv1-allegro", None),
    "fantasia#3": (26051, None, None),
    "harmony#1": (14198, None, None),
    "legend-of-the-galactic-heroes#2": (197, "mv4-opening", None),
    "maestra-strings-of-truth#1": (122, None, None),
    "platoon#1": (26044, None, None),
    "sky-castle#2": (26037, None, None),
    "squid-game#1": (88, "mv3-finale", None),
    "sympathy-for-lady-vengeance#2": (164, None, None),
    "the-glory#1": (206, "no4-pie-jesu", None),
    "the-handmaiden#1": (47, "whole-work", None),
    "wednesday#3": (322, "dance-of-the-knights", None),
    "your-lie-in-april#4": (26031, "whole-work", None),
}

# 모아 보는 화면 순서. 한국 관객이 많이 본 작품부터
ORDER = [
    "squid-game", "parasite", "decision-to-leave", "oldboy", "the-shawshank-redemption",
    "the-kings-speech", "2001-a-space-odyssey", "your-lie-in-april", "do-you-like-brahms",
    "secret-affair", "beethoven-virus", "the-pianist", "apocalypse-now", "neon-genesis-evangelion",
    "wednesday", "sky-castle", "the-penthouse", "tomorrow-cantabile", "the-glory", "keys-to-the-heart",
    "sympathy-for-lady-vengeance", "the-handmaiden", "thirst", "amadeus", "the-silence-of-the-lambs",
    "tar", "platoon", "mission-impossible-rogue-nation", "pretty-woman", "oceans-eleven", "black-swan",
    "a-clockwork-orange", "melancholia", "death-in-venice", "detective-conan", "nodame-cantabile-anime",
    "forest-of-piano", "fantasia", "fantasia-2000", "the-cat-concerto", "whats-opera-doc",
    "legend-of-the-galactic-heroes", "my-paparotti", "for-horowitz", "harmony", "four-hands",
    "maestra-strings-of-truth", "brief-encounter", "elvira-madigan", "raging-bull",
]

# 확인 때 열리지 않은 근거(2026-10-05). 남은 근거로도 공개 기준을 넘는다
DEAD_URLS = {
    "https://www.animationmagazine.net/top-stories/the-case-of-the-copycat-concerto/",
}

# 2026-10-05 사용자가 확인 표의 149개를 모두 승인했다
STATUS = "PUBLISHED"

COVERS = json.load(open(HERE / "covers.json")) if (HERE / "covers.json").exists() else {}
# 영상마다 있는 가장 높은 썸네일 화질(probe_thumbs.py 가 잰다)
THUMBS = json.load(open(HERE / "thumbs.json")) if (HERE / "thumbs.json").exists() else {}
# 그 곡이 나오는 장면 그림과 곡이 들리기 시작하는 시점. 사람이 확인 표에서 고른 것과 추천
# ("<slug>/<cue key>" → {"frame": default·1·2·3 또는 null, "startSec": 초 또는 null,
#  "clip": 조사 때 없던 공식 장면 클립을 새로 찾았으면 그 클립, "source": 확인 표·추천})
SCENES_PATH = HERE / "scene-frames.json"
SCENE_FRAMES = json.loads(SCENES_PATH.read_text()) if SCENES_PATH.exists() else {}
# KMDb 포스터(probe_posters.py 가 찾고 사람이 확인한다). status 가 ok 인 것만 싣는다
POSTERS = json.load(open(HERE / "posters.json")) if (HERE / "posters.json").exists() else {}


def with_thumbs(clip: dict) -> dict:
    """앱이 없는 화질을 요청하지 않게 thumbJpg·thumbWebp 를 싣는다. 안 잰 영상은 그대로 둔다"""
    thumb = THUMBS.get(clip["videoId"]) or {}
    if not thumb.get("jpg"):
        return clip
    clip = dict(clip, thumbJpg=thumb["jpg"])
    if thumb.get("webp"):
        clip["thumbWebp"] = thumb["webp"]
    return clip

ID_NAMES = {
    "wikidata": "wikidata", "imdb": "imdb", "tmdbMovie": "tmdb_movie", "tmdbTv": "tmdb_tv",
    "kmdb": "kmdb", "anilist": "anilist",
}


def slugify(text: str, words: int) -> str:
    text = unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()
    text = re.sub(r"[^a-z0-9]+", "-", text.lower())
    return "-".join([w for w in text.split("-") if w][:words])


def episode_label(raw):
    if not raw:
        return None
    raw = raw.strip()
    if re.fullmatch(r"S\d+E\d+|E\d+", raw) or raw == "여러 회":
        return raw
    m = re.fullmatch(r"E(\d+)\s*[–-]\s*E(\d+)", raw)
    if m:
        return f"{int(m.group(1))}~{int(m.group(2))}화"
    return raw


def is_excerpt_title(title: str) -> bool:
    return " 중 " in title or title.startswith('"')


def main() -> int:
    problems = []
    problems_skipped = []
    titles = []
    files = {p.stem: p for p in RESEARCH.glob("*.json")}
    order = [s for s in ORDER if s in files] + sorted(s for s in files if s not in ORDER)
    for index, slug in enumerate(order, start=1):
        data = json.load(open(files[slug]))
        cues = []
        used_keys = set()
        for cue in data["cues"]:
            ref = f"{slug}#{cue['order']}"
            if ref not in MAP:
                problems.append(f"매핑 없음: {ref}")
                continue
            piece_id, sector_key, work_ko = MAP[ref]
            composer = cue["composer"]
            composer_id = COMPOSER_IDS.get(composer)
            if composer_id:
                composer_name = COMPOSERS[composer_id]["name"]
            else:
                composer_name = MISSING_COMPOSERS.get(composer)
                if not composer_name:
                    problems.append(f"작곡가 이름 없음: {ref} {composer}")
                    continue
            if piece_id:
                piece = PIECES[piece_id]
                if piece["composerId"] != composer_id:
                    problems.append(f"작곡가 불일치: {ref} piece {piece_id}")
                work_title = piece["title"]
            else:
                work_title = work_ko
            part = cue.get("partKo") or None
            if piece_id and is_excerpt_title(work_title):
                part = None
            evidence = [
                {"grade": e["grade"], "kind": e["kind"], "url": e["url"], "note": e["note"]}
                for e in cue.get("evidence", [])
                if e.get("grade") in ("1", "2") and e["url"] not in DEAD_URLS
            ]
            clip = cue.get("officialClip")
            if clip:
                clip = with_thumbs({
                    "videoId": clip["videoId"],
                    "startSec": int(clip.get("startSec") or 0),
                    "channel": clip["channel"],
                    "title": clip["title"],
                })
            base = slugify(composer.split()[-1], 1) + "-" + slugify(cue.get("work") or work_title, 4)
            if cue.get("part"):
                base += "-" + slugify(cue["part"], 3)
            key = base[:90].strip("-")
            if key in used_keys:
                key = f"{key}-{cue['order']}"
            used_keys.add(key)
            scene = SCENE_FRAMES.get(f"{slug}/{key}") or {}
            if not clip and scene.get("clip"):
                clip = with_thumbs(dict(scene["clip"]))
            if clip and scene.get("frame"):
                clip = dict(clip, sceneFrame=scene["frame"])
            if clip and isinstance(scene.get("startSec"), int):
                clip = dict(clip, startSec=scene["startSec"])
            entry = {
                "key": key,
                "order": cue["order"],
                "episode": episode_label(cue.get("episode")),
                "composerId": composer_id,
                "composerName": composer_name,
                "pieceId": piece_id,
                "workTitle": work_title,
                "part": part,
                "sectorKey": sector_key,
                "usage": cue["usage"],
                "arranged": bool(cue.get("arranged")),
                "approxAtSec": cue.get("approxAtSec") if cue.get("approxAtSec") not in (0,) else None,
                "sceneNote": cue["sceneNote"].strip(),
                "spoiler": bool(cue.get("spoiler")),
                "officialClip": clip,
                "evidence": evidence,
                "status": STATUS,
            }
            cues.append({k: v for k, v in entry.items() if v is not None or k in ("pieceId",)})
            if cues[-1].get("pieceId") is None:
                del cues[-1]["pieceId"]
            if cues[-1].get("composerId") is None:
                cues[-1].pop("composerId", None)
        identifiers = {}
        for name, value in (data.get("ids") or {}).items():
            if value is None or name not in ID_NAMES:
                continue
            identifiers[ID_NAMES[name]] = str(value)
        if not cues:
            problems_skipped.append(slug)
            continue
        # 작품 대표 그림: 권리자 공식 예고편(covers.json, oEmbed 로 채널 확인)
        cover = COVERS.get(slug)
        if cover:
            cover = with_thumbs(cover)
        poster = POSTERS.get(slug) or {}
        if poster.get("status") != "ok":
            poster = {}
        title = {
            "slug": slug,
            "kind": data["kind"],
            "titleKo": data["titleKo"].strip(),
            "titleOriginal": (data.get("titleOriginal") or "").strip() or None,
            "releaseYear": data.get("releaseYear"),
            "countryCode": data.get("countryCode"),
            "creditLine": (data.get("creditLine") or "").strip() or None,
            "coverClip": cover,
            "posterUrl": poster.get("posterUrl"),
            "posterCredit": poster.get("posterCredit"),
            "displayOrder": (len(titles) + 1) * 10,
            "status": STATUS,
            "identifiers": identifiers,
            "cues": cues,
        }
        titles.append({k: v for k, v in title.items() if v is not None})
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else HERE / "titles.jsonl"
    with open(out, "w") as handle:
        for title in titles:
            handle.write(json.dumps(title, ensure_ascii=False) + "\n")
    print(f"titles {len(titles)} cues {sum(len(t['cues']) for t in titles)} → {out}")
    for problem in problems:
        print("!!", problem)
    for slug in problems_skipped:
        print("-- 큐가 없어 뺌:", slug)
    return 1 if problems else 0


if __name__ == "__main__":
    raise SystemExit(main())
