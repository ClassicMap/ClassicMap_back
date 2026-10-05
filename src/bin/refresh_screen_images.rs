use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use ClassicMap_back::{
    db,
    screen_image_refresher::{ScreenImageRefreshOptions, ScreenImageRefresher, TmdbReadToken},
};

const DEFAULT_STALE_DAYS: u32 = 30;

#[derive(Debug)]
struct CliOptions {
    refresh: ScreenImageRefreshOptions,
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
    let mut dry_run = false;
    let mut limit = None;
    let mut run_id = None;
    let mut json_report = None;
    let mut stale_days = DEFAULT_STALE_DAYS;
    let mut index = 0;

    while index < args.len() {
        match args[index].as_str() {
            "--limit" => {
                let raw = value_after(args, index, "--limit")?;
                limit = Some(
                    raw.parse::<usize>()
                        .map_err(|_| format!("--limit 은 0 이상의 정수여야 함: {raw}"))?,
                );
                index += 2;
            }
            "--stale-days" => {
                let raw = value_after(args, index, "--stale-days")?;
                stale_days = raw
                    .parse::<u32>()
                    .map_err(|_| format!("--stale-days 는 0 이상의 정수여야 함: {raw}"))?;
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
            // 받은 시각이 남아 있어 다시 돌리면 남은 작품만 받는다
            "--resume" => index += 1,
            "--help" => return Ok(None),
            value => return Err(format!("지원하지 않는 옵션임: {value}")),
        }
    }

    Ok(Some(CliOptions {
        refresh: ScreenImageRefreshOptions {
            dry_run,
            limit,
            run_id,
            stale_days,
        },
        json_report,
    }))
}

fn token_from_env() -> Option<TmdbReadToken> {
    env::var("TMDB_API_READ_TOKEN")
        .ok()
        .map(|value| value.trim().to_string())
        .filter(|value| !value.is_empty())
        .map(TmdbReadToken)
}

fn print_help() {
    println!(
        "사용법:\n  refresh_screen_images [옵션]\n\n옵션:\n  --dry-run                TMDB 에서 받아 비교만 하고 쓰지 않음\n  --stale-days <n>         n일보다 오래 전에 받은 작품만(기본 {DEFAULT_STALE_DAYS}, 0 이면 전부)\n  --limit <n>              이번에 받을 작품 수 상한\n  --run-id <id>            보고서에 남길 실행 id\n  --resume                 받은 시각으로 남은 작품만 받으므로 따로 하는 일이 없음\n  --json-report <path>     구조화 JSON 보고서 파일\n  --help                   도움말\n\n환경변수:\n  TMDB_API_READ_TOKEN (v4 읽기 토큰)\n  DATABASE_URL (또는 MYSQL_HOST·MYSQL_PASSWORD)"
    );
}

fn write_report(path: Option<&PathBuf>, json: &str) -> Result<(), String> {
    if let Some(path) = path {
        if let Some(parent) = path
            .parent()
            .filter(|parent| !parent.as_os_str().is_empty())
        {
            fs::create_dir_all(parent)
                .map_err(|error| format!("보고서 디렉터리를 만들 수 없음: {error}"))?;
        }
        let temporary_path = path.with_extension("json.tmp");
        fs::write(&temporary_path, format!("{json}\n"))
            .map_err(|error| format!("임시 보고서를 쓸 수 없음: {error}"))?;
        fs::rename(&temporary_path, path)
            .map_err(|error| format!("보고서를 원자 교체할 수 없음: {error}"))?;
    }
    Ok(())
}

fn emit_error(code: &str, message: String, exit_code: i32, json_report: Option<&PathBuf>) -> ! {
    let report = ErrorReport {
        status: "failed",
        exit_code,
        error: ErrorDetails { code, message },
    };
    let json = serde_json::to_string_pretty(&report)
        .unwrap_or_else(|_| "{\"status\":\"failed\"}".to_string());
    if let Err(error) = write_report(json_report, &json) {
        eprintln!("{error}");
    }
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
    let Some(token) = token_from_env() else {
        emit_error(
            "TMDB_CREDENTIAL_MISSING",
            "TMDB_API_READ_TOKEN 이 필요함".to_string(),
            2,
            options.json_report.as_ref(),
        );
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
    let report = match ScreenImageRefresher::refresh(&pool, token, &options.refresh).await {
        Ok(report) => report,
        Err(error) => emit_error(
            error.code(),
            error.to_string(),
            error.exit_code(),
            options.json_report.as_ref(),
        ),
    };
    let json = serde_json::to_string_pretty(&report).unwrap_or_else(|_| "{}".to_string());
    if let Err(error) = write_report(options.json_report.as_ref(), &json) {
        emit_error("REPORT_WRITE_ERROR", error, 3, options.json_report.as_ref());
    }
    println!("{json}");
}

#[cfg(test)]
mod tests {
    use super::parse_args;

    #[test]
    fn options_are_parsed() {
        let args = ["--dry-run", "--stale-days", "0", "--limit", "5", "--resume"].map(String::from);
        let options = parse_args(&args).expect("옵션").expect("실행 옵션");
        assert!(options.refresh.dry_run);
        assert_eq!(options.refresh.stale_days, 0);
        assert_eq!(options.refresh.limit, Some(5));
    }

    #[test]
    fn unknown_option_is_rejected() {
        assert!(parse_args(&["--unknown".to_string()]).is_err());
        assert!(parse_args(&["--stale-days".to_string(), "x".to_string()]).is_err());
    }
}
