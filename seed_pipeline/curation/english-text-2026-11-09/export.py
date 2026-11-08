"""시험 DB 에서 번역할 한국어 원문과 문맥(영어 이름·제목)을 in/<종류>.jsonl 로 받는다.

사용: python3 -I export.py <비밀번호 파일> <출력 폴더> [종류 …]
DB 는 로컬 dev MySQL(docker cm-dev-mysql, classicmap_combined)에서 읽기만 한다.
"""

from __future__ import annotations

import json
import os
import subprocess
import sys
from typing import Any

QUERIES: dict[str, str] = {
    "composers": (
        "SELECT JSON_OBJECT('id', id, 'name', english_name, 'bio', bio, 'style', style,"
        " 'influence', influence) FROM composers WHERE hidden_reason IS NULL"
        " AND (COALESCE(bio,'')<>'' OR COALESCE(style,'')<>'' OR COALESCE(influence,'')<>'')"
        " ORDER BY id"
    ),
    "artists": (
        "SELECT JSON_OBJECT('id', id, 'name', english_name, 'category', category, 'bio', bio,"
        " 'style', style) FROM artists WHERE COALESCE(bio,'')<>'' OR COALESCE(style,'')<>''"
        " ORDER BY id"
    ),
    "awards": (
        "SELECT JSON_OBJECT('id', aw.id, 'artist', a.english_name, 'year', aw.year,"
        " 'award_name', aw.award_name, 'organization', aw.organization)"
        " FROM artist_awards aw JOIN artists a ON a.id=aw.artist_id ORDER BY aw.id"
    ),
    "pieces": (
        "SELECT JSON_OBJECT('id', p.id, 'composer', c.english_name, 'title_en', p.title_en,"
        " 'description', p.description) FROM pieces p JOIN composers c ON c.id=p.composer_id"
        " WHERE COALESCE(p.description,'')<>'' AND p.hidden_reason IS NULL ORDER BY p.id"
    ),
    "sectors": (
        "SELECT JSON_OBJECT('id', s.id, 'composer', c.english_name, 'piece_title_en', p.title_en,"
        " 'name_ko', COALESCE(s.name_ko, s.sector_name), 'name_en', s.name_en,"
        " 'description', s.description) FROM performance_sectors s"
        " JOIN pieces p ON p.id=s.piece_id JOIN composers c ON c.id=p.composer_id"
        " WHERE COALESCE(s.description,'')<>''"
        " OR ((s.name_en IS NULL OR s.name_en='') AND s.editorial_status='PUBLISHED')"
        " ORDER BY s.id"
    ),
    "notes": (
        "SELECT JSON_OBJECT('id', n.performance_id, 'piece_title_en', p.title_en,"
        " 'sector_en', s.name_en, 'headline', n.headline, 'note', n.note, 'facts', n.facts)"
        " FROM performance_listening_notes n JOIN performances pf ON pf.id=n.performance_id"
        " JOIN performance_sectors s ON s.id=pf.sector_id JOIN pieces p ON p.id=s.piece_id"
        " ORDER BY n.performance_id"
    ),
    "pairs": (
        "SELECT JSON_OBJECT('id', pr.sector_id, 'piece_title_en', p.title_en,"
        " 'sector_en', s.name_en, 'title', pr.title, 'note', pr.note)"
        " FROM sector_featured_pairs pr JOIN performance_sectors s ON s.id=pr.sector_id"
        " JOIN pieces p ON p.id=s.piece_id ORDER BY pr.sector_id"
    ),
    "screen_titles": (
        "SELECT JSON_OBJECT('id', id, 'kind', kind, 'title_ko', title_ko,"
        " 'title_original', title_original, 'release_year', release_year,"
        " 'country', country_code) FROM screen_titles ORDER BY id"
    ),
    "screen_cues": (
        "SELECT JSON_OBJECT('id', c.id, 'title_original', t.title_original,"
        " 'title_ko', t.title_ko, 'work_title', c.work_title, 'part_label', c.part_label,"
        " 'scene_note', c.scene_note) FROM screen_music_cues c"
        " JOIN screen_titles t ON t.id=c.screen_title_id ORDER BY c.id"
    ),
}


def run(password: str, sql: str) -> list[dict[str, Any]]:
    command = [
        "docker", "exec", "-i", "-e", f"MYSQL_PWD={password}", "cm-dev-mysql",
        "mysql", "-uroot", "--default-character-set=utf8mb4", "-B", "-N", "-r",
        "classicmap_combined", "-e", sql,
    ]  # fmt: skip
    result = subprocess.run(command, capture_output=True, text=True, check=True)
    return [json.loads(line) for line in result.stdout.splitlines() if line.strip()]


def main() -> None:
    password_file, out_dir, *only = sys.argv[1:]
    with open(password_file, encoding="utf-8") as handle:
        password = handle.read().strip()
    os.makedirs(out_dir, exist_ok=True)
    for name, sql in QUERIES.items():
        if only and name not in only:
            continue
        rows = run(password, sql)
        with open(os.path.join(out_dir, f"{name}.jsonl"), "w", encoding="utf-8") as handle:
            for row in rows:
                handle.write(json.dumps(row, ensure_ascii=False) + "\n")
        print(name, len(rows))


if __name__ == "__main__":
    main()
