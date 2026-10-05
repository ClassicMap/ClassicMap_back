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
# 카탈로그에 없는 작곡가의 한국어 이름
MISSING_COMPOSERS = {
    "György Ligeti": "리게티",
    "Richard Strauss": "리하르트 슈트라우스",
    "Ottorino Respighi": "레스피기",
    "Paul Dukas": "뒤카",
    "Samuel Barber": "바버",
    "Fritz Kreisler": "크라이슬러",
}

MAP = {
    # 베토벤
    "a-clockwork-orange#4": (76, None, None),
    "a-clockwork-orange#5": (76, None, None),
    "a-clockwork-orange#6": (76, None, None),
    "beethoven-virus#1": (76, None, None),
    "death-in-venice#3": (82, "whole-work", None),
    "detective-conan#1": (78, "mv1-adagio", None),
    "fantasia-2000#1": (75, "mv1-fate", None),
    "fantasia#5": (437, None, None),
    "for-horowitz#1": (80, None, None),
    "four-hands#4": (79, None, None),
    "keys-to-the-heart#1": (78, "mv3-presto", None),
    "neon-genesis-evangelion#3": (76, None, None),
    "nodame-cantabile-anime#2": (438, None, None),
    "nodame-cantabile-anime#3": (77, None, None),
    "secret-affair#2": (440, "mv3-allegro-ma-non-troppo", None),
    "the-kings-speech#2": (438, "mv2-allegretto", None),
    "the-kings-speech#3": (80, None, None),
    "the-pianist#3": (78, "mv1-adagio", None),
    "your-lie-in-april#1": (None, None, '바이올린 소나타 9번 A장조 "크로이처"'),
    # 쇼팽
    "for-horowitz#2": (127, "whole-work", None),
    "forest-of-piano#1": (None, None, "뱃노래 F#장조 Op. 60"),
    "forest-of-piano#2": (463, None, None),
    "forest-of-piano#3": (None, None, "연습곡 C장조 Op. 10, No. 1"),
    "forest-of-piano#4": (None, None, '피아노 소나타 2번 B♭단조 "장송"'),
    "forest-of-piano#5": (None, None, "피아노 소나타 3번 B단조"),
    "forest-of-piano#6": (132, None, None),
    "keys-to-the-heart#2": (132, None, None),
    "the-pianist#1": (445, "whole-work", None),
    "the-pianist#2": (None, None, "안단테 스피아나토와 화려한 대폴로네즈 Op. 22"),
    "the-pianist#4": (129, "whole-work", None),
    "your-lie-in-april#3": (463, None, None),
    "your-lie-in-april#5": (129, "whole-work", None),
    # 모차르트
    "amadeus#1": (None, None, "교향곡 25번 G단조 K. 183"),
    "amadeus#2": (None, None, '세레나데 10번 B♭장조 "그랑 파르티타" K. 361'),
    "amadeus#3": (None, None, "오페라 <돈 조반니> K. 527"),
    "amadeus#4": (71, None, None),
    "amadeus#5": (71, "lacrimosa", None),
    "amadeus#6": (72, "mv2-romanze", None),
    "elvira-madigan#1": (None, None, "피아노 협주곡 21번 C장조 K. 467"),
    "nodame-cantabile-anime#1": (None, None, "두 대의 피아노를 위한 소나타 D장조 K. 448"),
    "secret-affair#5": (None, None, "네 손을 위한 피아노 소나타 C장조 K. 521"),
    "the-kings-speech#1": (69, None, None),
    "the-penthouse#1": (70, "der-holle-rache", None),
    "the-shawshank-redemption#1": (69, "sull-aria", None),
    # 바그너
    "apocalypse-now#1": (144, "whole-work", None),
    "melancholia#1": (145, "prelude-opening", None),
    "wednesday#5": (144, "whole-work", None),
    "whats-opera-doc#1": (144, "whole-work", None),
    "whats-opera-doc#2": (None, None, "오페라 <방황하는 네덜란드인> 서곡"),
    "whats-opera-doc#3": (None, None, "오페라 <리엔치> 서곡"),
    "whats-opera-doc#4": (None, None, '오페라 <탄호이저> 중 "베누스베르크 음악"'),
    "whats-opera-doc#5": (147, None, None),
    # 바흐
    "fantasia#1": (16, None, None),
    "four-hands#3": (432, None, None),
    "four-hands#5": (None, None, "칸타타 <하나님의 시간이 가장 좋은 때> BWV 106"),
    "neon-genesis-evangelion#1": (12, None, None),
    "secret-affair#3": (10, None, None),
    "tar#1": (10, None, None),
    "the-silence-of-the-lambs#1": (461, None, None),
    "thirst#1": (None, None, "칸타타 <나는 만족하나이다> BWV 82"),
    # 말러
    "death-in-venice#1": (216, None, None),
    "death-in-venice#2": (None, None, "교향곡 3번 D단조"),
    "decision-to-leave#1": (216, None, None),
    "legend-of-the-galactic-heroes#1": (None, None, "교향곡 3번 D단조"),
    "legend-of-the-galactic-heroes#3": (None, None, "교향곡 9번 D장조"),
    "legend-of-the-galactic-heroes#5": (217, None, None),
    "tar#2": (216, None, None),
    # 비발디
    "oldboy#1": (28, None, None),
    "sympathy-for-lady-vengeance#1": (None, None, "칸타타 <그만, 이제 그만> RV 684"),
    "sympathy-for-lady-vengeance#3": (None, None, "현을 위한 협주곡 A장조 RV 159"),
    "sympathy-for-lady-vengeance#4": (29, None, None),
    "sympathy-for-lady-vengeance#5": (29, None, None),
    "sympathy-for-lady-vengeance#6": (None, None, "바순 협주곡 E단조 RV 484"),
    "wednesday#1": (28, None, None),
    # 차이콥스키
    "black-swan#1": (162, None, None),
    "black-swan#2": (162, None, None),
    "black-swan#3": (162, None, None),
    "fantasia#2": (161, None, None),
    "keys-to-the-heart#4": (159, None, None),
    "secret-affair#4": (None, None, '피아노 모음곡 <사계> 중 "4월"'),
    # 라흐마니노프
    "brief-encounter#1": (225, None, None),
    "brief-encounter#2": (225, None, None),
    "for-horowitz#5": (225, None, None),
    "four-hands#1": (225, None, None),
    "nodame-cantabile-anime#4": (225, None, None),
    "secret-affair#6": (227, None, None),
    # 로시니
    "a-clockwork-orange#2": (169, "whole-work", None),
    "a-clockwork-orange#3": (168, None, None),
    "beethoven-virus#2": (168, None, None),
    "the-penthouse#3": (167, None, None),
    # 헨델
    "maestra-strings-of-truth#2": (None, None, "파사칼리아 (할보르센 편곡)"),
    "neon-genesis-evangelion#2": (21, None, None),
    "parasite#1": (None, None, "오페라 <로델린다>"),
    "parasite#2": (None, None, "오페라 <로델린다>"),
    # 푸치니
    "mission-impossible-rogue-nation#1": (211, "aria", None),
    "mission-impossible-rogue-nation#2": (211, None, None),
    "my-paparotti#2": (212, None, None),
    "my-paparotti#3": (211, "aria", None),
    # 베르디
    "my-paparotti#1": (149, "la-donna-e-mobile", None),
    "pretty-woman#1": (148, None, None),
    "pretty-woman#2": (148, None, None),
    "wednesday#4": (152, "dies-irae", None),
    # 리게티
    "2001-a-space-odyssey#2": (None, None, "레퀴엠"),
    "2001-a-space-odyssey#4": (None, None, "룩스 에테르나"),
    "2001-a-space-odyssey#6": (None, None, "아트모스페르"),
    # 슈만
    "do-you-like-brahms#1": (464, "no7-traumerei", None),
    "do-you-like-brahms#2": (None, None, "헌정 (리스트 피아노 편곡)"),
    "for-horowitz#3": (464, "no7-traumerei", None),
    # 엘가
    "fantasia-2000#5": (265, None, None),
    "tar#3": (266, None, None),
    "wednesday#2": (266, None, None),
    # 요한 슈트라우스 2세
    "2001-a-space-odyssey#3": (185, "intro-waltz1", None),
    "squid-game#2": (185, "intro-waltz1", None),
    # 무소르크스키
    "death-in-venice#4": (None, None, "자장가"),
    "fantasia#6": (191, None, None),
    # 스트라빈스키
    "fantasia-2000#6": (310, None, None),
    "fantasia#4": (309, None, None),
    # 드뷔시
    "for-horowitz#4": (224, "whole-work", None),
    "oceans-eleven#1": (220, "whole-work", None),
    # 생상스
    "four-hands#2": (253, None, None),
    "your-lie-in-april#2": (None, None, "서주와 론도 카프리치오소 Op. 28"),
    # 브람스
    "keys-to-the-heart#3": (155, "whole-work", None),
    "nodame-cantabile-anime#5": (153, None, None),
    # 브루크너
    "legend-of-the-galactic-heroes#4": (183, None, None),
    "legend-of-the-galactic-heroes#6": (None, None, "교향곡 9번 D단조"),
    # 마스카니
    "raging-bull#1": (276, None, None),
    "raging-bull#2": (None, None, '오페라 <실바노> 중 "뱃노래"'),
    # 슈베르트
    "secret-affair#1": (None, None, "네 손을 위한 환상곡 F단조 D. 940"),
    "sky-castle#1": (117, "whole", None),
    # 리스트
    "the-cat-concerto#1": (141, "whole-work", None),
    "the-penthouse#2": (143, "whole-work", None),
    # 그 밖
    "2001-a-space-odyssey#1": (None, None, "교향시 <차라투스트라는 이렇게 말했다>"),
    "2001-a-space-odyssey#5": (None, None, '발레 <가야네> 중 "아다지오"'),
    "a-clockwork-orange#1": (37, None, None),
    "fantasia-2000#2": (None, None, "교향시 <로마의 소나무>"),
    "fantasia-2000#3": (332, "opening", None),
    "fantasia-2000#4": (458, None, None),
    "fantasia#3": (None, None, "교향시 <마법사의 제자>"),
    "harmony#1": (None, None, '<페르 귄트> 중 "솔베이그의 노래"'),
    "legend-of-the-galactic-heroes#2": (197, None, None),
    "maestra-strings-of-truth#1": (122, None, None),
    "platoon#1": (None, None, "현을 위한 아다지오"),
    "sky-castle#2": (None, None, '<어미 거위> 중 "요정의 정원"'),
    "squid-game#1": (88, "mv3-finale", None),
    "sympathy-for-lady-vengeance#2": (164, None, None),
    "the-glory#1": (206, "no4-pie-jesu", None),
    "the-handmaiden#1": (47, None, None),
    "wednesday#3": (322, None, None),
    "your-lie-in-april#4": (None, None, "사랑의 슬픔 (라흐마니노프 피아노 편곡)"),
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
        title = {
            "slug": slug,
            "kind": data["kind"],
            "titleKo": data["titleKo"].strip(),
            "titleOriginal": (data.get("titleOriginal") or "").strip() or None,
            "releaseYear": data.get("releaseYear"),
            "countryCode": data.get("countryCode"),
            "creditLine": (data.get("creditLine") or "").strip() or None,
            "coverClip": cover,
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
