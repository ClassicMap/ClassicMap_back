//! 시드 실행 하나의 클립을 클리퍼에 만들게 하고 `load_clip_assets` 번들을 낸다.
//!
//!     build_clip_bundle --run-id <uuid> --out <bundle.jsonl> \
//!         [--clipper-base-url http://clipper:3200] \
//!         [--public-base-url https://…/clips] \
//!         [--cache-dir /var/cache/classicmap-video-clips] \
//!         [--encoding-profile-version v1-copy] [--json-report <path>]
//!
//! 빌드 토큰은 `VIDEO_CLIP_BUILD_TOKEN` 또는 `CLIP_BUILD_TOKEN` 환경변수로 받는다.
//! **명령줄로 받지 않는다** — 명령줄은 프로세스 목록에 남는다.

use serde::Serialize;
use std::{env, fs, path::PathBuf, process, time::Duration};
use ClassicMap_back::{
    clip_bundle_builder::{build_clip_bundle, ClipBundleError, ClipBundleOptions},
    db,
};

const DEFAULT_CLIPPER: &str = "http://clipper:3200";
const DEFAULT_CACHE_DIR: &str = "/var/cache/classicmap-video-clips";
const DEFAULT_PROFILE: &str = "v1-copy";
const DEFAULT_TIMEOUT_SECONDS: u64 = 600;

#[derive(Debug)]
struct CliOptions {
    build: ClipBundleOptions,
    out: PathBuf,
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

fn build_token() -> Result<String, String> {
    env::var("VIDEO_CLIP_BUILD_TOKEN")
        .or_else(|_| env::var("CLIP_BUILD_TOKEN"))
        .map_err(|_| "VIDEO_CLIP_BUILD_TOKEN 또는 CLIP_BUILD_TOKEN 이 필요함".to_string())
}

fn parse_args(args: &[String], token: String) -> Result<Option<CliOptions>, String> {
    let mut run_id = None;
    let mut out = None;
    let mut clipper_base_url = env::var("CLIP_BASE_URL").unwrap_or_else(|_| DEFAULT_CLIPPER.into());
    let mut public_base_url = env::var("CLIP_PUBLIC_BASE_URL")
        .or_else(|_| env::var("VIDEO_CLIP_PUBLIC_BASE_URL"))
        .unwrap_or_default();
    let mut cache_dir = env::var("CLIP_CACHE_DIR").unwrap_or_else(|_| DEFAULT_CACHE_DIR.into());
    let mut profile = DEFAULT_PROFILE.to_string();
    let mut timeout_seconds = DEFAULT_TIMEOUT_SECONDS;
    let mut json_report = None;
    let mut index = 0;

    while index < args.len() {
        match args[index].as_str() {
            "--run-id" => {
                run_id = Some(value_after(args, index, "--run-id")?);
                index += 2;
            }
            "--out" => {
                out = Some(PathBuf::from(value_after(args, index, "--out")?));
                index += 2;
            }
            "--clipper-base-url" => {
                clipper_base_url = value_after(args, index, "--clipper-base-url")?;
                index += 2;
            }
            "--public-base-url" => {
                public_base_url = value_after(args, index, "--public-base-url")?;
                index += 2;
            }
            "--cache-dir" => {
                cache_dir = value_after(args, index, "--cache-dir")?;
                index += 2;
            }
            "--encoding-profile-version" => {
                profile = value_after(args, index, "--encoding-profile-version")?;
                index += 2;
            }
            "--timeout-seconds" => {
                timeout_seconds = value_after(args, index, "--timeout-seconds")?
                    .parse()
                    .map_err(|_| "--timeout-seconds 는 정수여야 함".to_string())?;
                index += 2;
            }
            "--json-report" => {
                json_report = Some(PathBuf::from(value_after(args, index, "--json-report")?));
                index += 2;
            }
            "--help" | "-h" => return Ok(None),
            unknown => return Err(format!("알 수 없는 옵션: {unknown}")),
        }
    }

    let run_id = run_id.ok_or_else(|| "--run-id 가 필요함".to_string())?;
    let out = out.ok_or_else(|| "--out 이 필요함".to_string())?;
    if public_base_url.is_empty() {
        return Err("--public-base-url 이 필요함".to_string());
    }

    Ok(Some(CliOptions {
        build: ClipBundleOptions {
            run_id,
            clipper_base_url,
            public_base_url,
            cache_dir: PathBuf::from(cache_dir),
            encoding_profile_version: profile,
            build_token: token,
            request_timeout: Duration::from_secs(timeout_seconds),
        },
        out,
        json_report,
    }))
}

fn print_help() {
    println!(
        "시드 실행 하나의 클립을 만들게 하고 load_clip_assets 번들을 낸다.\n\n\
         사용법:\n  \
         build_clip_bundle --run-id <uuid> --out <bundle.jsonl> \\\n    \
         [--clipper-base-url {DEFAULT_CLIPPER}] [--public-base-url <url>] \\\n    \
         [--cache-dir {DEFAULT_CACHE_DIR}] [--encoding-profile-version {DEFAULT_PROFILE}] \\\n    \
         [--timeout-seconds {DEFAULT_TIMEOUT_SECONDS}] [--json-report <path>]\n\n\
         빌드 토큰은 VIDEO_CLIP_BUILD_TOKEN 또는 CLIP_BUILD_TOKEN 환경변수로 받는다.\n\
         클립은 한 번에 하나씩 만든다 — 파드 메모리가 640Mi 라 둘을 동시에 받으면 죽는다."
    );
}

fn write_text(path: &PathBuf, text: &str) -> Result<(), String> {
    fs::write(path, text).map_err(|error| format!("{} 에 쓸 수 없음 ({error})", path.display()))
}

fn emit_error(code: &str, message: String, exit_code: i32, json_report: Option<&PathBuf>) -> ! {
    let report = ErrorReport {
        status: "error",
        exit_code,
        error: ErrorDetails { code, message },
    };
    let json = serde_json::to_string_pretty(&report)
        .unwrap_or_else(|_| "{\"status\":\"error\"}".to_string());
    if let Some(path) = json_report {
        let _ = write_text(path, &format!("{json}\n"));
    }
    eprintln!("{json}");
    process::exit(exit_code);
}

#[tokio::main]
async fn main() {
    let args = env::args().skip(1).collect::<Vec<_>>();
    let wants_help = args.iter().any(|arg| arg == "--help" || arg == "-h");
    if wants_help || args.is_empty() {
        print_help();
        return;
    }

    let token = match build_token() {
        Ok(token) => token,
        Err(error) => emit_error("MISSING_BUILD_TOKEN", error, 2, None),
    };
    let options = match parse_args(&args, token) {
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

    let (rows, report) = match build_clip_bundle(&pool, &options.build).await {
        Ok(result) => result,
        Err(error) => {
            let exit_code = match error {
                ClipBundleError::Database(_) => 3,
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

    let mut bundle = String::new();
    for row in &rows {
        match serde_json::to_string(row) {
            Ok(line) => {
                bundle.push_str(&line);
                bundle.push('\n');
            }
            Err(error) => emit_error(
                "BUNDLE_SERIALIZATION_ERROR",
                format!("번들을 직렬화할 수 없음: {error}"),
                3,
                options.json_report.as_ref(),
            ),
        }
    }
    if let Err(error) = write_text(&options.out, &bundle) {
        emit_error("BUNDLE_WRITE_ERROR", error, 3, options.json_report.as_ref());
    }

    let json = serde_json::to_string_pretty(&report)
        .unwrap_or_else(|_| "{\"status\":\"error\"}".to_string());
    if let Some(path) = options.json_report.as_ref() {
        if let Err(error) = write_text(path, &format!("{json}\n")) {
            emit_error("REPORT_WRITE_ERROR", error, 3, None);
        }
    }
    println!("{json}");

    // 한 건이라도 실패하면 뒤 단계를 돌리지 않는다. 절반만 발행되는 것이 가장 나쁘다.
    if !report.failed.is_empty() {
        process::exit(5);
    }
}

#[cfg(test)]
mod tests {
    use super::parse_args;

    fn token() -> String {
        "token".to_string()
    }

    #[test]
    fn run_id_and_out_are_required() {
        assert!(parse_args(&["--run-id".to_string(), "x".to_string()], token()).is_err());
        assert!(parse_args(&["--out".to_string(), "b.jsonl".to_string()], token()).is_err());
    }

    #[test]
    fn defaults_are_applied() {
        let args = vec![
            "--run-id".to_string(),
            "run".to_string(),
            "--out".to_string(),
            "bundle.jsonl".to_string(),
            "--public-base-url".to_string(),
            "https://example.test/clips".to_string(),
        ];
        let options = parse_args(&args, token())
            .expect("옵션 parse")
            .expect("실행");
        assert_eq!(options.build.encoding_profile_version, "v1-copy");
        assert_eq!(options.build.request_timeout.as_secs(), 600);
        assert_eq!(options.build.build_token, "token");
    }

    #[test]
    fn unknown_option_is_rejected() {
        assert!(parse_args(&["--unknown".to_string()], token()).is_err());
    }
}
