use super::model::{CreateUser, UpdateUser, User};
use crate::db::DbPool;
use sqlx::Error;

pub struct UserRepository;

impl UserRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<User>, Error> {
        sqlx::query_as::<_, User>("SELECT * FROM users")
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<User>, Error> {
        sqlx::query_as::<_, User>("SELECT * FROM users WHERE id = ?")
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn find_by_clerk_id(pool: &DbPool, clerk_id: &str) -> Result<Option<User>, Error> {
        sqlx::query_as::<_, User>("SELECT * FROM users WHERE clerk_id = ?")
            .bind(clerk_id)
            .fetch_optional(pool)
            .await
    }

    pub async fn find_by_email(pool: &DbPool, email: &str) -> Result<Option<User>, Error> {
        sqlx::query_as::<_, User>("SELECT * FROM users WHERE email = ?")
            .bind(email)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &DbPool, user: CreateUser) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO users (clerk_id, email, favorite_era) 
             VALUES (?, ?, ?, ?, ?)",
        )
        .bind(&user.clerk_id)
        .bind(&user.email)
        .bind(&user.favorite_era)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, user: UpdateUser) -> Result<u64, Error> {
        let result = sqlx::query("UPDATE users SET favorite_era = ? WHERE id = ?")
            .bind(&user.favorite_era)
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM users WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
