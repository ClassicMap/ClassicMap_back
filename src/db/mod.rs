use sqlx::{migrate::Migrator, MySql, Pool};
use std::env;

pub type DbPool = Pool<MySql>;
pub static MIGRATOR: Migrator = sqlx::migrate!("./migrations");

const DEFAULT_URL: &str = "mysql://root:password@localhost:3306/classicmap";

/// 비밀번호와 사용자 이름은 URL 의 userinfo 자리에 들어가므로 예약 문자를 그대로
/// 두면 주소가 깨진다. unreserved 문자만 남기고 나머지를 퍼센트 인코딩한다
/// (RFC 3986 2.3).
fn encode_userinfo(value: &str) -> String {
    let mut encoded = String::with_capacity(value.len());
    for byte in value.bytes() {
        match byte {
            b'A'..=b'Z' | b'a'..=b'z' | b'0'..=b'9' | b'-' | b'.' | b'_' | b'~' => {
                encoded.push(byte as char)
            }
            _ => encoded.push_str(&format!("%{byte:02X}")),
        }
    }
    encoded
}

/// `DATABASE_URL` 이 없을 때 부품으로 주소를 짓는다.
///
/// 클러스터 안에서 도는 시드 Job 이 이 길을 쓴다. `secret/classicmap-back` 의
/// `DATABASE_URL` 은 호스트가 `classicmap_mysql` 로 적혀 있어 해소되지 않는다
/// (서비스 이름은 `classicmap-mysql` 이다). 그래서 Job 에는 그 값을 주지 않고
/// 부품만 준다.
fn url_from_parts() -> Option<String> {
    let host = env::var("MYSQL_HOST").ok()?;
    let password = env::var("MYSQL_PASSWORD").ok()?;
    let user = env::var("MYSQL_USER").unwrap_or_else(|_| "root".to_string());
    let port = env::var("MYSQL_PORT").unwrap_or_else(|_| "3306".to_string());
    let database = env::var("MYSQL_DATABASE").unwrap_or_else(|_| "classicmap".to_string());
    Some(format!(
        "mysql://{}:{}@{host}:{port}/{database}",
        encode_userinfo(&user),
        encode_userinfo(&password)
    ))
}

pub fn database_url() -> String {
    env::var("DATABASE_URL")
        .ok()
        .filter(|url| !url.trim().is_empty())
        .or_else(url_from_parts)
        .unwrap_or_else(|| DEFAULT_URL.to_string())
}

pub async fn connect_pool() -> Result<DbPool, sqlx::Error> {
    Pool::connect(&database_url()).await
}

pub async fn create_pool() -> Result<DbPool, sqlx::Error> {
    let pool = connect_pool().await?;
    MIGRATOR.run(&pool).await?;

    Ok(pool)
}

#[cfg(test)]
mod tests {
    use super::encode_userinfo;

    #[test]
    fn unreserved_characters_pass_through() {
        assert_eq!(encode_userinfo("aZ09-._~"), "aZ09-._~");
    }

    #[test]
    fn reserved_characters_are_percent_encoded() {
        assert_eq!(encode_userinfo("p@ss:w/rd?"), "p%40ss%3Aw%2Frd%3F");
    }

    #[test]
    fn multibyte_is_encoded_per_byte() {
        assert_eq!(encode_userinfo("가"), "%EA%B0%80");
    }
}
