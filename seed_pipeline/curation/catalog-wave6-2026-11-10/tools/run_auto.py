"""4차 auto/auto_catalog.py 를 고치지 않고, MusicBrainz 요청만 이 폴더의 fetch.py 로 돌린다.

auto_catalog.py 는 `from fetch import mb` 로 수집기를 읽는다. 이 폴더의 fetch 를 먼저 읽어 두면
같은 이름의 모듈이 이미 있어 그대로 쓰인다(User-Agent 연락처·캐시 폴더만 다르다).

--keep-kana 는 일본 작곡가용이다. 「가나 제목이면 대중음악」 규칙을 끄고, 라틴 문자가 없는
제목끼리 같은 제목으로 보는 일을 막는다. 일본 작곡가는 가곡·동요·피아노곡도 제목이 가나라
이 규칙에 걸려 모두 숨겨졌다(그 밖의 규칙은 그대로).

사용(seed_pipeline 에서):
    uv run python <이 파일> --composer-id 100 --slug satie --db <덤프> --out <폴더> [--keep-kana]
"""

import importlib.util
import os
import re
import sys
from typing import Any

HERE = os.path.dirname(os.path.abspath(__file__))
AUTO = os.path.join(
    os.path.dirname(os.path.dirname(HERE)), "catalog-wave4-2026-10-12", "auto", "auto_catalog.py"
)

sys.path.insert(0, HERE)
import fetch  # noqa: E402

sys.modules["fetch"] = fetch


def main() -> None:
    keep_kana = "--keep-kana" in sys.argv
    sys.argv = [arg for arg in sys.argv if arg != "--keep-kana"]
    spec = importlib.util.spec_from_file_location("auto_catalog", AUTO)
    assert spec and spec.loader
    auto: Any = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(auto)
    if keep_kana:
        auto.KANA = re.compile(r"(?!)")
        # 같은 제목 판단(normal_title)은 라틴 문자만 남겨서 일본어 제목은 모두 빈 문자열이 되고
        # 서로 다른 곡이 「같은 제목」으로 묶여 중복으로 숨겨진다. 비면 원제(공백 뺀 소문자)로 본다.
        latin_only = auto.normal_title

        def normal_title(title: str) -> str:
            return str(latin_only(title)) or "raw:" + re.sub(r"\s+", "", title.lower())

        auto.normal_title = normal_title
    auto.main()


if __name__ == "__main__":
    main()
