use colored::Colorize;
use std::fmt;
use tracing::{info, warn, error, debug};

pub struct Logger;

impl Logger {
    pub fn init() {
        tracing_subscriber::fmt()
            .with_target(false)
            .with_thread_ids(false)
            .with_level(true)
            .with_ansi(true)
            .init();
    }

    pub fn info(module: &str, message: &str) {
        info!("{} {}", 
            format!("[{}]", module).bright_cyan().bold(), 
            message
        );
    }

    pub fn success(module: &str, message: &str) {
        info!("{} {} {}", 
            format!("[{}]", module).bright_cyan().bold(), 
            "✓".green().bold(),
            message.green()
        );
    }

    pub fn warn(module: &str, message: &str) {
        warn!("{} {} {}", 
            format!("[{}]", module).bright_yellow().bold(), 
            "⚠".yellow().bold(),
            message.yellow()
        );
    }

    pub fn error(module: &str, message: &str) {
        error!("{} {} {}", 
            format!("[{}]", module).bright_red().bold(), 
            "✗".red().bold(),
            message.red()
        );
    }

    pub fn debug(module: &str, message: &str) {
        debug!("{} {} {}", 
            format!("[{}]", module).bright_magenta().bold(), 
            "⚙".magenta(),
            message.dimmed()
        );
    }

    pub fn webhook(event_type: &str, data: impl fmt::Display) {
        info!("{} {} {}\n{}", 
            "[WEBHOOK]".bright_purple().bold(),
            "→".bright_purple(),
            event_type.bright_white().bold(),
            format!("  {}", data).dimmed()
        );
    }

    pub fn db(operation: &str, details: &str) {
        info!("{} {} {}", 
            "[DB]".bright_blue().bold(),
            operation.bright_white(),
            details.dimmed()
        );
    }

    pub fn api(method: &str, path: &str, status: u16) {
        let status_colored = match status {
            200..=299 => format!("{}", status).green(),
            400..=499 => format!("{}", status).yellow(),
            500..=599 => format!("{}", status).red(),
            _ => format!("{}", status).white(),
        };

        info!("{} {} {} {}", 
            "[API]".bright_green().bold(),
            method.bright_white().bold(),
            path,
            status_colored
        );
    }
}
