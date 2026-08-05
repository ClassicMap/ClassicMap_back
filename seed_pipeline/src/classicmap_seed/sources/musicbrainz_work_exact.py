from __future__ import annotations

from collections.abc import Sequence

from classicmap_seed.sources.musicbrainz_work_exact_input import (
    MusicBrainzWorkEntityRequest,
)
from classicmap_seed.sources.musicbrainz_works import MusicBrainzWorkConnector
from classicmap_seed.sources.pagination import SourcePage


def fetch_exact_work_request_page(
    connector: MusicBrainzWorkConnector,
    requests: Sequence[MusicBrainzWorkEntityRequest],
    *,
    page_size: int,
    cursor: str | None,
) -> SourcePage:
    if page_size != 1:
        raise ValueError("MusicBrainz exact work page_size는 1이어야 합니다.")
    offset = _parse_cursor(cursor, len(requests))
    if offset == len(requests):
        return SourcePage(records=(), next_cursor=None, complete=True)

    record = connector.fetch_exact(work_mbid=requests[offset].mbid)
    next_offset = offset + 1
    complete = next_offset >= len(requests)
    return SourcePage(
        records=(record,),
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
        raise ValueError("MusicBrainz exact work cursor는 정규 10진수 offset이어야 합니다.")
    offset = int(cursor)
    if offset < 0 or offset > request_count:
        raise ValueError("MusicBrainz exact work cursor가 입력 범위를 벗어났습니다.")
    return offset
