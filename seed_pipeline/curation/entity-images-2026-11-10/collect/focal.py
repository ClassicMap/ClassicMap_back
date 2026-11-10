"""faces.swift 결과(얼굴·상반신 상자)로 배너 초점과 얼굴 칸 잘림을 계산한다.

focal.py banner <faces.jsonl>
    배너 초점(CSS object-position 'x% y%'). 가로 값은 모바일(1.15:1)에서 얼굴이 가운데 오게,
    세로 값은 데스크톱(3.2:1)에서 얼굴 가운데가 보이는 띠의 45% 높이에 오게 한다.
    비슷한 크기의 얼굴이 여럿이면 묶어서 가운데를 잡는다.
    얼굴이 없으면 상반신, 그것도 없으면 50% 30%.
focal.py square <faces.jsonl>
    얼굴 칸(가운데 정사각)으로 잘랐을 때 가장 큰 얼굴 상자가 몇 % 들어오는지.
"""

from __future__ import annotations

import json
import sys
from pathlib import Path
from typing import Any

DESKTOP = 3.2
MOBILE = 1.15

Box = list[float]


def percent(value: float) -> int:
    return max(0, min(100, round(value * 100)))


def banner_focal(row: dict[str, Any]) -> tuple[str, str]:
    width, height = float(row["width"]), float(row["height"])
    faces: list[Box] = sorted(row.get("faces", []), key=lambda b: b[2] * b[3], reverse=True)
    bodies: list[Box] = sorted(row.get("bodies", []), key=lambda b: b[2] * b[3], reverse=True)
    if faces:
        biggest = faces[0][2] * faces[0][3]
        group = [box for box in faces if box[2] * box[3] >= biggest * 0.5]
        left = min(box[0] for box in group)
        right = max(box[0] + box[2] for box in group)
        top = min(box[1] for box in group)
        bottom = max(box[1] + box[3] for box in group)
        basis = f"face{len(group)}"
    elif bodies:
        box = bodies[0]
        left, right, top, bottom = box[0], box[0] + box[2], box[1], box[1] + box[3] * 0.4
        basis = "body"
    else:
        return "50% 30%", "none"
    center_x, center_y = (left + right) / 2, (top + bottom) / 2
    # 모바일: 높이를 1로 두면 그림 폭 = width/height, 보이는 폭 = MOBILE
    image_w = width / height
    x = (center_x * image_w - MOBILE / 2) / (image_w - MOBILE) if image_w > MOBILE else 0.5
    # 데스크톱: 폭을 1로 두면 그림 높이 = height/width, 보이는 높이 = 1/DESKTOP
    image_h, view_h = height / width, 1 / DESKTOP
    y = (center_y * image_h - view_h * 0.45) / (image_h - view_h) if image_h > view_h else 0.5
    return f"{percent(x)}% {percent(y)}%", basis


def square_inside(row: dict[str, Any]) -> float | None:
    width, height = float(row["width"]), float(row["height"])
    faces: list[Box] = sorted(row.get("faces", []), key=lambda b: b[2] * b[3], reverse=True)
    if not faces:
        return None
    x, y, w, h = faces[0][:4]
    if height >= width:
        low = (1 - width / height) / 2
        return max(0.0, min(y + h, 1 - low) - max(y, low)) / h
    low = (1 - height / width) / 2
    return max(0.0, min(x + w, 1 - low) - max(x, low)) / w


def main() -> None:
    command, source = sys.argv[1:3]
    for line in Path(source).read_text(encoding="utf-8").splitlines():
        row = json.loads(line)
        if "error" in row:
            continue
        if command == "banner":
            focal, basis = banner_focal(row)
            print(json.dumps({"file": row["file"], "focal": focal, "basis": basis}))
        else:
            inside = square_inside(row)
            print(json.dumps({"file": row["file"], "inside": inside}))


if __name__ == "__main__":
    main()
