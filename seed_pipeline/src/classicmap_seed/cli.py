from __future__ import annotations

from datetime import UTC, datetime
from pathlib import Path
from typing import Annotated

import typer

from classicmap_seed import __version__
from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact, read_manifest
from classicmap_seed.models import (
    ArtifactStage,
    CommandReport,
    NormalizedEntityCandidate,
    ResolutionDecision,
    RunOptions,
    SnapshotManifest,
    SourceMetadata,
    SourceName,
    SourceRecord,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.reporting import render_report, write_report
from classicmap_seed.resolve import resolve_candidates
from classicmap_seed.sources import build_connector

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


@app.command()
def snapshot(
    run_id: RunIdOption,
    source: Annotated[SourceName, typer.Option("--source", case_sensitive=False)],
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
        connector, http_client = build_connector(source, contact=contact)
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
    """Manifest의 SHA-256과 row_count를 다시 검증합니다."""
    options = _options(run_id, dry_run, resume, limit, json_report)
    snapshot_manifest = read_manifest(manifest)
    if snapshot_manifest.stage is ArtifactStage.RAW:
        _, raw_records = read_artifact(manifest, SourceRecord)
        record_count = len(raw_records)
    elif snapshot_manifest.stage is ArtifactStage.NORMALIZED:
        _, normalized_records = read_artifact(manifest, NormalizedEntityCandidate)
        record_count = len(normalized_records)
    else:
        _, resolution_records = read_artifact(manifest, ResolutionDecision)
        record_count = len(resolution_records)
    inspected_count = min(record_count, options.limit)
    _emit(
        CommandReport(
            command="validate",
            run_id=options.run_id,
            dry_run=options.dry_run,
            input_count=inspected_count,
            output_count=inspected_count,
            mutation_count=0,
            data_path=str(manifest.parent / snapshot_manifest.relative_data_path),
            manifest_path=str(manifest),
            notes=(
                f"resume={options.resume}",
                "SHA-256과 row_count가 manifest와 일치합니다.",
            ),
        ),
        options,
    )


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


def _emit(report: CommandReport, options: RunOptions) -> None:
    typer.echo(render_report(report))
    write_report(report, options.json_report, dry_run=options.dry_run)
