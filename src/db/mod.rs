use sqlx::{migrate::Migrator, MySql, Pool};
use std::env;

pub type DbPool = Pool<MySql>;
pub static MIGRATOR: Migrator = sqlx::migrate!("./migrations");

pub async fn connect_pool() -> Result<DbPool, sqlx::Error> {
    let database_url = env::var("DATABASE_URL")
        .unwrap_or_else(|_| "mysql://root:password@localhost:3306/classicmap".to_string());

    Pool::connect(&database_url).await
}

pub async fn create_pool() -> Result<DbPool, sqlx::Error> {
    let pool = connect_pool().await?;
    MIGRATOR.run(&pool).await?;

    Ok(pool)
}
