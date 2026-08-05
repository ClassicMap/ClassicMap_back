use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use ClassicMap_back::{
    comparison_seed_loader::{
        ComparisonSeedLoadError, ComparisonSeedLoadOptions, ComparisonSeedLoader,
    },
    db,
};

#[derive(Debug)]
struct CliOptions {
    load: ComparisonSeedLoadOptions,
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
    let mut run_id = None;
    let mut dry_run = false;
    let mut resume = false;
    let mut limit = None;
    let mut source_code_version = env::var("SOURCE_CODE_VERSION").ok();
    let mut json_report = None;
    let mut index = 0;

    while index < args.len() {
        match args[index].as_str() {
            "--bundle" => {
                bundle_path = Some(PathBuf::from(value_after(args, index, "--bundle")?));
                index += 2;
            }
            "--run-id" => {
                run_id = Some(value_after(args, index, "--run-id")?);
                index += 2;
            }
            "--source-code-version" => {
                source_code_version = Some(value_after(args, index, "--source-code-version")?);
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
            "--limit" => {
                let raw = value_after(args, index, "--limit")?;
                limit = Some(
                    raw.parse::<usize>()
                        .map_err(|_| "--limit은 1 이상의 정수여야 함".to_string())?,
                );
                index += 2;
            }
            "--help" => return Ok(None),
            value => return Err(format!("지원하지 않는 옵션임: {value}")),
        }
    }

    Ok(Some(CliOptions {
        load: ComparisonSeedLoadOptions {
            bundle_path: bundle_path.ok_or_else(|| "--bundle 경로가 필요함".to_string())?,
            run_id: run_id.ok_or_else(|| "--run-id UUID가 필요함".to_string())?,
            dry_run,
            resume,
            limit,
            source_code_version,
        },
        json_report,
    }))
}

fn print_help() {
    println!(
        "사용법:\n  load_comparison_candidates --bundle <candidates.jsonl> --run-id <uuid> [옵션]\n\n옵션:\n  --dry-run                 전체 DB 검증 후 후보 변경 rollback\n  --resume                  기존 자연키 적재분을 건너뛰며 계속 검증\n  --limit <count>           candidateKey 정렬 후 앞의 N건만 적재\n  --source-code-version     실행 코드 버전\n  --json-report <path>      구조화 JSON 보고서 원자 기록\n  --help                    도움말\n\n환경변수:\n  DATABASE_URL\n  SOURCE_CODE_VERSION"
    );
}

fn write_atomic(path: &PathBuf, contents: &str) -> Result<(), String> {
    if let Some(parent) = path
        .parent()
        .filter(|parent| !parent.as_os_str().is_empty())
    {
        fs::create_dir_all(parent)
            .map_err(|error| format!("출력 디렉터리를 만들 수 없음: {error}"))?;
    }
    let temporary = path.with_extension(format!(
        "{}.tmp",
        path.extension()
            .and_then(|extension| extension.to_str())
            .unwrap_or("json")
    ));
    fs::write(&temporary, contents).map_err(|error| format!("임시 출력을 쓸 수 없음: {error}"))?;
    fs::rename(&temporary, path).map_err(|error| format!("출력을 원자 교체할 수 없음: {error}"))?;
    Ok(())
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
    let json = serde_json::to_string_pretty(&report).unwrap_or_else(|error| {
        format!("{{\"status\":\"failed\",\"exitCode\":3,\"error\":{{\"code\":\"REPORT_SERIALIZATION_ERROR\",\"message\":\"{error}\"}}}}")
    });
    if let Some(path) = json_report {
        if let Err(error) = write_atomic(path, &format!("{json}\n")) {
            eprintln!("보고서 기록 실패: {error}");
            process::exit(3);
        }
    }
    eprintln!("{json}");
    process::exit(exit_code);
}

fn emit_loader_error(error: ComparisonSeedLoadError, json_report: Option<&PathBuf>) -> ! {
    let exit_code = error.exit_code();
    emit_error(
        error.code(),
        error.to_string(),
        error.line(),
        exit_code,
        json_report,
    )
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
    let report = match ComparisonSeedLoader::load(&pool, &options.load).await {
        Ok(report) => report,
        Err(error) => emit_loader_error(error, options.json_report.as_ref()),
    };
    let report_json = serde_json::to_string_pretty(&report).unwrap_or_else(|error| {
        emit_error(
            "REPORT_SERIALIZATION_ERROR",
            format!("보고서를 직렬화할 수 없음: {error}"),
            None,
            3,
            options.json_report.as_ref(),
        )
    });
    if let Some(path) = options.json_report.as_ref() {
        if let Err(error) = write_atomic(path, &format!("{report_json}\n")) {
            emit_error("REPORT_WRITE_ERROR", error, None, 3, Some(path));
        }
    }
    println!("{report_json}");
}

#[cfg(test)]
mod tests {
    use super::parse_args;

    #[test]
    fn required_options_are_parsed() {
        let args = vec![
            "--bundle".to_string(),
            "candidates.jsonl".to_string(),
            "--run-id".to_string(),
            "11111111-1111-4111-8111-111111111111".to_string(),
        ];
        let options = parse_args(&args).expect("옵션 parse").expect("실행 옵션");
        assert!(!options.load.dry_run);
    }
}
