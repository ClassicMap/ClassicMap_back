use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use uuid::Uuid;
use ClassicMap_back::{
    db,
    legacy_authority_linker::{
        LegacyAuthorityLinkError, LegacyAuthorityLinkOptions, LegacyAuthorityLinkReport,
        LegacyAuthorityLinker,
    },
};

#[derive(Debug)]
struct CliOptions {
    load: LegacyAuthorityLinkOptions,
    json_report: Option<PathBuf>,
    rollback_manifest: Option<PathBuf>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
struct ErrorReport<'a> {
    status: &'static str,
    exit_code: i32,
    error: ErrorDetails<'a>,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
struct ErrorDetails<'a> {
    code: &'a str,
    message: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    line: Option<usize>,
}

fn value_after(args: &[String], index: usize, option: &str) -> Result<String, String> {
    args.get(index + 1)
        .filter(|value| !value.starts_with("--"))
        .cloned()
        .ok_or_else(|| format!("{option} 값이 필요함"))
}

fn parse_args(args: &[String]) -> Result<Option<CliOptions>, String> {
    let mut bundle_path = None;
    let mut run_id = None;
    let mut dry_run = false;
    let mut resume = true;
    let mut limit = None;
    let mut json_report = None;
    let mut rollback_manifest = None;
    let mut index = 0;
    while index < args.len() {
        match args[index].as_str() {
            "--bundle" => {
                bundle_path = Some(PathBuf::from(value_after(args, index, "--bundle")?));
                index += 2;
            }
            "--run-id" => {
                let value = value_after(args, index, "--run-id")?;
                run_id = Some(
                    Uuid::parse_str(&value)
                        .map_err(|error| format!("--run-id가 UUID가 아님: {error}"))?,
                );
                index += 2;
            }
            "--limit" => {
                let value = value_after(args, index, "--limit")?;
                let parsed = value
                    .parse::<usize>()
                    .map_err(|error| format!("--limit가 양의 정수가 아님: {error}"))?;
                if parsed == 0 {
                    return Err("--limit는 1 이상이어야 함".to_string());
                }
                limit = Some(parsed);
                index += 2;
            }
            "--json-report" => {
                json_report = Some(PathBuf::from(value_after(args, index, "--json-report")?));
                index += 2;
            }
            "--rollback-manifest" => {
                rollback_manifest = Some(PathBuf::from(value_after(
                    args,
                    index,
                    "--rollback-manifest",
                )?));
                index += 2;
            }
            "--dry-run" => {
                dry_run = true;
                index += 1;
            }
            "--resume" => {
                resume = true;
                index += 1;
            }
            "--no-resume" => {
                resume = false;
                index += 1;
            }
            "--help" => return Ok(None),
            value => return Err(format!("지원하지 않는 옵션임: {value}")),
        }
    }
    let bundle_path = bundle_path.ok_or_else(|| "--bundle 경로가 필요함".to_string())?;
    let run_id = run_id.ok_or_else(|| "--run-id UUID가 필요함".to_string())?;
    let mut load = LegacyAuthorityLinkOptions::new(bundle_path, run_id);
    load.dry_run = dry_run;
    load.resume = resume;
    load.limit = limit;
    Ok(Some(CliOptions {
        load,
        json_report,
        rollback_manifest,
    }))
}

fn print_help() {
    println!(
        "사용법:\n  link_legacy_authorities --bundle <legacy-authority-links.jsonl> --run-id <uuid> [옵션]\n\n옵션:\n  --dry-run                  모든 mapping을 잠금·검증하고 rollback\n  --resume                   동일 run과 bundle의 멱등 재실행 허용(기본값)\n  --no-resume                기존 run-id가 있으면 실패\n  --limit <count>            bundle 최대 허용 행 수(부분 적재 아님)\n  --json-report <path>       구조화 JSON 보고서 파일\n  --rollback-manifest <path> 역순 rollback manifest JSON 파일\n  --help                     도움말\n\n환경변수:\n  DATABASE_URL"
    );
}

fn write_json_file<T: Serialize>(path: Option<&PathBuf>, value: &T) -> Result<(), String> {
    let Some(path) = path else {
        return Ok(());
    };
    let json = serde_json::to_string_pretty(value)
        .map_err(|error| format!("JSON을 직렬화할 수 없음: {error}"))?;
    if let Some(parent) = path
        .parent()
        .filter(|parent| !parent.as_os_str().is_empty())
    {
        fs::create_dir_all(parent)
            .map_err(|error| format!("보고서 디렉터리를 만들 수 없음: {error}"))?;
    }
    let temporary_path = path.with_extension(format!(
        "{}.tmp",
        path.extension()
            .and_then(|extension| extension.to_str())
            .unwrap_or("json")
    ));
    fs::write(&temporary_path, format!("{json}\n"))
        .map_err(|error| format!("임시 JSON 파일을 쓸 수 없음: {error}"))?;
    fs::rename(&temporary_path, path)
        .map_err(|error| format!("JSON 파일을 원자 교체할 수 없음: {error}"))
}

fn emit_error(
    code: &str,
    message: String,
    line: Option<usize>,
    exit_code: i32,
    json_report: Option<&PathBuf>,
) -> ! {
    let report = ErrorReport {
        status: "failed",
        exit_code,
        error: ErrorDetails {
            code,
            message,
            line,
        },
    };
    if let Err(error) = write_json_file(json_report, &report) {
        eprintln!("JSON report 작성 실패: {error}");
        process::exit(3);
    }
    eprintln!(
        "{}",
        serde_json::to_string_pretty(&report)
            .unwrap_or_else(|_| "{\"status\":\"failed\",\"exitCode\":3}".to_string())
    );
    process::exit(exit_code);
}

fn emit_loader_error(error: LegacyAuthorityLinkError, json_report: Option<&PathBuf>) -> ! {
    emit_error(
        error.code(),
        error.to_string(),
        error.line(),
        error.exit_code(),
        json_report,
    )
}

fn emit_report(report: &LegacyAuthorityLinkReport, options: &CliOptions) -> Result<(), String> {
    write_json_file(options.json_report.as_ref(), report)?;
    write_json_file(
        options.rollback_manifest.as_ref(),
        &report.rollback_manifest,
    )?;
    println!(
        "{}",
        serde_json::to_string_pretty(report)
            .map_err(|error| format!("stdout report를 직렬화할 수 없음: {error}"))?
    );
    Ok(())
}

#[tokio::main]
async fn main() {
    let args = env::args().skip(1).collect::<Vec<_>>();
    let options = match parse_args(&args) {
        Ok(Some(options)) => options,
        Ok(None) => {
            print_help();
            return;
        }
        Err(error) => emit_error("INVALID_ARGUMENT", error, None, 2, None),
    };
    let pool = match db::connect_pool().await {
        Ok(pool) => pool,
        Err(error) => emit_error(
            "DATABASE_CONNECTION_ERROR",
            format!("데이터베이스 연결 오류: {error}"),
            None,
            3,
            options.json_report.as_ref(),
        ),
    };
    let report = match LegacyAuthorityLinker::link(&pool, &options.load).await {
        Ok(report) => report,
        Err(error) => emit_loader_error(error, options.json_report.as_ref()),
    };
    if let Err(error) = emit_report(&report, &options) {
        emit_error(
            "REPORT_WRITE_ERROR",
            error,
            None,
            3,
            options.json_report.as_ref(),
        );
    }
}

#[cfg(test)]
mod tests {
    use super::parse_args;

    #[test]
    fn strict_cli_options_are_parsed() {
        let options = parse_args(&[
            "--bundle".to_string(),
            "links.jsonl".to_string(),
            "--run-id".to_string(),
            "77777777-7777-4777-8777-777777777777".to_string(),
            "--dry-run".to_string(),
            "--limit".to_string(),
            "10".to_string(),
        ])
        .expect("옵션 parse")
        .expect("실행 옵션");
        assert!(options.load.dry_run);
        assert_eq!(options.load.limit, Some(10));
    }

    #[test]
    fn unknown_option_is_rejected() {
        assert!(parse_args(&["--unknown".to_string()]).is_err());
    }
}
