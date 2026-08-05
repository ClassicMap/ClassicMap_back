from __future__ import annotations

from datetime import UTC, datetime
from math import ceil
from pathlib import Path
from typing import Annotated

import typer

from classicmap_seed import __version__
from classicmap_seed.artifacts import (
    JsonlArtifactStore,
    read_artifact,
    read_manifest,
    serialize_jsonl,
    sha256_bytes,
)
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    CommandReport,
    DiscoverySourceName,
    LoadTable,
    NormalizedEntityCandidate,
    ResolutionDecision,
    RunOptions,
    SnapshotManifest,
    SourceMetadata,
    SourceName,
    SourceRecord,
    ValidationReport,
    WikidataScope,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.reporting import render_report, write_report
from classicmap_seed.resolve import resolve_candidates
from classicmap_seed.sources import (
    MusicBrainzWorkConnector,
    WikidataConnector,
    build_connector,
    build_musicbrainz_work_connector,
    collect_exact_work_hierarchy,
    fetch_exact_request_page,
    read_musicbrainz_work_entity_requests,
    read_wikidata_entity_requests,
)
from classicmap_seed.sources.collector import collect_paginated
from classicmap_seed.sources.musicbrainz_work_input import (
    merge_duplicate_work_records,
    read_verified_musicbrainz_artist_ids,
)
from classicmap_seed.sources.pagination import SourcePage
from classicmap_seed.sources.wikidata_dump import (
    WikidataDumpCommandReport,
    collect_wikidata_dump,
    dump_retrieved_at,
    read_wikidata_dump_release_metadata,
    verify_wikidata_dump_input,
    wikidata_dump_metadata,
)
from classicmap_seed.sources.work_composer_dependencies import (
    WorkComposerDependencyCommandReport,
    WorkComposerDependencyConnector,
    collect_work_composer_dependencies,
    read_work_composer_dependency_plan,
)
from classicmap_seed.streaming import (
    StreamingPlatform,
    build_streaming_load_bundle,
    read_streaming_candidates,
    streaming_source_metadata,
)
from classicmap_seed.validate import validate_canonical_bundle

app = typer.Typer(
    name="classicmap-seed",
    help="ClassicMap 국제 초기 시드 artifact 파이프라인",
    no_args_is_help=True,
)

RunIdOption = Annotated[str, typer.Option("--run-id", help="재현 가능한 시드 실행 ID")]
DryRunOption = Annotated[
    bool,
    typer.Option("--dry-run/--write", help="파일 쓰기 없이 예상 mutation만 계산"),
]
ResumeOption = Annotated[
    bool,
    typer.Option("--resume/--no-resume", help="동일 content-addressed artifact 재사용"),
]
LimitOption = Annotated[
    int,
    typer.Option("--limit", min=1, max=100_000, help="이번 명령에서 처리할 최대 행 수"),
]
JsonReportOption = Annotated[
    Path | None,
    typer.Option("--json-report", help="명령 결과 JSON 경로. dry-run에서는 쓰지 않음"),
]
ArtifactsDirOption = Annotated[
    Path,
    typer.Option("--artifacts-dir", help="immutable artifact 루트"),
]
MaxPagesOption = Annotated[
    int | None,
    typer.Option("--max-pages", min=1, help="이번 실행에서 요청할 최대 page 수"),
]


@app.command("snapshot-wikidata-dump")
def snapshot_wikidata_dump(
    run_id: RunIdOption,
    input_path: Annotated[
        Path,
        typer.Option("--input", exists=True, dir_okay=False, readable=True),
    ],
    release_metadata_path: Annotated[
        Path,
        typer.Option(
            "--release-metadata",
            exists=True,
            dir_okay=False,
            readable=True,
            help="공식 날짜·URL·SHA-256·파일크기 sidecar JSON",
        ),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    start_ordinal: Annotated[
        int,
        typer.Option("--start-ordinal", min=0, help="0-based entity ordinal, inclusive"),
    ] = 0,
    end_ordinal: Annotated[
        int | None,
        typer.Option("--end-ordinal", min=1, help="0-based entity ordinal, exclusive"),
    ] = None,
    checkpoint_every: Annotated[
        int,
        typer.Option(
            "--checkpoint-every",
            min=1,
            max=1_000_000,
            help="검사 entity 수 기준 checkpoint 간격",
        ),
    ] = 10_000,
) -> None:
    """공식 Wikidata JSON dump를 네트워크 없이 streaming snapshot으로 변환합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        release = read_wikidata_dump_release_metadata(release_metadata_path)
        provenance = verify_wikidata_dump_input(input_path, release)
        if end_ordinal is not None and end_ordinal <= start_ordinal:
            raise ValueError("--end-ordinal은 --start-ordinal보다 커야 합니다.")
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--release-metadata") from error

    partition_name = f"{start_ordinal}-{end_ordinal if end_ordinal is not None else 'end'}"
    checkpoint_path = (
        artifacts_dir / options.run_id / "checkpoints" / f"wikidata-dump-{partition_name}.json"
    )
    store = _store(artifacts_dir)
    metadata = wikidata_dump_metadata(provenance)
    retrieved_at = dump_retrieved_at(provenance)
    try:
        collection = collect_wikidata_dump(
            input_path=input_path,
            provenance=provenance,
            run_id=options.run_id,
            artifact_store=store,
            artifacts_root=artifacts_dir,
            checkpoint_path=checkpoint_path,
            start_ordinal=start_ordinal,
            end_ordinal=end_ordinal,
            limit=options.limit,
            checkpoint_every=checkpoint_every,
            dry_run=options.dry_run,
            resume=options.resume,
        )
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--input") from error

    snapshot_result = store.write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=metadata,
        records=collection.records,
        retrieved_at=retrieved_at,
        dry_run=options.dry_run,
        resume=options.resume,
        input_provenance=provenance,
    )
    review_result = None
    if collection.reviews:
        review_result = store.write(
            run_id=options.run_id,
            stage=ArtifactStage.RAW,
            metadata=metadata,
            records=collection.reviews,
            retrieved_at=retrieved_at,
            dry_run=options.dry_run,
            resume=options.resume,
            input_provenance=provenance,
        )
    aggregate_mutation_count = snapshot_result.mutation_count + (
        review_result.mutation_count if review_result is not None else 0
    )
    report = WikidataDumpCommandReport(
        run_id=options.run_id,
        dry_run=options.dry_run,
        input_sha256=provenance.sha256,
        input_size_bytes=provenance.size_bytes,
        dump_date=provenance.dump_date,
        source_url=provenance.source_url,
        partition_start_ordinal=start_ordinal,
        partition_end_ordinal=end_ordinal,
        next_ordinal=collection.next_ordinal,
        complete=collection.complete,
        scanned_entity_count=collection.scanned_entity_count,
        input_count=collection.scanned_entity_count,
        output_count=len(collection.records),
        review_count=len(collection.reviews),
        resumed_output_count=collection.resumed_record_count,
        resumed_review_count=collection.resumed_review_count,
        mutation_count=max(collection.artifact_mutation_count, aggregate_mutation_count),
        data_path=str(snapshot_result.data_path),
        manifest_path=str(snapshot_result.manifest_path),
        review_data_path=str(review_result.data_path) if review_result is not None else None,
        review_manifest_path=(
            str(review_result.manifest_path) if review_result is not None else None
        ),
        notes=(
            "입력 전체를 메모리에 올리지 않고 entity 1행과 limit 결과만 유지했습니다.",
            "P106/P31 및 dump 내부 P279 index만으로 scope를 판정했습니다.",
            "이름 기반 scope 판정과 네트워크/API 호출을 수행하지 않았습니다.",
            "unknown/ambiguous scope는 별도 review artifact로 분리했습니다.",
            "운영 DB와 홈서버에 연결하지 않았습니다.",
        ),
    )
    _emit(report, options)


@app.command()
def snapshot(
    run_id: RunIdOption,
    source: Annotated[DiscoverySourceName, typer.Option("--source", case_sensitive=False)],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    contact: Annotated[
        str | None,
        typer.Option(
            "--contact",
            help="MusicBrainz/Wikidata User-Agent 연락처. artifact에는 저장하지 않음",
        ),
    ] = None,
) -> None:
    """공식 API의 작은 후보 묶음을 raw immutable snapshot으로 저장합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        connector, http_client = build_connector(SourceName(source.value), contact=contact)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--contact") from error

    try:
        records = connector.fetch(limit=options.limit)
    finally:
        http_client.close()

    result = _store(artifacts_dir).write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=records,
        retrieved_at=datetime.now(UTC),
        dry_run=options.dry_run,
        resume=options.resume,
    )
    _emit(
        CommandReport(
            command="snapshot",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(records),
            output_count=len(records),
            mutation_count=result.mutation_count,
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=("운영 DB에 연결하지 않았습니다.",),
        ),
        options,
    )


@app.command("snapshot-wikidata")
def snapshot_wikidata(
    run_id: RunIdOption,
    scope: Annotated[WikidataScope, typer.Option("--scope", case_sensitive=False)],
    contact: Annotated[
        str,
        typer.Option("--contact", help="Wikidata User-Agent 연락처. artifact에는 저장하지 않음"),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    page_size: Annotated[
        int,
        typer.Option("--page-size", min=1, max=1_000, help="WDQS keyset page 크기"),
    ] = 100,
    max_pages: MaxPagesOption = None,
) -> None:
    """Wikidata 인물·단체 scope를 keyset pagination과 checkpoint로 수집합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        connector, http_client = build_connector(SourceName.WIKIDATA, contact=contact)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--contact") from error
    if not isinstance(connector, WikidataConnector):
        raise RuntimeError("Wikidata connector factory 결과가 올바르지 않습니다.")

    retrieved_at = datetime.now(UTC)
    store = _store(artifacts_dir)
    checkpoint_path = (
        artifacts_dir / options.run_id / "checkpoints" / f"wikidata-{scope.value}.json"
    )
    try:
        collection = collect_paginated(
            run_id=options.run_id,
            scope=scope.value,
            metadata=connector.metadata,
            fetch_page=lambda size, cursor: connector.fetch_page(
                scope=scope,
                page_size=size,
                cursor=cursor,
            ),
            artifact_store=store,
            artifacts_root=artifacts_dir,
            checkpoint_path=checkpoint_path,
            retrieved_at=retrieved_at,
            limit=options.limit,
            page_size=page_size,
            max_pages=max_pages,
            dry_run=options.dry_run,
            resume=options.resume,
        )
    except ValueError as error:
        raise typer.BadParameter(str(error)) from error
    finally:
        http_client.close()

    result = store.write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=collection.records,
        retrieved_at=retrieved_at,
        dry_run=options.dry_run,
        resume=options.resume,
    )
    estimated_pages = ceil(options.limit / page_size)
    minimum_http_requests = estimated_pages * (1 + ceil(page_size / 50))
    full_25k_minimum_requests = ceil(25_000 / page_size) * (1 + ceil(page_size / 50))
    _emit(
        CommandReport(
            command="snapshot-wikidata",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(collection.records),
            output_count=len(collection.records),
            mutation_count=max(result.mutation_count, collection.artifact_mutation_count),
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=(
                f"scope={scope.value}, 이번 실행 WDQS page {collection.request_count}개",
                f"limit 기준 HTTP 최소 요청 추정 {minimum_http_requests}회",
                f"25,000건 HTTP 최소 요청 추정 {full_25k_minimum_requests}회",
                "역할·악기·국가 linked entity batch 요청은 최소 추정에 포함되지 않습니다.",
                f"checkpoint 재사용 행 {collection.resumed_record_count}개",
                "WDQS 0.5 req/s 제한과 immutable page artifact를 적용했습니다.",
                "운영 DB에 연결하지 않았습니다.",
            ),
        ),
        options,
    )


@app.command("snapshot-wikidata-entities")
def snapshot_wikidata_entities(
    run_id: RunIdOption,
    input_path: Annotated[
        Path,
        typer.Option("--input", exists=True, dir_okay=False, readable=True),
    ],
    contact: Annotated[
        str,
        typer.Option("--contact", help="Wikidata User-Agent 연락처. artifact에는 저장하지 않음"),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    max_pages: MaxPagesOption = None,
) -> None:
    """명시된 Wikidata QID만 entity API batch와 checkpoint로 수집합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        requests = read_wikidata_entity_requests(input_path)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--input") from error
    try:
        connector, http_client = build_connector(SourceName.WIKIDATA, contact=contact)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--contact") from error
    if not isinstance(connector, WikidataConnector):
        raise RuntimeError("Wikidata connector factory 결과가 올바르지 않습니다.")

    input_sha256 = sha256_bytes(serialize_jsonl(requests))
    retrieved_at = datetime.now(UTC)
    store = _store(artifacts_dir)
    checkpoint_path = (
        artifacts_dir / options.run_id / "checkpoints" / f"wikidata-entities-{input_sha256}.json"
    )
    try:
        collection = collect_paginated(
            run_id=options.run_id,
            scope=f"exact:{input_sha256}",
            metadata=connector.entity_metadata,
            fetch_page=lambda size, cursor: fetch_exact_request_page(
                connector,
                requests,
                page_size=size,
                cursor=cursor,
            ),
            artifact_store=store,
            artifacts_root=artifacts_dir,
            checkpoint_path=checkpoint_path,
            retrieved_at=retrieved_at,
            limit=min(options.limit, len(requests)),
            page_size=50,
            max_pages=max_pages,
            dry_run=options.dry_run,
            resume=options.resume,
        )
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--input") from error
    finally:
        http_client.close()

    result = store.write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.entity_metadata,
        records=collection.records,
        retrieved_at=retrieved_at,
        dry_run=options.dry_run,
        resume=options.resume,
    )
    _emit(
        CommandReport(
            command="snapshot-wikidata-entities",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(requests),
            output_count=len(collection.records),
            mutation_count=max(result.mutation_count, collection.artifact_mutation_count),
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=(
                f"입력 manifest SHA-256 {input_sha256}",
                f"exact page 요청 {collection.request_count}회, "
                "WDQS scope 검증과 wbgetentities batch 최대 50건",
                f"checkpoint 재사용 행 {collection.resumed_record_count}개",
                "QID별 scope를 WDQS VALUES와 기존 scope predicate로 검증하고 "
                "불일치는 거부했습니다.",
                "역할·악기·국가 linked entity도 50건 단위로 보강했습니다.",
                "이름 검색, 전체 WDQS discovery, 운영 DB 연결을 수행하지 않았습니다.",
            ),
        ),
        options,
    )


@app.command("snapshot-musicbrainz-work-entities")
def snapshot_musicbrainz_work_entities(
    run_id: RunIdOption,
    input_path: Annotated[
        Path,
        typer.Option("--input", exists=True, dir_okay=False, readable=True),
    ],
    contact: Annotated[
        str,
        typer.Option("--contact", help="MusicBrainz User-Agent 연락처. artifact에는 저장하지 않음"),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    max_hierarchy_depth: Annotated[
        int,
        typer.Option(
            "--max-hierarchy-depth",
            min=0,
            max=32,
            help="parts parent 재귀 최대 깊이",
        ),
    ] = 8,
    max_hierarchy_records: Annotated[
        int,
        typer.Option(
            "--max-hierarchy-records",
            min=1,
            max=100_000,
            help="root와 parent를 합친 최대 work 수",
        ),
    ] = 1_000,
) -> None:
    """명시된 MusicBrainz work MBID만 단건 endpoint와 checkpoint로 수집합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        requests = read_musicbrainz_work_entity_requests(input_path)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--input") from error
    try:
        connector, http_client = build_musicbrainz_work_connector(contact=contact)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--contact") from error
    if not isinstance(connector, MusicBrainzWorkConnector):
        raise RuntimeError("MusicBrainz work connector factory 결과가 올바르지 않습니다.")

    input_sha256 = sha256_bytes(serialize_jsonl(requests))
    retrieved_at = datetime.now(UTC)
    store = _store(artifacts_dir)
    checkpoint_path = (
        artifacts_dir
        / options.run_id
        / "checkpoints"
        / f"musicbrainz-work-entities-{input_sha256}.json"
    )
    try:
        collection = collect_exact_work_hierarchy(
            connector=connector,
            requests=requests,
            input_sha256=input_sha256,
            run_id=options.run_id,
            metadata=connector.metadata,
            artifact_store=store,
            artifacts_root=artifacts_dir,
            checkpoint_path=checkpoint_path,
            retrieved_at=retrieved_at,
            root_limit=min(options.limit, len(requests)),
            max_depth=max_hierarchy_depth,
            max_records=max_hierarchy_records,
            dry_run=options.dry_run,
            resume=options.resume,
        )
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--input") from error
    finally:
        http_client.close()

    result = store.write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=collection.records,
        retrieved_at=retrieved_at,
        dry_run=options.dry_run,
        resume=options.resume,
    )
    _emit(
        CommandReport(
            command="snapshot-musicbrainz-work-entities",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(requests),
            output_count=len(collection.records),
            mutation_count=max(result.mutation_count, collection.artifact_mutation_count),
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=(
                f"입력 manifest SHA-256 {input_sha256}",
                f"exact work와 parts parent 요청 {collection.request_count}회, "
                "HTTP 요청당 MBID 1건",
                f"checkpoint 재사용 행 {collection.resumed_record_count}개",
                f"hierarchy 제한 depth={max_hierarchy_depth}, records={max_hierarchy_records}",
                "공식 /ws/2/work/<mbid> endpoint와 1 req/s 제한을 적용했습니다.",
                "이름 검색, 작곡가 전체 browse, 운영 DB 연결을 수행하지 않았습니다.",
            ),
        ),
        options,
    )


@app.command("snapshot-musicbrainz-works")
def snapshot_musicbrainz_works(
    run_id: RunIdOption,
    artist_manifest: Annotated[
        Path,
        typer.Option("--artist-manifest", exists=True, dir_okay=False, readable=True),
    ],
    contact: Annotated[
        str,
        typer.Option("--contact", help="MusicBrainz User-Agent 연락처. artifact에는 저장하지 않음"),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    page_size: Annotated[
        int,
        typer.Option("--page-size", min=1, max=100, help="MusicBrainz work browse page 크기"),
    ] = 100,
    max_pages: MaxPagesOption = None,
) -> None:
    """검증된 artist MBID별 MusicBrainz work를 offset pagination으로 수집합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        artist_ids = read_verified_musicbrainz_artist_ids(artist_manifest)
        connector, http_client = build_musicbrainz_work_connector(contact=contact)
    except ValueError as error:
        raise typer.BadParameter(str(error), param_hint="--artist-manifest") from error

    retrieved_at = datetime.now(UTC)
    store = _store(artifacts_dir)
    all_records: list[SourceRecord] = []
    artifact_mutation_count = 0
    requested_pages = 0
    resumed_records = 0
    try:
        for artist_id in artist_ids:
            remaining = options.limit - len(all_records)
            if remaining <= 0:
                break
            remaining_pages = None if max_pages is None else max_pages - requested_pages
            if remaining_pages is not None and remaining_pages <= 0:
                break
            checkpoint_path = (
                artifacts_dir
                / options.run_id
                / "checkpoints"
                / f"musicbrainz-works-{artist_id}.json"
            )
            current_artist_id = artist_id

            def fetch_work_page(
                size: int,
                cursor: str | None,
                artist_mbid: str = current_artist_id,
            ) -> SourcePage:
                return connector.fetch_page(
                    artist_mbid=artist_mbid,
                    offset=int(cursor) if cursor is not None else 0,
                    page_size=size,
                )

            collection = collect_paginated(
                run_id=options.run_id,
                scope=f"artist:{artist_id}",
                metadata=connector.metadata,
                fetch_page=fetch_work_page,
                artifact_store=store,
                artifacts_root=artifacts_dir,
                checkpoint_path=checkpoint_path,
                retrieved_at=retrieved_at,
                limit=remaining,
                page_size=page_size,
                max_pages=remaining_pages,
                dry_run=options.dry_run,
                resume=options.resume,
            )
            all_records.extend(collection.records)
            artifact_mutation_count += collection.artifact_mutation_count
            requested_pages += collection.request_count
            resumed_records += collection.resumed_record_count
    except ValueError as error:
        raise typer.BadParameter(str(error)) from error
    finally:
        http_client.close()

    merged_records = merge_duplicate_work_records(all_records)
    result = store.write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=merged_records,
        retrieved_at=retrieved_at,
        dry_run=options.dry_run,
        resume=options.resume,
    )
    estimated_requests = max(len(artist_ids), ceil(options.limit / page_size))
    full_25k_requests = max(len(artist_ids), ceil(25_000 / page_size))
    _emit(
        CommandReport(
            command="snapshot-musicbrainz-works",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(artist_ids),
            output_count=len(merged_records),
            mutation_count=max(result.mutation_count, artifact_mutation_count),
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=(
                f"이번 실행 MusicBrainz page 요청 {requested_pages}회",
                f"limit 기준 최소 요청 추정 {estimated_requests}회",
                f"25,000 work 최소 요청 추정 {full_25k_requests}회, 1 req/s 기준 같은 초 이상",
                f"checkpoint 재사용 행 {resumed_records}개",
                "공식 browse /work?artist= 계약의 WORK만 수집했습니다.",
                "recording/ISRC는 composer work browse와 performance artist 의미가 달라 "
                "수집하지 않았습니다.",
                "운영 DB에 연결하지 않았습니다.",
            ),
        ),
        options,
    )


@app.command("snapshot-work-composer-dependencies")
def snapshot_work_composer_dependencies(
    run_id: RunIdOption,
    work_manifest: Annotated[
        Path,
        typer.Option("--work-manifest", exists=True, dir_okay=False, readable=True),
    ],
    composer_manifests: Annotated[
        list[Path],
        typer.Option(
            "--composer-manifest",
            exists=True,
            dir_okay=False,
            readable=True,
            help="기존 composer canonical manifest. 여러 번 입력할 수 있음",
        ),
    ],
    contact: Annotated[
        str,
        typer.Option("--contact", help="Wikidata User-Agent 연락처. artifact에는 저장하지 않음"),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
    batch_size: Annotated[
        int,
        typer.Option("--batch-size", min=1, max=100, help="WDQS VALUES 요청당 MBID 수"),
    ] = 50,
) -> None:
    """작품 bundle이 참조하지만 composer bundle에 없는 MBID를 정확 QID로 수집합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    try:
        plan = read_work_composer_dependency_plan(work_manifest, composer_manifests)
        connector_value, http_client = build_connector(SourceName.WIKIDATA, contact=contact)
    except ValueError as error:
        raise typer.BadParameter(str(error)) from error
    if not isinstance(connector_value, WikidataConnector):
        raise RuntimeError("Wikidata connector factory 결과가 올바르지 않습니다.")

    connector = WorkComposerDependencyConnector(http_client, connector_value)
    retrieved_at = datetime.now(UTC)
    store = _store(artifacts_dir)
    checkpoint_path = (
        artifacts_dir / options.run_id / "checkpoints" / "work-composer-dependencies.json"
    )
    try:
        collection = collect_work_composer_dependencies(
            run_id=options.run_id,
            plan=plan,
            connector=connector,
            artifact_store=store,
            artifacts_root=artifacts_dir,
            checkpoint_path=checkpoint_path,
            retrieved_at=retrieved_at,
            limit=options.limit,
            batch_size=batch_size,
            dry_run=options.dry_run,
            resume=options.resume,
        )
    except ValueError as error:
        raise typer.BadParameter(str(error)) from error
    finally:
        http_client.close()

    snapshot_result = store.write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=connector.metadata,
        records=collection.records,
        retrieved_at=retrieved_at,
        dry_run=options.dry_run,
        resume=options.resume,
    )
    review_result = None
    if collection.reviews:
        review_result = store.write(
            run_id=options.run_id,
            stage=ArtifactStage.RAW,
            metadata=connector.metadata,
            records=collection.reviews,
            retrieved_at=retrieved_at,
            dry_run=options.dry_run,
            resume=options.resume,
        )
    aggregate_mutations = snapshot_result.mutation_count + (
        review_result.mutation_count if review_result is not None else 0
    )
    selected_count = min(options.limit, len(plan.missing_composer_mbids))
    report = WorkComposerDependencyCommandReport(
        command="snapshot-work-composer-dependencies",
        run_id=options.run_id,
        dry_run=options.dry_run,
        input_count=selected_count,
        output_count=len(collection.records),
        mutation_count=max(collection.artifact_mutation_count, aggregate_mutations),
        data_path=str(snapshot_result.data_path),
        manifest_path=str(snapshot_result.manifest_path),
        required_composer_count=len(plan.required_composer_keys),
        existing_composer_count=len(plan.existing_composer_keys),
        missing_composer_count=len(plan.missing_composer_mbids),
        selected_composer_count=selected_count,
        resolved_composer_count=len(collection.records),
        review_count=len(collection.reviews),
        resumed_composer_count=collection.resumed_composer_count,
        request_count=collection.request_count,
        review_data_path=(str(review_result.data_path) if review_result is not None else None),
        review_manifest_path=(
            str(review_result.manifest_path) if review_result is not None else None
        ),
        notes=(
            "작품 composer FK와 기존 composer natural key의 차집합만 처리했습니다.",
            "이름 매칭 없이 MusicBrainz artist ID와 Wikidata P434만 사용했습니다.",
            "운영 DB에 연결하지 않았습니다.",
        ),
    )
    _emit(report, options)
    if collection.reviews:
        raise typer.Exit(code=1)


@app.command()
def normalize(
    run_id: RunIdOption,
    manifest: Annotated[
        Path,
        typer.Option("--manifest", exists=True, dir_okay=False, readable=True),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
) -> None:
    """Raw source records를 결정적 canonical candidate로 정규화합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    parent, raw_records = read_artifact(manifest, SourceRecord)
    _require_stage(parent.stage, ArtifactStage.RAW)
    _require_run_id(parent.run_id, options.run_id)
    selected = raw_records[: options.limit]
    normalized = normalize_records(selected)
    result = _store(artifacts_dir).write(
        run_id=options.run_id,
        stage=ArtifactStage.NORMALIZED,
        metadata=_metadata_from_manifest(parent),
        records=normalized,
        retrieved_at=datetime.now(UTC),
        dry_run=options.dry_run,
        resume=options.resume,
        parent_sha256=parent.sha256,
        input_provenance=parent.input_provenance,
    )
    _emit(
        CommandReport(
            command="normalize",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(selected),
            output_count=len(normalized),
            mutation_count=result.mutation_count,
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=("외부 ID는 보존하고 이름은 병합 근거로 사용하지 않았습니다.",),
        ),
        options,
    )


@app.command()
def resolve(
    run_id: RunIdOption,
    manifest: Annotated[
        Path,
        typer.Option("--manifest", exists=True, dir_okay=False, readable=True),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
) -> None:
    """안정적 외부 ID만 자동 병합하고 이름 단독 일치는 검수 큐로 보냅니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    parent, candidates = read_artifact(manifest, NormalizedEntityCandidate)
    _require_stage(parent.stage, ArtifactStage.NORMALIZED)
    _require_run_id(parent.run_id, options.run_id)
    selected = candidates[: options.limit]
    decisions = resolve_candidates(selected)
    result = _store(artifacts_dir).write(
        run_id=options.run_id,
        stage=ArtifactStage.RESOLVED,
        metadata=_metadata_from_manifest(parent),
        records=decisions,
        retrieved_at=datetime.now(UTC),
        dry_run=options.dry_run,
        resume=options.resume,
        parent_sha256=parent.sha256,
        input_provenance=parent.input_provenance,
    )
    review_count = sum(
        decision.reason_code == "NAME_ONLY_MATCH_FORBIDDEN" for decision in decisions
    )
    _emit(
        CommandReport(
            command="resolve",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(selected),
            output_count=len(decisions),
            mutation_count=result.mutation_count,
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=(
                f"이름 단독 일치 검수 대상 {review_count}개",
                "운영 DB merge는 수행하지 않았습니다.",
            ),
        ),
        options,
    )


@app.command("link-streaming")
def link_streaming(
    run_id: RunIdOption,
    input_path: Annotated[
        Path,
        typer.Option("--input", exists=True, dir_okay=False, readable=True),
    ],
    platform: Annotated[StreamingPlatform, typer.Option("--platform", case_sensitive=False)],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
) -> None:
    """Spotify/Apple export JSONL을 검증해 트랙 링크 load bundle로 만듭니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    candidates = read_streaming_candidates(input_path)[: options.limit]
    mismatched_platforms = [
        candidate.platform_track.platform
        for candidate in candidates
        if candidate.platform_track.platform is not platform
    ]
    if mismatched_platforms:
        raise typer.BadParameter(
            "입력 JSONL의 platform이 --platform과 일치하지 않습니다.",
            param_hint="--platform",
        )
    metadata = streaming_source_metadata(platform)
    raw_result = _store(artifacts_dir).write(
        run_id=options.run_id,
        stage=ArtifactStage.RAW,
        metadata=metadata,
        records=candidates,
        retrieved_at=datetime.now(UTC),
        dry_run=options.dry_run,
        resume=options.resume,
    )
    load_records = build_streaming_load_bundle(candidates, run_id=options.run_id)
    streaming_result = _store(artifacts_dir).write(
        run_id=options.run_id,
        stage=ArtifactStage.STREAMING,
        metadata=metadata,
        records=load_records,
        retrieved_at=datetime.now(UTC),
        dry_run=options.dry_run,
        resume=options.resume,
        parent_sha256=raw_result.manifest.sha256,
    )
    review_count = sum(record.table is LoadTable.REVIEW_QUEUE for record in load_records)
    _emit(
        CommandReport(
            command="link-streaming",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(candidates),
            output_count=len(load_records),
            mutation_count=raw_result.mutation_count + streaming_result.mutation_count,
            data_path=str(streaming_result.data_path),
            manifest_path=str(streaming_result.manifest_path),
            notes=(
                f"자동 확정되지 않은 검수 대상 {review_count}개",
                "토큰/API 호출과 운영 DB 쓰기를 수행하지 않았습니다.",
            ),
        ),
        options,
    )


@app.command("export-canonical")
def export_canonical(
    run_id: RunIdOption,
    manifest: Annotated[
        Path,
        typer.Option("--manifest", exists=True, dir_okay=False, readable=True),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
    artifacts_dir: ArtifactsDirOption = Path("artifacts"),
) -> None:
    """Resolved artifact를 DB 비연결 canonical load bundle로 변환합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    resolved_manifest, decisions = read_artifact(manifest, ResolutionDecision)
    _require_stage(resolved_manifest.stage, ArtifactStage.RESOLVED)
    _require_run_id(resolved_manifest.run_id, options.run_id)
    normalized_manifest_path = _parent_manifest_path(
        manifest,
        resolved_manifest,
        ArtifactStage.NORMALIZED,
    )
    normalized_manifest, candidates = read_artifact(
        normalized_manifest_path,
        NormalizedEntityCandidate,
    )
    raw_manifest_path = _parent_manifest_path(
        normalized_manifest_path,
        normalized_manifest,
        ArtifactStage.RAW,
    )
    raw_manifest, raw_records = read_artifact(raw_manifest_path, SourceRecord)

    selected_decisions = decisions[: options.limit]
    selected_candidate_ids = {
        candidate_id for decision in selected_decisions for candidate_id in decision.candidate_ids
    }
    selected_candidates = [
        candidate for candidate in candidates if candidate.candidate_id in selected_candidate_ids
    ]
    load_records = build_canonical_load_bundle(
        run_id=options.run_id,
        source_manifest=raw_manifest,
        raw_records=raw_records,
        candidates=selected_candidates,
        decisions=selected_decisions,
    )
    result = _store(artifacts_dir).write(
        run_id=options.run_id,
        stage=ArtifactStage.CANONICAL,
        metadata=_metadata_from_manifest(raw_manifest),
        records=load_records,
        retrieved_at=datetime.now(UTC),
        dry_run=options.dry_run,
        resume=options.resume,
        parent_sha256=resolved_manifest.sha256,
        input_provenance=raw_manifest.input_provenance,
    )
    _emit(
        CommandReport(
            command="export-canonical",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=len(selected_candidates),
            output_count=len(load_records),
            mutation_count=result.mutation_count,
            data_path=str(result.data_path),
            manifest_path=str(result.manifest_path),
            notes=(
                "운영 DB 연결 없이 JSONL load bundle만 생성했습니다.",
                "모든 write policy는 manual/editor_locked 보존입니다.",
            ),
        ),
        options,
    )


@app.command()
def validate(
    run_id: RunIdOption,
    manifest: Annotated[
        Path,
        typer.Option("--manifest", exists=True, dir_okay=False, readable=True),
    ],
    dry_run: DryRunOption = False,
    resume: ResumeOption = True,
    limit: LimitOption = 20,
    json_report: JsonReportOption = None,
) -> None:
    """Canonical load bundle의 발행 차단 규칙을 구조화 report로 판정합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    snapshot_manifest = read_manifest(manifest)
    if snapshot_manifest.stage not in {ArtifactStage.CANONICAL, ArtifactStage.STREAMING}:
        raise typer.BadParameter(
            "validate는 canonical 또는 streaming load bundle만 지원합니다.",
            param_hint="--manifest",
        )
    _require_run_id(snapshot_manifest.run_id, options.run_id)
    _, load_records = read_artifact(manifest, CanonicalLoadRecord)
    try:
        artifact_root = manifest.parents[3]
    except IndexError as error:
        raise typer.BadParameter(
            "manifest 경로가 표준 artifact 구조가 아닙니다.",
            param_hint="--manifest",
        ) from error
    idempotency_result = JsonlArtifactStore(
        artifact_root,
        tool_version=snapshot_manifest.tool_version,
    ).write(
        run_id=options.run_id,
        stage=snapshot_manifest.stage,
        metadata=_metadata_from_manifest(snapshot_manifest),
        records=load_records,
        retrieved_at=snapshot_manifest.retrieved_at,
        dry_run=True,
        resume=options.resume,
        parent_sha256=snapshot_manifest.parent_sha256,
        input_provenance=snapshot_manifest.input_provenance,
    )
    rules = validate_canonical_bundle(
        load_records,
        idempotent_mutation_count=idempotency_result.mutation_count,
        example_limit=options.limit,
    )
    report = ValidationReport(
        run_id=options.run_id,
        dry_run=options.dry_run,
        artifact_path=str(manifest.parent / snapshot_manifest.relative_data_path),
        artifact_sha256=snapshot_manifest.sha256,
        checked_records=len(load_records),
        mutation_count=idempotency_result.mutation_count,
        passed=all(rule.passed for rule in rules),
        rules=rules,
    )
    typer.echo(render_report(report))
    write_report(report, options.json_report, dry_run=options.dry_run)
    if not report.passed:
        raise typer.Exit(code=1)


def _options(
    run_id: str,
    dry_run: bool,
    resume: bool,
    limit: int,
    json_report: Path | None,
) -> RunOptions:
    return RunOptions(
        run_id=run_id,
        dry_run=dry_run,
        resume=resume,
        limit=limit,
        json_report=json_report,
    )


def _store(artifacts_dir: Path) -> JsonlArtifactStore:
    return JsonlArtifactStore(artifacts_dir, tool_version=__version__)


def _metadata_from_manifest(manifest: SnapshotManifest) -> SourceMetadata:
    return SourceMetadata(
        source=manifest.source,
        source_uri=manifest.source_uri,
        license=manifest.license,
        license_uri=manifest.license_uri,
    )


def _require_stage(actual: ArtifactStage, expected: ArtifactStage) -> None:
    if actual is not expected:
        raise typer.BadParameter(
            f"manifest stage가 {expected.value}여야 합니다. actual={actual.value}",
            param_hint="--manifest",
        )


def _require_run_id(actual: str, expected: str) -> None:
    if actual != expected:
        raise typer.BadParameter(
            f"manifest run_id가 --run-id와 같아야 합니다. manifest={actual}",
            param_hint="--run-id",
        )


def _parent_manifest_path(
    child_path: Path,
    child_manifest: SnapshotManifest,
    parent_stage: ArtifactStage,
) -> Path:
    if child_manifest.parent_sha256 is None:
        raise typer.BadParameter(
            f"{child_manifest.stage.value} manifest에 parent_sha256이 없습니다.",
            param_hint="--manifest",
        )
    try:
        artifact_root = child_path.parents[3]
    except IndexError as error:
        raise typer.BadParameter(
            "manifest 경로가 표준 artifact 구조가 아닙니다.",
            param_hint="--manifest",
        ) from error
    parent_path = (
        artifact_root
        / child_manifest.run_id
        / parent_stage
        / child_manifest.source
        / f"{child_manifest.parent_sha256}.manifest.json"
    )
    if not parent_path.is_file():
        raise typer.BadParameter(
            f"부모 manifest를 찾을 수 없습니다: {parent_path}",
            param_hint="--manifest",
        )
    return parent_path


def _emit(report: CommandReport, options: RunOptions) -> None:
    typer.echo(render_report(report))
    write_report(report, options.json_report, dry_run=options.dry_run)
