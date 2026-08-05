from __future__ import annotations

from datetime import UTC, datetime
from pathlib import Path
from typing import Annotated

import typer

from classicmap_seed import __version__
from classicmap_seed.artifacts import JsonlArtifactStore, read_artifact, read_manifest
from classicmap_seed.export import build_canonical_load_bundle
from classicmap_seed.models import (
    ArtifactStage,
    CanonicalLoadRecord,
    CommandReport,
    NormalizedEntityCandidate,
    ResolutionDecision,
    RunOptions,
    SnapshotManifest,
    SourceMetadata,
    SourceName,
    SourceRecord,
    ValidationReport,
)
from classicmap_seed.normalize import normalize_records
from classicmap_seed.reporting import render_report, write_report
from classicmap_seed.resolve import resolve_candidates
from classicmap_seed.sources import build_connector
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
    raw_manifest = read_manifest(raw_manifest_path)

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
    _require_stage(snapshot_manifest.stage, ArtifactStage.CANONICAL)
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
        stage=ArtifactStage.CANONICAL,
        metadata=_metadata_from_manifest(snapshot_manifest),
        records=load_records,
        retrieved_at=snapshot_manifest.retrieved_at,
        dry_run=True,
        resume=options.resume,
        parent_sha256=snapshot_manifest.parent_sha256,
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
