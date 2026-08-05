from __future__ import annotations

import re
from pathlib import Path

from pydantic import TypeAdapter, ValidationError, field_validator

from classicmap_seed.models import JsonValue, StrictModel, WikidataScope
from classicmap_seed.sources.base import optional_string, require_list, require_object

_JSON_VALUE_ADAPTER: TypeAdapter[JsonValue] = TypeAdapter(JsonValue)
_QID_PATTERN = re.compile(r"^Q[1-9][0-9]*$")


def is_wikidata_qid(value: str) -> bool:
    return _QID_PATTERN.fullmatch(value) is not None


class WikidataEntityRequest(StrictModel):
    qid: str
    scope: WikidataScope

    @field_validator("qid")
    @classmethod
    def validate_qid(cls, value: str) -> str:
        if not is_wikidata_qid(value):
            raise ValueError("qid는 Q1 이상의 정규 Wikidata QID여야 합니다.")
        return value


def read_wikidata_entity_requests(path: Path) -> tuple[WikidataEntityRequest, ...]:
    requests: list[WikidataEntityRequest] = []
    seen_qids: set[str] = set()
    for line_number, raw_line in enumerate(path.read_bytes().splitlines(), start=1):
        if not raw_line.strip():
            raise ValueError(f"{path}:{line_number}: 빈 JSONL 행은 허용하지 않습니다.")
        try:
            request = WikidataEntityRequest.model_validate_json(raw_line)
        except ValidationError as error:
            raise ValueError(f"{path}:{line_number}: 입력 계약 오류: {error}") from error
        if request.qid in seen_qids:
            raise ValueError(f"{path}:{line_number}: 중복 QID입니다: {request.qid}")
        seen_qids.add(request.qid)
        requests.append(request)
    if not requests:
        raise ValueError(f"{path}: exact QID 입력이 비어 있습니다.")
    return tuple(sorted(requests, key=lambda request: request.qid))


def extract_comparison_candidate_requests(path: Path) -> tuple[WikidataEntityRequest, ...]:
    scopes_by_qid: dict[str, WikidataScope] = {}
    for line_number, raw_line in enumerate(path.read_bytes().splitlines(), start=1):
        if not raw_line.strip():
            raise ValueError(f"{path}:{line_number}: 빈 JSONL 행은 허용하지 않습니다.")
        try:
            row = require_object(
                _JSON_VALUE_ADAPTER.validate_json(raw_line),
                field=f"candidate[{line_number}]",
            )
        except (ValidationError, ValueError) as error:
            raise ValueError(f"{path}:{line_number}: 후보 JSON 오류: {error}") from error

        work = require_object(row.get("workCandidate"), field="workCandidate")
        composer = require_object(work.get("composer"), field="workCandidate.composer")
        _collect_wikidata_ids(
            composer.get("externalIdentifiers"),
            WikidataScope.COMPOSERS,
            scopes_by_qid,
            field="workCandidate.composer.externalIdentifiers",
        )
        credits = require_list(row.get("credits"), field="credits")
        for credit_index, credit_value in enumerate(credits):
            credit = require_object(credit_value, field=f"credits[{credit_index}]")
            entity = require_object(
                credit.get("entityCandidate"),
                field=f"credits[{credit_index}].entityCandidate",
            )
            _collect_wikidata_ids(
                entity.get("externalIdentifiers"),
                WikidataScope.PERFORMERS,
                scopes_by_qid,
                field=f"credits[{credit_index}].entityCandidate.externalIdentifiers",
            )
    if not scopes_by_qid:
        raise ValueError(f"{path}: 비교 후보에서 Wikidata QID를 찾지 못했습니다.")
    return tuple(
        WikidataEntityRequest(qid=qid, scope=scopes_by_qid[qid]) for qid in sorted(scopes_by_qid)
    )


def _collect_wikidata_ids(
    value: JsonValue,
    scope: WikidataScope,
    scopes_by_qid: dict[str, WikidataScope],
    *,
    field: str,
) -> None:
    identifiers = require_list(value, field=field)
    matched = False
    for index, identifier_value in enumerate(identifiers):
        identifier = require_object(identifier_value, field=f"{field}[{index}]")
        namespace = optional_string(identifier.get("namespace"))
        if namespace != "wikidata":
            continue
        matched = True
        qid = optional_string(identifier.get("value"))
        if qid is None or not is_wikidata_qid(qid):
            raise ValueError(f"{field}[{index}].value가 정규 Wikidata QID가 아닙니다.")
        previous_scope = scopes_by_qid.get(qid)
        if previous_scope is not None and previous_scope is not scope:
            raise ValueError(
                f"동일 QID에 서로 다른 scope를 자동 지정할 수 없습니다: {qid} "
                f"({previous_scope.value}, {scope.value})"
            )
        scopes_by_qid[qid] = scope
    if not matched:
        raise ValueError(f"{field}에 Wikidata 식별자가 정확히 필요합니다.")
