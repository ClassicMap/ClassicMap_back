use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use ClassicMap_back::{
    clip_alignment_loader::{AlignmentLoadError, AlignmentLoadOptions, ClipAlignmentLoader},
    db,
};

#[derive(Debug)]
struct CliOptions {
    load: AlignmentLoadOptions,
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
    let mut input_path = None;
    let mut dry_run = false;
    let mut limit = None;
    let mut run_id = None;
    let mut json_report = None;
    let mut index = 0;

    while index < args.len() {
        match args[index].as_str() {
            "--input" => {
                input_path = Some(PathBuf::from(value_after(args, index, "--input")?));
                index += 2;
            }
            "--limit" => {
                let raw = value_after(args, index, "--limit")?;
                limit = Some(
                    raw.parse::<usize>()
                        .map_err(|_| format!("--limit 은 0 이상의 정수여야 함: {raw}"))?,
                );
                index += 2;
            }
            "--run-id" => {
                run_id = Some(value_after(args, index, "--run-id")?);
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
            // 같은 입력을 다시 넣으면 이미 넣은 줄은 바뀌지 않으므로 이어 넣기는 다시 돌리는 것과 같다
            "--resume" => index += 1,
            "--help" => return Ok(None),
            value => return Err(format!("지원하지 않는 옵션임: {value}")),
        }
    }

    let input_path = input_path.ok_or_else(|| "--input 경로가 필요함".to_string())?;
    Ok(Some(CliOptions {
        load: AlignmentLoadOptions {
            input_path,
            dry_run,
            limit,
            run_id,
        },
        json_report,
    }))
}

fn print_help() {
    println!(
        "사용법:\n  load_clip_alignments --input <alignment-maps.jsonl> [옵션]\n\n옵션:\n  --dry-run                DB 검증까지 하고 쓰지 않음\n  --limit <n>              입력이 n줄을 넘으면 적재하지 않음\n  --run-id <id>            보고서에 남길 실행 id\n  --resume                 다시 돌려도 결과가 같아 따로 하는 일이 없음\n  --json-report <path>     구조화 JSON 보고서 파일\n  --help                   도움말\n\n환경변수:\n  DATABASE_URL (또는 MYSQL_HOST·MYSQL_PASSWORD)"
    );
}

fn write_report(path: Option<&PathBuf>, json: &str) -> Result<(), String> {
    if let Some(path) = path {
        let temporary_path = path.with_extension(format!(
            "{}.tmp",
            path.extension()
                .and_then(|extension| extension.to_str())
                .unwrap_or("json")
        ));
        if let Some(parent) = path
            .parent()
            .filter(|parent| !parent.as_os_str().is_empty())
        {
            fs::create_dir_all(parent)
                .map_err(|error| format!("보고서 디렉터리를 만들 수 없음: {error}"))?;
        }
        fs::write(&temporary_path, format!("{json}\n"))
            .map_err(|error| format!("임시 보고서를 쓸 수 없음: {error}"))?;
        fs::rename(&temporary_path, path)
            .map_err(|error| format!("보고서를 원자 교체할 수 없음: {error}"))?;
    }
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
        format!(
            "{{\"status\":\"failed\",\"exitCode\":3,\"error\":{{\"code\":\"REPORT_SERIALIZATION_ERROR\",\"message\":\"{error}\"}}}}"
        )
    });
    if let Err(error) = write_report(json_report, &json) {
        eprintln!("{{\"status\":\"failed\",\"exitCode\":3,\"error\":{{\"code\":\"REPORT_WRITE_ERROR\",\"message\":{}}}}}", serde_json::to_string(&error).unwrap_or_else(|_| "\"report write error\"".to_string()));
        process::exit(3);
    }
    eprintln!("{json}");
    process::exit(exit_code);
}

fn emit_loader_error(error: AlignmentLoadError, json_report: Option<&PathBuf>) -> ! {
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
    let report = match ClipAlignmentLoader::load(&pool, &options.load).await {
        Ok(report) => report,
        Err(error) => emit_loader_error(error, options.json_report.as_ref()),
    };
    let json = match serde_json::to_string_pretty(&report) {
        Ok(json) => json,
        Err(error) => emit_error(
            "REPORT_SERIALIZATION_ERROR",
            format!("보고서를 직렬화할 수 없음: {error}"),
            None,
            3,
            options.json_report.as_ref(),
        ),
    };
    if let Err(error) = write_report(options.json_report.as_ref(), &json) {
        emit_error(
            "REPORT_WRITE_ERROR",
            error,
            None,
            3,
            options.json_report.as_ref(),
        );
    }
    println!("{json}");
}

#[cfg(test)]
mod tests {
    use super::parse_args;

    #[test]
    fn options_are_parsed() {
        let args = [
            "--input",
            "alignment-maps.jsonl",
            "--dry-run",
            "--limit",
            "700",
            "--run-id",
            "alignment-2026-10-02",
            "--resume",
        ]
        .map(String::from);
        let options = parse_args(&args).expect("옵션").expect("실행 옵션");
        assert!(options.load.dry_run);
        assert_eq!(options.load.limit, Some(700));
        assert_eq!(options.load.run_id.as_deref(), Some("alignment-2026-10-02"));
    }

    #[test]
    fn input_is_required_and_unknown_option_rejected() {
        assert!(parse_args(&["--dry-run".to_string()]).is_err());
        assert!(parse_args(&["--unknown".to_string()]).is_err());
    }
}
