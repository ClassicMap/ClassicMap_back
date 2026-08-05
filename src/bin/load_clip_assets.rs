use serde::Serialize;
use std::{env, fs, path::PathBuf, process};
use ClassicMap_back::{
    clip_asset_loader::{ClipAssetLoadError, ClipAssetLoadOptions, ClipAssetLoader},
    db,
};

#[derive(Debug)]
struct CliOptions {
    load: ClipAssetLoadOptions,
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
    let mut cache_dir = env::var_os("CLIP_CACHE_DIR").map(PathBuf::from);
    let mut public_base_url = env::var("CLIP_PUBLIC_BASE_URL")
        .ok()
        .or_else(|| env::var("VIDEO_CLIP_PUBLIC_BASE_URL").ok());
    let mut dry_run = false;
    let mut publish = false;
    let mut seed_run_id = None;
    let mut json_report = None;
    let mut index = 0;

    while index < args.len() {
        match args[index].as_str() {
            "--bundle" => {
                bundle_path = Some(PathBuf::from(value_after(args, index, "--bundle")?));
                index += 2;
            }
            "--cache-dir" => {
                cache_dir = Some(PathBuf::from(value_after(args, index, "--cache-dir")?));
                index += 2;
            }
            "--public-base-url" => {
                public_base_url = Some(value_after(args, index, "--public-base-url")?);
                index += 2;
            }
            "--seed-run-id" | "--run-id" => {
                seed_run_id = Some(value_after(args, index, args[index].as_str())?);
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
            "--publish" => {
                publish = true;
                index += 1;
            }
            "--help" => return Ok(None),
            value => return Err(format!("지원하지 않는 옵션임: {value}")),
        }
    }

    let bundle_path = bundle_path.ok_or_else(|| "--bundle 경로가 필요함".to_string())?;
    let public_base_url = public_base_url
        .ok_or_else(|| "--public-base-url 또는 CLIP_PUBLIC_BASE_URL이 필요함".to_string())?;
    let mut load = ClipAssetLoadOptions::with_defaults(bundle_path, public_base_url);
    if let Some(cache_dir) = cache_dir {
        load.cache_dir = cache_dir;
    }
    load.dry_run = dry_run;
    load.publish = publish;
    load.seed_run_id = seed_run_id;

    Ok(Some(CliOptions { load, json_report }))
}

fn print_help() {
    println!(
        "사용법:\n  load_clip_assets --bundle <clip-assets.jsonl> [옵션]\n\n옵션:\n  --public-base-url <url>  허용할 외부 HTTPS 클립 base URL\n  --cache-dir <path>       내부 클립 cache 절대 경로\n  --seed-run-id <uuid>     연결할 seed_runs.id\n  --dry-run                DB 검증까지 수행하고 쓰지 않음\n  --publish                적재 후 같은 트랜잭션에서 발행\n  --json-report <path>     구조화 JSON 보고서 파일\n  --help                   도움말\n\n환경변수:\n  CLIP_PUBLIC_BASE_URL (또는 VIDEO_CLIP_PUBLIC_BASE_URL)\n  CLIP_CACHE_DIR\n  DATABASE_URL"
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

fn emit_loader_error(error: ClipAssetLoadError, json_report: Option<&PathBuf>) -> ! {
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
    let report = match ClipAssetLoader::load(&pool, &options.load).await {
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
    fn required_and_boolean_options_are_parsed() {
        let args = vec![
            "--bundle".to_string(),
            "bundle.jsonl".to_string(),
            "--public-base-url".to_string(),
            "https://media.example.test/classicmap/clips".to_string(),
            "--dry-run".to_string(),
            "--publish".to_string(),
        ];
        let options = parse_args(&args).expect("옵션 parse").expect("실행 옵션");
        assert!(options.load.dry_run);
        assert!(options.load.publish);
        assert_eq!(options.load.bundle_path.to_string_lossy(), "bundle.jsonl");
    }

    #[test]
    fn unknown_option_is_rejected() {
        assert!(parse_args(&["--unknown".to_string()]).is_err());
    }
}
