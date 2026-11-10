"""4차 auto/auto_catalog.py 를 고치지 않고, MusicBrainz 요청만 이 폴더의 fetch.py 로 돌린다.

auto_catalog.py 는 `from fetch import mb` 로 수집기를 읽는다. 이 폴더의 fetch 를 먼저 읽어 두면
같은 이름의 모듈이 이미 있어 그대로 쓰인다(User-Agent 연락처·캐시 폴더만 다르다).

사용(seed_pipeline 에서):
    uv run python <이 파일> --composer-id 100 --slug satie --db <덤프> --out <폴더>
"""

import os
import runpy
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
AUTO = os.path.join(
    os.path.dirname(os.path.dirname(HERE)), "catalog-wave4-2026-10-12", "auto", "auto_catalog.py"
)

sys.path.insert(0, HERE)
import fetch  # noqa: E402

sys.modules["fetch"] = fetch
runpy.run_path(AUTO, run_name="__main__")
