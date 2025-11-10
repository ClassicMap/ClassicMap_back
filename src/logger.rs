use colored::Colorize;
use std::fmt;

pub struct Logger;

impl Logger {
    pub fn init() {
        // tracing 사용하지 않고 직접 출력
    }

    pub fn info(module: &str, message: &str) {
        println!("{} {}", 
            format!("[{}]", module).bright_cyan().bold(), 
            message
        );
    }

    pub fn success(module: &str, message: &str) {
        println!("{} {} {}", 
            format!("[{}]", module).bright_cyan().bold(), 
            "✓".green().bold(),
            message.green()
        );
    }

    pub fn warn(module: &str, message: &str) {
        eprintln!("{} {} {}", 
            format!("[{}]", module).bright_yellow().bold(), 
            "⚠".yellow().bold(),
            message.yellow()
        );
    }

    pub fn error(module: &str, message: &str) {
        eprintln!("{} {} {}", 
            format!("[{}]", module).bright_red().bold(), 
            "✗".red().bold(),
            message.red()
        );
    }

    pub fn debug(module: &str, message: &str) {
        println!("{} {} {}", 
            format!("[{}]", module).bright_magenta().bold(), 
            "⚙".magenta(),
            message.dimmed()
        );
    }

    pub fn webhook(event_type: &str, data: impl fmt::Display) {
        println!("{} {} {}\n{}", 
            "[WEBHOOK]".bright_purple().bold(),
            "→".bright_purple(),
            event_type.bright_white().bold(),
            format!("  {}", data).dimmed()
        );
    }

    pub fn db(operation: &str, details: &str) {
        println!("{} {} {}", 
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

        println!("{} {} {} {}", 
            "[API]".bright_green().bold(),
            method.bright_white().bold(),
            path,
            status_colored
        );
    }
}
