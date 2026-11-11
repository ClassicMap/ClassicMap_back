"""MusicBrainz work 조회와 4차 규칙 모듈 읽기.

4차 auto_catalog.py(제목 옮기기·편곡 판정)와 6차 fetch.py(1.1초 간격·캐시·연락처 User-Agent)를
고치지 않고 그대로 읽어 쓴다. 캐시 폴더는 CM_FETCH_CACHE 로 바꾼다(커밋하지 않음).
"""

import importlib.util
import os
import sys
from types import ModuleType
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
CURATION = os.path.dirname(os.path.dirname(HERE))
WAVE6_TOOLS = os.path.join(CURATION, "catalog-wave6-2026-11-10", "tools")
AUTO_PATH = os.path.join(CURATION, "catalog-wave4-2026-10-12", "auto", "auto_catalog.py")
GEN_PATH = os.path.join(CURATION, "catalog-wave4-2026-10-12", "gen_catalog.py")
CLASSIFY_PATH = os.path.join(CURATION, "piece-forms-2026-11-07", "classify.py")

sys.path.insert(0, WAVE6_TOOLS)
import fetch  # type: ignore[import-not-found,unused-ignore]  # noqa: E402

sys.modules["fetch"] = fetch

WORK_INC = "work-rels+artist-rels+aliases"


def load(name: str, path: str) -> ModuleType:
    spec = importlib.util.spec_from_file_location(name, path)
    assert spec and spec.loader
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


auto: Any = load("auto_catalog", AUTO_PATH)
gen: Any = load("gen_catalog", GEN_PATH)
classify: Any = load("piece_classify", CLASSIFY_PATH)


def work(mbid: str) -> dict[str, Any] | None:
    """work 하나(관계 포함). 합쳐진 MBID 면 MB 가 새 work 를 돌려준다. 없으면 None."""
    data: dict[str, Any] | None = fetch.mb("work/" + mbid, {"inc": WORK_INC})
    return data


def parents(data: dict[str, Any]) -> list[tuple[str, str]]:
    """이 work 가 part 로 들어 있는 부모 work (id, 제목)."""
    return [
        (rel["work"]["id"], rel["work"]["title"])
        for rel in data.get("relations", [])
        if rel.get("target-type") == "work"
        and rel["type"] == "parts"
        and rel["direction"] == "backward"
    ]


def children(data: dict[str, Any]) -> list[tuple[float, str, str, bool]]:
    """이 work 의 part 들 (순서, id, 제목, 악장 표시). MB ordering-key 순."""
    out: list[tuple[float, str, str, bool]] = []
    for rel in data.get("relations", []):
        if (
            rel.get("target-type") != "work"
            or rel["type"] != "parts"
            or rel["direction"] != "forward"
        ):
            continue
        key = rel.get("ordering-key")
        order = float(key) if key is not None else 9999.0
        movement = "movement" in (rel.get("attributes") or [])
        if all(c[1] != rel["work"]["id"] for c in out):
            out.append((order, rel["work"]["id"], rel["work"]["title"], movement))
    return sorted(out)


def composers(data: dict[str, Any]) -> set[str]:
    return {
        rel["artist"]["id"]
        for rel in data.get("relations", [])
        if rel.get("target-type") == "artist" and rel["type"] == "composer"
    }
