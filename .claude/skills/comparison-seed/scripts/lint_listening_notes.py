#!/usr/bin/env python3
"""듣기 노트(notes.jsonl) 문체 검사.

    python3 .claude/skills/comparison-seed/scripts/lint_listening_notes.py \
        seed_pipeline/curation/<RUN>/notes.jsonl

규칙은 references/08-listening-notes.md 의 "문체" 에 있다. 문제가 있으면 1 로 끝난다.
잰 값과 맞는지(하이라이트 시각, "셋 중 가장 ○○")는 이 검사가 보지 못하므로 따로 대조한다.
"""
import json
import re
import sys
from collections import Counter

BANNED = [
    # 곡선을 옮긴 상투어
    '부풀', '차오르', '차올라', '잦아들', '잦아드', '내려앉', '물결', '머물', '무렵', '남짓',
    # 권유
    '보세요', '귀 기울', '번갈아 들',
    # 분석 말투
    'dB', '%', '곡선', '클립', '녹음', '최고점', '정점',
    # 과장·우열·감정 강요
    '완벽', '압도', '교과서', '거장', '전설', '신들린', '악마', '최고의', '눈물', '전율', '영혼', '마법',
]
LABELS = {
    '절정', '첫 절정', '두 번째 절정', '세 번째 절정', '마지막 절정',
    '커지기 시작', '다시 커지기 시작', '가장 여린 곳', '거의 최대', '여려지기 시작', '물러서는 곳', '첫 소리',
    # 악보 이정표. 그 시점이 잰 값과 맞을 때만 쓴다(놀람 화음 = 가장 센 곳)
    '서주', '놀람 화음',
}
TIME = re.compile(r'\d+:\d\d')
NOTE_MAX = 75
PAIR_NOTE_MAX = 90
GUIDE_MAX = 230
HEADLINE_MAX = 16
PAIR_TITLE_MAX = 30
# 직접 듣고 쓴 줄은 하이라이트 이름을 그대로 둔다
LISTENED = {'kind': 'listening', 'status': 'done'}


def text_issues(where, text, limit):
    found = [f'{where}: 금지어 "{word}"' for word in BANNED if word in text]
    if TIME.search(text):
        found.append(f'{where}: 본문에 시각')
    if len(text) > limit:
        found.append(f'{where}: {len(text)}자 > {limit}')
    return found


def check(rows):
    issues = []
    headlines = Counter()
    by_sector = {}
    for line, row in rows:
        by_sector.setdefault((row['pieceId'], row['sectorKey']), []).append((line, row))
    for sector, items in by_sector.items():
        kinds = Counter(row['kind'] for _, row in items)
        if kinds['sector'] > 1 or kinds['pair'] > 1:
            issues.append(f'{sector}: 구간 안내·추천 비교가 둘 이상')
        local = Counter(row['headline'] for _, row in items if row['kind'] == 'performance')
        issues += [f'{sector}: 같은 제목 "{h}"' for h, n in local.items() if n > 1]
        for line, row in items:
            where = f'{line}행 {row["kind"]} {sector[0]}:{sector[1]}'
            listened = LISTENED in row.get('evidence', [])
            if row['kind'] == 'sector':
                text = row['description']
                issues += text_issues(where, text, GUIDE_MAX)
                if text.count('**') not in (0, 2):
                    issues.append(f'{where}: 강조는 한 군데까지')
            elif row['kind'] == 'performance':
                headlines[row['headline']] += 1
                if len(row['headline']) > HEADLINE_MAX:
                    issues.append(f'{where}: 제목 {len(row["headline"])}자 > {HEADLINE_MAX}')
                if row['headline'].endswith('기'):
                    issues.append(f'{where}: 제목이 "~기" 로 끝남')
                issues += text_issues(where + ' 제목', row['headline'], 999)
                issues += text_issues(where, row['note'], NOTE_MAX)
                if not listened:
                    issues += label_issues(where, row.get('moments', []))
            elif row['kind'] == 'pair':
                if ' vs ' in row['title'] or len(row['title']) > PAIR_TITLE_MAX:
                    issues.append(f'{where}: 추천 비교 제목에 "vs" 또는 {PAIR_TITLE_MAX}자 초과')
                issues += text_issues(where + ' 제목', row['title'], 999)
                issues += text_issues(where, row['note'], PAIR_NOTE_MAX)
                if not listened:
                    issues += label_issues(where, row.get('moments', []))
    total = sum(headlines.values())
    for headline, n in headlines.items():
        if n > 2:
            issues.append(f'제목 "{headline}" 을 {n}번 씀(두 번까지)')
    return issues, total


def label_issues(where, moments):
    found = [f'{where}: 하이라이트 이름 "{m["label"]}" 은 목록에 없음' for m in moments if m['label'] not in LABELS]
    if len(moments) > 2:
        found.append(f'{where}: 하이라이트가 셋 이상')
    return found


def main(paths):
    rows = []
    for path in paths:
        with open(path, encoding='utf-8') as handle:
            rows += [(i, json.loads(line)) for i, line in enumerate(handle, 1) if line.strip()]
    issues, notes = check(rows)
    for issue in issues:
        print(issue)
    print(f'{len(rows)}줄(연주 노트 {notes}), 문제 {len(issues)}개')
    return 1 if issues else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
