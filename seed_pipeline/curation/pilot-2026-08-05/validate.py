from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter, defaultdict
from pathlib import Path
from typing import Any, TextIO

YOUTUBE_ID_PATTERN = re.compile(r"^[A-Za-z0-9_-]{11}$")
CANDIDATE_KEY_PATTERN = re.compile(
    r"^yt:(?P<video_id>[A-Za-z0-9_-]{11}):(?P<start>\d+):(?P<end>\d+)$"
)
FORBIDDEN_DATABASE_ID_KEYS = {
    "artistId",
    "composerId",
    "performanceId",
    "pieceId",
    "sectorId",
}
SELF_HOSTED_RIGHTS_MODES = {
    "licensed_self_hosted",
    "permission_granted",
    "public_domain",
}


class ValidationError(ValueError):
    pass


def read_jsonl(path: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    with path.open(encoding="utf-8") as source:
        for line_number, raw_line in enumerate(source, start=1):
            if not raw_line.strip():
                continue
            try:
                value = json.loads(raw_line)
            except json.JSONDecodeError as error:
                raise ValidationError(
                    f"{path}:{line_number}: JSON을 해석할 수 없습니다: {error}"
                ) from error
            if not isinstance(value, dict):
                raise ValidationError(f"{path}:{line_number}: JSON 객체가 필요합니다.")
            rows.append(value)
    return rows


def walk_keys(value: Any) -> set[str]:
    keys: set[str] = set()
    if isinstance(value, dict):
        for key, child in value.items():
            keys.add(key)
            keys.update(walk_keys(child))
    elif isinstance(value, list):
        for child in value:
            keys.update(walk_keys(child))
    return keys


def require_string(value: Any, field: str) -> str:
    if not isinstance(value, str) or not value.strip():
        raise ValidationError(f"{field}에는 비어 있지 않은 문자열이 필요합니다.")
    return value


def validate_candidates(rows: list[dict[str, Any]]) -> None:
    if not rows:
        raise ValidationError("후보 데이터가 비어 있습니다.")

    candidate_keys: set[str] = set()
    video_ids: set[str] = set()
    approved_by_work: Counter[str] = Counter()
    sectors_by_work: dict[str, set[tuple[str, str, str]]] = defaultdict(set)

    for index, row in enumerate(rows, start=1):
        prefix = f"candidates.jsonl:{index}"
        forbidden = walk_keys(row).intersection(FORBIDDEN_DATABASE_ID_KEYS)
        if forbidden:
            joined = ", ".join(sorted(forbidden))
            raise ValidationError(f"{prefix}: 데이터베이스 ID 필드가 있습니다: {joined}")

        candidate_key = require_string(row.get("candidateKey"), f"{prefix}.candidateKey")
        match = CANDIDATE_KEY_PATTERN.fullmatch(candidate_key)
        if match is None:
            raise ValidationError(f"{prefix}: candidateKey 형식이 올바르지 않습니다.")
        if candidate_key in candidate_keys:
            raise ValidationError(f"{prefix}: candidateKey가 중복되었습니다: {candidate_key}")
        candidate_keys.add(candidate_key)

        source = row.get("source")
        if not isinstance(source, dict):
            raise ValidationError(f"{prefix}.source에는 객체가 필요합니다.")
        video_id = require_string(source.get("videoId"), f"{prefix}.source.videoId")
        if not YOUTUBE_ID_PATTERN.fullmatch(video_id):
            raise ValidationError(f"{prefix}: YouTube videoId 형식이 올바르지 않습니다.")
        if video_id in video_ids:
            raise ValidationError(f"{prefix}: videoId가 중복되었습니다: {video_id}")
        video_ids.add(video_id)
        if video_id != match.group("video_id"):
            raise ValidationError(f"{prefix}: candidateKey와 source.videoId가 다릅니다.")
        expected_url = f"https://www.youtube.com/watch?v={video_id}"
        if source.get("originalUrl") != expected_url:
            raise ValidationError(f"{prefix}: originalUrl이 정규 YouTube URL과 다릅니다.")
        if source.get("availabilityStatus") != "AVAILABLE":
            raise ValidationError(f"{prefix}: 공개 가용성이 확인되지 않았습니다.")

        clip = row.get("clip")
        if not isinstance(clip, dict):
            raise ValidationError(f"{prefix}.clip에는 객체가 필요합니다.")
        start = clip.get("startSeconds")
        end = clip.get("endSeconds")
        duration = source.get("durationSeconds")
        if not isinstance(start, int) or not isinstance(end, int):
            raise ValidationError(f"{prefix}: 시작·끝 초는 정수여야 합니다.")
        if not isinstance(duration, int) or duration <= 0:
            raise ValidationError(f"{prefix}: 영상 길이는 양의 정수여야 합니다.")
        if start < 0 or end <= start or end - start > 600 or end > duration:
            raise ValidationError(f"{prefix}: 클립 구간이 영상 길이 또는 600초 제한을 벗어납니다.")
        if start != int(match.group("start")) or end != int(match.group("end")):
            raise ValidationError(f"{prefix}: candidateKey와 클립 구간이 다릅니다.")

        credits = row.get("credits")
        if not isinstance(credits, list) or not credits:
            raise ValidationError(f"{prefix}: 크레딧이 필요합니다.")
        primary_count = sum(
            1 for credit in credits if isinstance(credit, dict) and credit.get("isPrimary") is True
        )
        if primary_count != 1:
            raise ValidationError(f"{prefix}: primary 크레딧은 정확히 하나여야 합니다.")

        work = row.get("workCandidate")
        sector = row.get("sectorCandidate")
        if not isinstance(work, dict) or not isinstance(sector, dict):
            raise ValidationError(f"{prefix}: 작품과 섹터 후보가 필요합니다.")
        work_key = require_string(work.get("naturalKey"), f"{prefix}.workCandidate.naturalKey")
        sector_key = require_string(sector.get("sectorKey"), f"{prefix}.sectorCandidate.sectorKey")
        start_cue = require_string(sector.get("startCue"), f"{prefix}.sectorCandidate.startCue")
        end_cue = require_string(sector.get("endCue"), f"{prefix}.sectorCandidate.endCue")
        sectors_by_work[work_key].add((sector_key, start_cue, end_cue))

        if row.get("candidateStatus") == "APPROVED":
            approved_by_work[work_key] += 1

    if len(approved_by_work) != 5:
        raise ValidationError(f"승인 작품은 정확히 5개여야 합니다: {dict(approved_by_work)}")
    invalid_counts = {key: count for key, count in approved_by_work.items() if count != 3}
    if invalid_counts:
        raise ValidationError(f"승인 작품마다 세 연주가 필요합니다: {invalid_counts}")
    inconsistent = [key for key, sectors in sectors_by_work.items() if len(sectors) != 1]
    if inconsistent:
        raise ValidationError(f"같은 작품의 섹터 큐가 일치하지 않습니다: {inconsistent}")


def validate_prewarm_template(
    candidates: list[dict[str, Any]], templates: list[dict[str, Any]]
) -> None:
    approved = {
        row["candidateKey"]: row for row in candidates if row.get("candidateStatus") == "APPROVED"
    }
    template_by_key: dict[str, dict[str, Any]] = {}
    for index, row in enumerate(templates, start=1):
        prefix = f"prewarm-template.jsonl:{index}"
        if "performanceId" in row:
            raise ValidationError(f"{prefix}: 적재 전 performanceId를 포함할 수 없습니다.")
        key = require_string(row.get("candidateKey"), f"{prefix}.candidateKey")
        if key in template_by_key:
            raise ValidationError(f"{prefix}: candidateKey가 중복되었습니다: {key}")
        template_by_key[key] = row

    if set(template_by_key) != set(approved):
        missing = sorted(set(approved) - set(template_by_key))
        extra = sorted(set(template_by_key) - set(approved))
        raise ValidationError(f"prewarm 템플릿 불일치: missing={missing}, extra={extra}")

    for key, template in template_by_key.items():
        candidate = approved[key]
        source = candidate["source"]
        clip = candidate["clip"]
        expected = {
            "videoId": source["videoId"],
            "start": clip["startSeconds"],
            "end": clip["endSeconds"],
        }
        actual = {field: template.get(field) for field in expected}
        if actual != expected:
            raise ValidationError(f"{key}: prewarm 구간이 후보 데이터와 다릅니다.")
        rights_mode = source.get("rightsMode")
        if rights_mode not in SELF_HOSTED_RIGHTS_MODES:
            if template.get("rightsCheckStatus") != "REVIEW_REQUIRED":
                raise ValidationError(f"{key}: 권리 검토 상태를 임의로 승인할 수 없습니다.")
            continue
        rights_reviewed_at = require_string(
            source.get("rightsReviewedAt"), f"{key}.source.rightsReviewedAt"
        )
        rights_evidence = require_string(
            source.get("rightsEvidence"), f"{key}.source.rightsEvidence"
        )
        if template.get("rightsCheckStatus") != "RIGHTS_VERIFIED":
            raise ValidationError(f"{key}: 자체 호스팅 권리 검토 완료 상태가 필요합니다.")
        if template.get("rightsMode") != rights_mode:
            raise ValidationError(f"{key}: 후보와 템플릿의 rightsMode가 다릅니다.")
        if template.get("rightsReviewedAt") != rights_reviewed_at:
            raise ValidationError(f"{key}: 후보와 템플릿의 rightsReviewedAt이 다릅니다.")
        if template.get("rightsEvidence") != rights_evidence:
            raise ValidationError(f"{key}: 후보와 템플릿의 rightsEvidence가 다릅니다.")


def render_prewarm(
    candidates: list[dict[str, Any]],
    templates: list[dict[str, Any]],
    id_rows: list[dict[str, Any]],
    output: TextIO,
) -> None:
    validate_candidates(candidates)
    validate_prewarm_template(candidates, templates)
    candidates_by_key = {row["candidateKey"]: row for row in candidates}
    id_map: dict[str, int] = {}
    for index, row in enumerate(id_rows, start=1):
        key = require_string(row.get("candidateKey"), f"id-map:{index}.candidateKey")
        performance_id = row.get("performanceId")
        if not isinstance(performance_id, int) or performance_id <= 0:
            raise ValidationError(f"id-map:{index}: performanceId는 양의 정수여야 합니다.")
        if key in id_map:
            raise ValidationError(f"id-map:{index}: candidateKey가 중복되었습니다: {key}")
        id_map[key] = performance_id

    template_keys = {row["candidateKey"] for row in templates}
    if set(id_map) != template_keys:
        missing = sorted(template_keys - set(id_map))
        extra = sorted(set(id_map) - template_keys)
        raise ValidationError(f"ID 매핑 불일치: missing={missing}, extra={extra}")

    for template in templates:
        key = template["candidateKey"]
        if template.get("rightsCheckStatus") != "RIGHTS_VERIFIED":
            raise ValidationError(f"{key}: 권리 검토 전에는 prewarm manifest를 만들 수 없습니다.")
        source = candidates_by_key[key]["source"]
        rendered = {
            "performanceId": id_map[key],
            "videoId": template["videoId"],
            "start": template["start"],
            "end": template["end"],
            "candidateStatus": "APPROVED",
            "rightsMode": source["rightsMode"],
            "rightsReviewedAt": source["rightsReviewedAt"],
            "rightsEvidence": source["rightsEvidence"],
        }
        output.write(json.dumps(rendered, ensure_ascii=False, separators=(",", ":")) + "\n")


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="비교 영상 파일럿 JSONL을 검증합니다.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    validate_parser = subparsers.add_parser("validate")
    validate_parser.add_argument("--candidates", type=Path, required=True)
    validate_parser.add_argument("--prewarm-template", type=Path, required=True)

    render_parser = subparsers.add_parser("render-prewarm")
    render_parser.add_argument("--candidates", type=Path, required=True)
    render_parser.add_argument("--prewarm-template", type=Path, required=True)
    render_parser.add_argument("--id-map", type=Path, required=True)
    return parser


def main() -> int:
    args = build_parser().parse_args()
    try:
        if args.command == "validate":
            candidates = read_jsonl(args.candidates)
            templates = read_jsonl(args.prewarm_template)
            validate_candidates(candidates)
            validate_prewarm_template(candidates, templates)
            print(f"검증 완료: 후보 {len(candidates)}개, prewarm 템플릿 {len(templates)}개")
        else:
            candidates = read_jsonl(args.candidates)
            templates = read_jsonl(args.prewarm_template)
            id_rows = read_jsonl(args.id_map)
            render_prewarm(candidates, templates, id_rows, sys.stdout)
    except ValidationError as error:
        print(f"검증 실패: {error}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
