from __future__ import annotations

from pathlib import Path
from uuid import UUID

from pydantic import TypeAdapter, ValidationError, field_validator

from classicmap_seed.models import JsonValue, StrictModel
from classicmap_seed.sources.base import optional_string, require_list, require_object

_JSON_VALUE_ADAPTER: TypeAdapter[JsonValue] = TypeAdapter(JsonValue)
_NATURAL_KEY_PREFIX = "musicbrainz-work:"


def is_musicbrainz_work_mbid(value: str) -> bool:
    try:
        parsed = UUID(value)
    except ValueError:
        return False
    return str(parsed) == value


class MusicBrainzWorkEntityRequest(StrictModel):
    mbid: str

    @field_validator("mbid")
    @classmethod
    def validate_mbid(cls, value: str) -> str:
        if not is_musicbrainz_work_mbid(value):
            raise ValueError("mbid는 소문자 canonical UUID여야 합니다.")
        return value


def read_musicbrainz_work_entity_requests(
    path: Path,
) -> tuple[MusicBrainzWorkEntityRequest, ...]:
    requests: list[MusicBrainzWorkEntityRequest] = []
    seen_mbids: set[str] = set()
    for line_number, raw_line in enumerate(path.read_bytes().splitlines(), start=1):
        if not raw_line.strip():
            raise ValueError(f"{path}:{line_number}: 빈 JSONL 행은 허용하지 않습니다.")
        try:
            request = MusicBrainzWorkEntityRequest.model_validate_json(raw_line)
        except ValidationError as error:
            raise ValueError(f"{path}:{line_number}: 입력 계약 오류: {error}") from error
        if request.mbid in seen_mbids:
            raise ValueError(f"{path}:{line_number}: 중복 work MBID입니다: {request.mbid}")
        seen_mbids.add(request.mbid)
        requests.append(request)
    if not requests:
        raise ValueError(f"{path}: exact work MBID 입력이 비어 있습니다.")
    return tuple(sorted(requests, key=lambda request: request.mbid))


def extract_comparison_candidate_work_requests(
    path: Path,
) -> tuple[MusicBrainzWorkEntityRequest, ...]:
    mbids: set[str] = set()
    for line_number, raw_line in enumerate(path.read_bytes().splitlines(), start=1):
        if not raw_line.strip():
            raise ValueError(f"{path}:{line_number}: 빈 JSONL 행은 허용하지 않습니다.")
        try:
            row = require_object(
                _JSON_VALUE_ADAPTER.validate_json(raw_line),
                field=f"candidate[{line_number}]",
            )
            work = require_object(row.get("workCandidate"), field="workCandidate")
        except (ValidationError, ValueError) as error:
            raise ValueError(f"{path}:{line_number}: 후보 JSON 오류: {error}") from error

        natural_key = optional_string(work.get("naturalKey"))
        if natural_key is None or not natural_key.startswith(_NATURAL_KEY_PREFIX):
            raise ValueError(
                f"{path}:{line_number}: workCandidate.naturalKey는 "
                f"{_NATURAL_KEY_PREFIX}<mbid> 형식이어야 합니다."
            )
        mbid = natural_key.removeprefix(_NATURAL_KEY_PREFIX)
        if not is_musicbrainz_work_mbid(mbid):
            raise ValueError(
                f"{path}:{line_number}: naturalKey의 work MBID가 canonical UUID가 아닙니다."
            )
        _require_matching_external_identifier(
            work.get("externalIdentifiers"),
            expected_mbid=mbid,
            field="workCandidate.externalIdentifiers",
        )
        mbids.add(mbid)
    if not mbids:
        raise ValueError(f"{path}: 비교 후보에서 MusicBrainz work MBID를 찾지 못했습니다.")
    return tuple(MusicBrainzWorkEntityRequest(mbid=mbid) for mbid in sorted(mbids))


def _require_matching_external_identifier(
    value: JsonValue,
    *,
    expected_mbid: str,
    field: str,
) -> None:
    identifiers = require_list(value, field=field)
    matched_values: list[str] = []
    for index, identifier_value in enumerate(identifiers):
        identifier = require_object(identifier_value, field=f"{field}[{index}]")
        if optional_string(identifier.get("namespace")) != "musicbrainz_work":
            continue
        identifier_mbid = optional_string(identifier.get("value"))
        if identifier_mbid is None or not is_musicbrainz_work_mbid(identifier_mbid):
            raise ValueError(f"{field}[{index}].value가 canonical UUID가 아닙니다.")
        matched_values.append(identifier_mbid)
    if matched_values != [expected_mbid]:
        raise ValueError(
            f"{field}에는 naturalKey와 같은 musicbrainz_work 식별자가 정확히 하나 필요합니다."
        )
