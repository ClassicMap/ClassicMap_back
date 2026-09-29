//! 시드 실행 하나를 발행 직전 상태로 올린다.
//!
//!     approve_seed_run --run-id <uuid> [--dry-run] [--json-report <path>]
//!
//! 배치마다 `approve` 마이그레이션을 손으로 쓰던 것을 대신한다. 까닭은
//! `src/seed_approval.rs` 의 머리글에 적었다.

use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use ClassicMap_back::{
    db,
    seed_approval::{approve_seed_run, SeedApprovalError},
};

#[derive(Debug)]
struct CliOptions {
    run_id: String,
    dry_run: bool,
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
}

fn value_after(args: &[String], index: usize, option: &str) -> Result<String, String> {
    args.get(index + 1)
        .filter(|value| !value.starts_with("--"))
        .cloned()
        .ok_or_else(|| format!("{option} 값이 필요함"))
}

fn parse_args(args: &[String]) -> Result<Option<CliOptions>, String> {
    let mut run_id = None;
    let mut dry_run = false;
    let mut json_report = None;
    let mut index = 0;

    while index < args.len() {
        match args[index].as_str() {
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
            "--help" | "-h" => return Ok(None),
            unknown => return Err(format!("알 수 없는 옵션: {unknown}")),
        }
    }

    let run_id = run_id.ok_or_else(|| "--run-id 가 필요함".to_string())?;
    Ok(Some(CliOptions {
        run_id,
        dry_run,
        json_report,
    }))
}

fn print_help() {
    println!(
        "시드 실행 하나를 발행 직전 상태로 올린다.\n\n\
         사용법:\n  \
         approve_seed_run --run-id <uuid> [--dry-run] [--json-report <path>]\n\n\
         세 가지를 바꾼다. 모두 그 실행의 clip_jobs 에 걸린 행으로 범위를 한정한다.\n  \
         performance_sources.rights_mode      unknown          -> licensed_self_hosted\n  \
         performance_sectors.editorial_status FACTS_VERIFIED   -> EDITOR_REVIEWED\n  \
         performance_candidates.candidate_status REVIEW_REQUIRED -> APPROVED\n\n\
         licensed_self_hosted 은 내부 검증 표기일 뿐 실제 이용 허락이 아니다."
    );
}

fn write_report(path: Option<&PathBuf>, json: &str) -> Result<(), String> {
    let Some(path) = path else {
        return Ok(());
    };
    fs::write(path, format!("{json}\n"))
        .map_err(|error| format!("보고서를 쓸 수 없음: {} ({error})", path.display()))
}

fn emit_error(code: &str, message: String, exit_code: i32, json_report: Option<&PathBuf>) -> ! {
    let report = ErrorReport {
        status: "error",
        exit_code,
        error: ErrorDetails { code, message },
    };
    let json = serde_json::to_string_pretty(&report)
        .unwrap_or_else(|_| "{\"status\":\"error\"}".to_string());
    let _ = write_report(json_report, &json);
    eprintln!("{json}");
    process::exit(exit_code);
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
        Err(error) => emit_error("INVALID_ARGUMENT", error, 2, None),
    };

    let pool = match db::connect_pool().await {
        Ok(pool) => pool,
        Err(error) => emit_error(
            "DATABASE_CONNECTION_ERROR",
            format!("데이터베이스 연결 오류: {error}"),
            3,
            options.json_report.as_ref(),
        ),
    };

    let report = match approve_seed_run(&pool, &options.run_id, options.dry_run).await {
        Ok(report) => report,
        Err(error) => {
            let exit_code = match error {
                SeedApprovalError::Database(_) => 3,
                _ => 4,
            };
            emit_error(
                error.code(),
                error.to_string(),
                exit_code,
                options.json_report.as_ref(),
            )
        }
    };

    let json = match serde_json::to_string_pretty(&report) {
        Ok(json) => json,
        Err(error) => emit_error(
            "REPORT_SERIALIZATION_ERROR",
            format!("보고서를 직렬화할 수 없음: {error}"),
            3,
            options.json_report.as_ref(),
        ),
    };
    if let Err(error) = write_report(options.json_report.as_ref(), &json) {
        emit_error("REPORT_WRITE_ERROR", error, 3, None);
    }
    println!("{json}");
}

#[cfg(test)]
mod tests {
    use super::parse_args;

    #[test]
    fn run_id_is_required() {
        assert!(parse_args(&["--dry-run".to_string()]).is_err());
    }

    #[test]
    fn options_are_parsed() {
        let args = vec![
            "--run-id".to_string(),
            "1f0a".to_string(),
            "--dry-run".to_string(),
            "--json-report".to_string(),
            "report.json".to_string(),
        ];
        let options = parse_args(&args).expect("옵션 parse").expect("실행 옵션");
        assert_eq!(options.run_id, "1f0a");
        assert!(options.dry_run);
        assert_eq!(
            options.json_report.expect("보고서 경로").to_string_lossy(),
            "report.json"
        );
    }

    #[test]
    fn unknown_option_is_rejected() {
        assert!(parse_args(&["--unknown".to_string()]).is_err());
    }

    #[test]
    fn help_returns_no_options() {
        assert!(parse_args(&["--help".to_string()])
            .expect("도움말")
            .is_none());
    }
}
