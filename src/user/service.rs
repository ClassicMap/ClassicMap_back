use super::model::{ClerkWebhookEvent, CreateUser, UpdateUser, User};
use super::repository::UserRepository;
use crate::db::DbPool;

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

    pub async fn get_user_by_clerk_id(
        pool: &DbPool,
        clerk_id: &str,
    ) -> Result<Option<User>, String> {
        UserRepository::find_by_clerk_id(pool, clerk_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_user_by_email(pool: &DbPool, email: &str) -> Result<Option<User>, String> {
        UserRepository::find_by_email(pool, email)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_user(pool: &DbPool, id: i32, user: UpdateUser) -> Result<u64, String> {
        // 비즈니스 로직: 존재하는 유저인지 확인
        if UserRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())?
            .is_none()
        {
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

    pub async fn handle_clerk_webhook(
        pool: &DbPool,
        event: ClerkWebhookEvent,
    ) -> Result<(), String> {
        match event.r#type.as_str() {
            "user.created" => {
                // 한 사용자가 여러 email을 소유할 수 있음으로 primary_email_address_id를
                // 우선적으로 사용
                let email = match event
                    .data
                    .email_addresses
                    .iter()
                    .find(|e| Some(e.id.clone()) == event.data.primary_email_address_id)
                    .or_else(|| event.data.email_addresses.first())
                {
                    Some(email) => email.email_address.clone(),
                    None => "None".to_string(),
                };

                let create_user = CreateUser {
                    clerk_id: event.data.id,
                    email,
                    favorite_era: None,
                };

                UserRepository::create(pool, create_user)
                    .await
                    .map_err(|e| e.to_string())?;

                Ok(())
            }
            _ => Ok(()),
        }
    }
}
