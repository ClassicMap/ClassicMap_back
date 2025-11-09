use crate::db::DbPool;
use super::model::{User, CreateUser, UpdateUser};
use super::repository::UserRepository;

pub struct UserService;

impl UserService {
    pub async fn get_all_users(pool: &DbPool) -> Result<Vec<User>, String> {
        UserRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_user_by_id(pool: &DbPool, id: i32) -> Result<Option<User>, String> {
        UserRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_user_by_clerk_id(pool: &DbPool, clerk_id: &str) -> Result<Option<User>, String> {
        UserRepository::find_by_clerk_id(pool, clerk_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_user_by_email(pool: &DbPool, email: &str) -> Result<Option<User>, String> {
        UserRepository::find_by_email(pool, email)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_user(pool: &DbPool, user: CreateUser) -> Result<i32, String> {
        // 비즈니스 로직: 중복 이메일 체크
        if let Ok(Some(_)) = UserRepository::find_by_email(pool, &user.email).await {
            return Err("Email already exists".to_string());
        }

        // 비즈니스 로직: 중복 clerk_id 체크
        if let Ok(Some(_)) = UserRepository::find_by_clerk_id(pool, &user.clerk_id).await {
            return Err("Clerk ID already exists".to_string());
        }

        UserRepository::create(pool, user)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_user(pool: &DbPool, id: i32, user: UpdateUser) -> Result<u64, String> {
        // 비즈니스 로직: 존재하는 유저인지 확인
        if UserRepository::find_by_id(pool, id).await.map_err(|e| e.to_string())?.is_none() {
            return Err("User not found".to_string());
        }

        UserRepository::update(pool, id, user)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_user(pool: &DbPool, id: i32) -> Result<u64, String> {
        UserRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}
