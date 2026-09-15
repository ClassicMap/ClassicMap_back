"""작품에 Apple Music 앨범 링크를 붙일 후보를 만든다.

이름만 보고 붙이면 곡이 잘못 연결되므로, 제목에 적힌 작품번호(BWV·K·D·Op 등)가
Apple 쪽 결과에도 그대로 나타날 때만 자동 채택한다. 번호가 없는 작품은
제목 토큰이 충분히 겹칠 때만 후보로 남기고 판정은 사람이 한다.

운영 DB 에 직접 쓰지 않는다. 결과는 JSONL 로만 낸다.
"""
from __future__ import annotations

import base64
import json
import os
import re
import sys
import time
import unicodedata
import urllib.error
import urllib.parse
import urllib.request

from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import ec
from cryptography.hazmat.primitives.asymmetric import utils as asy

STOREFRONT = os.environ.get("APPLE_STOREFRONT", "us")

# 작품번호 표기. 클래식은 이 번호가 작품을 사실상 유일하게 특정한다.
CATALOGUE = re.compile(
    r"\b(BWV|KV|K|D|Op|op|Hob|WoO|RV|HWV|Wq|BB|Sz|S|L|FP|TrV|MWV|B|CD)\W{0,3}"
    r"(\d{1,4}[a-zA-Z]?(?:[/:-]\d{1,4}[a-zA-Z]?)?)",
)
_ROMAN = re.compile(r"\b(Hob|BWV)\.?\s*([IVXL]+)[:\s]?(\d+)?", re.I)


def norm(text: str) -> str:
    text = unicodedata.normalize("NFKD", text or "")
    text = "".join(c for c in text if not unicodedata.combining(c))
    return " ".join(re.sub(r"[^a-z0-9 ]", " ", text.lower()).split())


def catalogue_keys(title: str) -> set[str]:
    """제목에서 작품번호를 뽑아 비교 가능한 형태로 만든다."""
    keys: set[str] = set()
    for system, number in CATALOGUE.findall(title or ""):
        s = system.lower()
        if s == "k":
            s = "kv"          # 모차르트는 K 와 KV 를 섞어 쓴다
        keys.add(f"{s}{number.lower().replace(' ', '')}")
    for system, roman, sub in _ROMAN.findall(title or ""):
        keys.add(f"{system.lower()}{roman.lower()}{sub or ''}")
    return keys


def search_term(composer: str, title: str) -> str:
    """검색에 방해가 되는 표기를 걷어낸다.

    "Opera <Les Danaides>" 의 꺾쇠나 "B♭" 의 기호가 그대로 들어가면
    Apple 검색이 0건을 돌려준다. 장르 접두어와 진위 표기도 검색에는 잡음이다.
    """
    text = title or ""
    text = re.sub(r"[<>«»\[\]{}]", " ", text)
    text = text.replace("♭", "b").replace("♯", "#").replace("’", "'")
    text = re.sub(r"\((?:spurious|doubtful|attrib[^)]*|lost)[^)]*\)", " ", text, flags=re.I)
    text = re.sub(r"^\s*(Opera|Oper|Ballet|Cantata|Motet|Symphony No\.)\s+", "", text, flags=re.I)
    text = " ".join(text.split())
    return f"{composer} {text}"[:180]


def core_tokens(title: str) -> set[str]:
    """흔한 편성·조성어를 뺀 식별력 있는 토큰만 남긴다."""
    generic = {
        "concerto", "sonata", "suite", "quartet", "quintet", "trio", "symphony",
        "prelude", "fugue", "variations", "march", "waltz", "song", "songs",
        "opera", "overture", "study", "studies", "sharp", "flat", "solo",
    }
    return {t for t in title_tokens(title) if t not in generic and len(t) > 3}


def title_tokens(title: str) -> set[str]:
    stop = {
        "op", "no", "in", "for", "and", "the", "of", "a", "an", "de", "la", "le",
        "major", "minor", "dur", "moll", "pour", "et", "fur", "von", "das", "der",
        "die", "nr", "piano", "violin", "cello",
    }
    return {t for t in norm(title).split() if t not in stop and len(t) > 1}


class Apple:
    def __init__(self) -> None:
        pem = os.environ["APPLE_MUSIC_PRIVATE_KEY"].replace("\\n", "\n")
        self._key = serialization.load_pem_private_key(pem.encode(), password=None)
        self._kid = os.environ["APPLE_MUSIC_KEY_ID"]
        self._team = os.environ["APPLE_MUSIC_TEAM_KEY"]
        self._token = ""
        self._exp = 0.0

    def _b64(self, raw: bytes) -> bytes:
        return base64.urlsafe_b64encode(raw).rstrip(b"=")

    def token(self) -> str:
        now = time.time()
        if self._token and now < self._exp - 300:
            return self._token
        issued = int(now)
        head = {"alg": "ES256", "kid": self._kid}
        claim = {"iss": self._team, "iat": issued, "exp": issued + 3600}
        signing = (
            self._b64(json.dumps(head, separators=(",", ":")).encode())
            + b"."
            + self._b64(json.dumps(claim, separators=(",", ":")).encode())
        )
        der = self._key.sign(signing, ec.ECDSA(hashes.SHA256()))
        r, s = asy.decode_dss_signature(der)
        sig = self._b64(r.to_bytes(32, "big") + s.to_bytes(32, "big"))
        self._token = (signing + b"." + sig).decode()
        self._exp = issued + 3600
        return self._token

    def search_albums(self, term: str, limit: int = 8) -> list[dict]:
        query = urllib.parse.urlencode({"term": term, "types": "albums", "limit": limit})
        url = f"https://api.music.apple.com/v1/catalog/{STOREFRONT}/search?{query}"
        for attempt in range(5):
            req = urllib.request.Request(
                url, headers={"Authorization": f"Bearer {self.token()}"}
            )
            try:
                with urllib.request.urlopen(req, timeout=30) as response:
                    payload = json.load(response)
                return payload.get("results", {}).get("albums", {}).get("data", [])
            except urllib.error.HTTPError as error:
                if error.code in (429, 500, 502, 503):
                    time.sleep(2 * (attempt + 1))
                    continue
                if error.code == 404:
                    return []
                raise
            except Exception:
                time.sleep(2 * (attempt + 1))
        return []


def decide(piece: dict, albums: list[dict]) -> dict:
    """작품번호가 겹치면 채택, 제목만 겹치면 보류로 분류한다."""
    want_cat = catalogue_keys(piece["title_en"])
    want_tok = title_tokens(piece["title_en"])
    composer_tok = title_tokens(piece["composer_en"])

    scored = []
    for album in albums:
        attrs = album.get("attributes", {})
        name = attrs.get("name", "")
        artist = attrs.get("artistName", "")
        got_cat = catalogue_keys(name)
        got_tok = title_tokens(name)
        composer_hit = bool(composer_tok & title_tokens(f"{name} {artist}"))
        cat_hit = bool(want_cat & got_cat)
        overlap = len(want_tok & got_tok) / max(len(want_tok), 1)
        scored.append(
            {
                "id": album.get("id"),
                "url": attrs.get("url"),
                "name": name,
                "artist": artist,
                "cat_hit": cat_hit,
                "composer_hit": composer_hit,
                "overlap": round(overlap, 3),
            }
        )

    # 작품번호가 맞고 작곡가도 보이면 자동 채택한다
    exact = [c for c in scored if c["cat_hit"] and c["composer_hit"]]
    if exact:
        exact.sort(key=lambda c: -c["overlap"])
        return {"verdict": "auto", "reason": "catalogue+composer", "pick": exact[0], "candidates": scored[:4]}
    if want_cat:
        cat_only = [c for c in scored if c["cat_hit"]]
        if cat_only:
            cat_only.sort(key=lambda c: -c["overlap"])
            return {"verdict": "review", "reason": "catalogue_only", "pick": cat_only[0], "candidates": scored[:4]}
        return {"verdict": "none", "reason": "catalogue_not_found", "pick": None, "candidates": scored[:4]}

    # 작품번호가 아예 없는 제목은 식별력 있는 고유어가 겹치는지로 본다.
    want_core = core_tokens(piece["title_en"])
    if want_core:
        for cand in scored:
            cand["core_hit"] = len(want_core & core_tokens(cand["name"])) / len(want_core)
        core_strong = [c for c in scored if c["composer_hit"] and c.get("core_hit", 0) >= 0.5]
        if core_strong:
            core_strong.sort(key=lambda c: (-c["core_hit"], -c["overlap"]))
            return {"verdict": "review", "reason": "core_title_match", "pick": core_strong[0], "candidates": scored[:4]}

    strong = [c for c in scored if c["composer_hit"] and c["overlap"] >= 0.8]
    if strong:
        strong.sort(key=lambda c: -c["overlap"])
        return {"verdict": "review", "reason": "title_only_strong", "pick": strong[0], "candidates": scored[:4]}
    return {"verdict": "none", "reason": "no_catalogue_weak_title", "pick": None, "candidates": scored[:4]}


def main() -> None:
    src, dst = sys.argv[1], sys.argv[2]
    start = int(sys.argv[3]) if len(sys.argv) > 3 else 0
    count = int(sys.argv[4]) if len(sys.argv) > 4 else 10**9

    pieces = [json.loads(line) for line in open(src) if line.strip()][start : start + count]
    apple = Apple()
    stats = {"auto": 0, "review": 0, "none": 0}
    with open(dst, "a") as out:
        for index, piece in enumerate(pieces, 1):
            term = search_term(piece["composer_en"], piece["title_en"])
            try:
                albums = apple.search_albums(term)
            except Exception as error:  # 개별 실패가 전체를 멈추지 않게 한다
                print(f"  검색 실패 piece={piece['id']} {type(error).__name__}", flush=True)
                continue
            result = decide(piece, albums)
            stats[result["verdict"]] += 1
            out.write(json.dumps({**piece, **result}, ensure_ascii=False) + "\n")
            if index % 200 == 0:
                out.flush()
                print(f"  {index}/{len(pieces)}  auto {stats['auto']} review {stats['review']} none {stats['none']}", flush=True)
    print(f"완료: auto {stats['auto']} / review {stats['review']} / none {stats['none']}")


if __name__ == "__main__":
    main()
