from __future__ import annotations

from collections.abc import Sequence

from classicmap_seed.sources.pagination import SourcePage
from classicmap_seed.sources.wikidata import WikidataConnector
from classicmap_seed.sources.wikidata_exact_input import WikidataEntityRequest


def fetch_exact_request_page(
    connector: WikidataConnector,
    requests: Sequence[WikidataEntityRequest],
    *,
    page_size: int,
    cursor: str | None,
) -> SourcePage:
    if not 1 <= page_size <= 50:
        raise ValueError("Wikidata exact page_size는 1~50이어야 합니다.")
    offset = _parse_cursor(cursor, len(requests))
    selected = requests[offset : offset + page_size]
    if not selected:
        return SourcePage(records=(), next_cursor=None, complete=True)
    records = connector.fetch_exact(selected)
    if len(records) != len(selected):
        raise ValueError("Wikidata exact 응답 건수가 요청 건수와 다릅니다.")
    next_offset = offset + len(selected)
    complete = next_offset >= len(requests)
    return SourcePage(
        records=records,
        next_cursor=None if complete else str(next_offset),
        complete=complete,
    )


def _parse_cursor(cursor: str | None, request_count: int) -> int:
    if cursor is None:
        return 0
    if (
        not cursor.isascii()
        or not cursor.isdecimal()
        or (len(cursor) > 1 and cursor.startswith("0"))
    ):
        raise ValueError("Wikidata exact cursor는 정규 10진수 offset이어야 합니다.")
    offset = int(cursor)
    if offset < 0 or offset > request_count:
        raise ValueError("Wikidata exact cursor가 입력 범위를 벗어났습니다.")
    return offset
