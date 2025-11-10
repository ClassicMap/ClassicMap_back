use chrono::{FixedOffset, Utc};
use colored::Colorize;
use std::fmt;

pub struct Logger;

impl Logger {
    pub fn init() {
        // 환경변수로 Rust/SQLx 로그 끄기
        std::env::set_var("RUST_LOG", "off");
    }

    fn timestamp() -> String {
        let kst = FixedOffset::east_opt(9 * 3600).unwrap();
        Utc::now()
            .with_timezone(&kst)
            .format("%Y-%m-%d %H:%M:%S")
            .to_string()
    }

    pub fn info(module: &str, message: &str) {
        println!(
            "{} {} {}",
            Self::timestamp().dimmed(),
            format!("[{}]", module).bright_cyan().bold(),
            message
        );
    }

    pub fn success(module: &str, message: &str) {
        println!(
            "{} {} {} {}",
            Self::timestamp().dimmed(),
            format!("[{}]", module).bright_cyan().bold(),
            "✓".green().bold(),
            message.green()
        );
    }

    pub fn warn(module: &str, message: &str) {
        eprintln!(
            "{} {} {} {}",
            Self::timestamp().dimmed(),
            format!("[{}]", module).bright_yellow().bold(),
            "⚠".yellow().bold(),
            message.yellow()
        );
    }

    pub fn error(module: &str, message: &str) {
        eprintln!(
            "{} {} {} {}",
            Self::timestamp().dimmed(),
            format!("[{}]", module).bright_red().bold(),
            "✗".red().bold(),
            message.red()
        );
    }

    pub fn debug(module: &str, message: &str) {
        println!(
            "{} {} {} {}",
            Self::timestamp().dimmed(),
            format!("[{}]", module).bright_magenta().bold(),
            "⚙".magenta(),
            message.dimmed()
        );
    }

    pub fn webhook(event_type: &str, data: impl fmt::Display) {
        println!(
            "{} {} {} {}\n{}",
            Self::timestamp().dimmed(),
            "[WEBHOOK]".bright_purple().bold(),
            "→".bright_purple(),
            event_type.bright_white().bold(),
            format!("  {}", data).dimmed()
        );
    }

    pub fn db(operation: &str, details: &str) {
        println!(
            "{} {} {} {}",
            Self::timestamp().dimmed(),
            "[DB]".bright_blue().bold(),
            operation.bright_white(),
            details.dimmed()
        );
    }
}
