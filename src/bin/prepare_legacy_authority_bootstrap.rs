use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use uuid::Uuid;
use ClassicMap_back::global_seed_loader::{
    AuthorityBootstrapOptions, AuthorityBootstrapReport, GlobalSeedLoadError, GlobalSeedLoader,
};

#[derive(Debug)]
struct CliOptions {
    prepare: AuthorityBootstrapOptions,
    json_report: Option<PathBuf>,
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
    let mut output_path = None;
    let mut run_id = None;
    let mut dry_run = false;
    let mut resume = true;
    let mut limit = None;
    let mut json_report = None;
    let mut index = 0;
    while index < args.len() {
        match args[index].as_str() {
            "--bundle" => {
                bundle_path = Some(PathBuf::from(value_after(args, index, "--bundle")?));
                index += 2;
            }
            "--output" => {
                output_path = Some(PathBuf::from(value_after(args, index, "--output")?));
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
    let output_path = output_path.ok_or_else(|| "--output 경로가 필요함".to_string())?;
    let mut prepare = AuthorityBootstrapOptions::new(bundle_path, output_path);
    prepare.run_id = run_id;
    prepare.dry_run = dry_run;
    prepare.resume = resume;
    prepare.limit = limit;
    Ok(Some(CliOptions {
        prepare,
        json_report,
    }))
}

fn print_help() {
    println!(
        "사용법:\n  prepare_legacy_authority_bootstrap --bundle <full-canonical.jsonl> --output <authority-bootstrap.jsonl> [옵션]\n\n옵션:\n  --run-id <uuid>       canonical bundle seed_run_id 검증\n  --dry-run             full bundle과 dependency closure만 검증하고 파일을 쓰지 않음\n  --resume              동일한 기존 출력 파일 재사용(기본값)\n  --no-resume           출력 파일이 이미 있으면 실패\n  --limit <count>       원본 bundle 최대 허용 행 수(부분 추출 아님)\n  --json-report <path>  구조화 JSON 보고서 파일\n  --help                도움말"
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

fn emit_loader_error(error: GlobalSeedLoadError, json_report: Option<&PathBuf>) -> ! {
    emit_error(
        error.code(),
        error.to_string(),
        error.line(),
        error.exit_code(),
        json_report,
    )
}

fn emit_report(report: &AuthorityBootstrapReport, options: &CliOptions) -> Result<(), String> {
    write_json_file(options.json_report.as_ref(), report)?;
    println!(
        "{}",
        serde_json::to_string_pretty(report)
            .map_err(|error| format!("stdout report를 직렬화할 수 없음: {error}"))?
    );
    Ok(())
}

fn main() {
    let args = env::args().skip(1).collect::<Vec<_>>();
    let options = match parse_args(&args) {
        Ok(Some(options)) => options,
        Ok(None) => {
            print_help();
            return;
        }
        Err(error) => emit_error("INVALID_ARGUMENT", error, None, 2, None),
    };
    let report = match GlobalSeedLoader::prepare_authority_bootstrap(&options.prepare) {
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
            "full.jsonl".to_string(),
            "--output".to_string(),
            "authority.jsonl".to_string(),
            "--dry-run".to_string(),
            "--limit".to_string(),
            "100".to_string(),
        ])
        .expect("옵션 parse")
        .expect("실행 옵션");
        assert!(options.prepare.dry_run);
        assert_eq!(options.prepare.limit, Some(100));
    }

    #[test]
    fn unknown_option_is_rejected() {
        assert!(parse_args(&["--unknown".to_string()]).is_err());
    }
}
