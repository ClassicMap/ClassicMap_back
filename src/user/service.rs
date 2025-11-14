use super::model::{ClerkWebhookEvent, CreateUser, UpdateUser, User};
use super::repository::UserRepository;
use crate::db::DbPool;
use crate::logger::Logger;
use crate::user::model::ClerkDeleteWebhookEvent;
use std::env;

pub struct UserService;

impl UserService {
    fn get_user_role(email: &str) -> String {
        let admin_emails_str = env::var("ADMIN_EMAILS").unwrap_or_default();
        let admin_emails: Vec<&str> = admin_emails_str.split(',').map(|s| s.trim()).collect();

        let moderator_emails_str = env::var("MODERATOR_EMAILS").unwrap_or_default();
        let moderator_emails: Vec<&str> =
            moderator_emails_str.split(',').map(|s| s.trim()).collect();

        if admin_emails.contains(&email) {
            Logger::info("USER", &format!("Admin account detected: {}", email));
            "admin".to_string()
        } else if moderator_emails.contains(&email) {
            Logger::info("USER", &format!("Moderator account detected: {}", email));
            "moderator".to_string()
        } else {
            "user".to_string()
        }
    }

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
        Logger::webhook(&event.r#type, format!("clerk_id: {}", event.data.id));

        match event.r#type.as_str() {
            "user.created" => {
                Logger::info("WEBHOOK", "Processing user.created event");

                // 중복 가입 방지
                if let Ok(res) =
                    UserRepository::find_by_clerk_id(pool, event.data.id.as_str()).await
                {
                    if res.is_some() {
                        Logger::warn(
                            "WEBHOOK",
                            &format!("User already exists: {}", event.data.id),
                        );
                        return Err("User Exist".into());
                    }
                }

                // 한 사용자가 여러 email을 소유할 수 있음으로 primary_email_address_id를
                // 우선적으로 사용
                let email = match event
                    .data
                    .email_addresses
                    .iter()
                    .find(|e| Some(e.id.clone()) == event.data.primary_email_address_id)
                    .or_else(|| event.data.email_addresses.first())
                {
                    Some(email) => {
                        Logger::debug("WEBHOOK", &format!("Email: {}", email.email_address));
                        email.email_address.clone()
                    }
                    None => {
                        Logger::warn("WEBHOOK", "No email found, using placeholder");
                        "None".to_string()
                    }
                };

                let role = Self::get_user_role(&email);

                let create_user = CreateUser {
                    clerk_id: event.data.id.clone(),
                    email,
                    role: Some(role),
                    favorite_era: None,
                };

                match UserRepository::create(pool, create_user).await {
                    Ok(user_id) => {
                        Logger::success("WEBHOOK", &format!("User created with ID: {}", user_id));
                        Logger::db("INSERT", &format!("users (clerk_id: {})", event.data.id));
                        Ok(())
                    }
                    Err(e) => {
                        Logger::error("WEBHOOK", &format!("Failed to create user: {}", e));
                        Err(e.to_string())
                    }
                }
            }
            "user.updated" => {
                Logger::info("WEBHOOK", "Processing user.updated event");

                // 유저 존재 확인
                let existing_user =
                    match UserRepository::find_by_clerk_id(pool, &event.data.id).await {
                        Ok(Some(user)) => user,
                        Ok(None) => {
                            Logger::error("WEBHOOK", &format!("User not found: {}", event.data.id));
                            return Err("User not found".into());
                        }
                        Err(e) => {
                            Logger::error("WEBHOOK", &format!("Failed to find user: {}", e));
                            return Err(e.to_string());
                        }
                    };

                let update_user = UpdateUser {
                    is_first_visit: None,
                    favorite_era: None,
                };

                match UserRepository::update(pool, existing_user.id, update_user).await {
                    Ok(rows) => {
                        Logger::success("WEBHOOK", &format!("User updated (rows: {})", rows));
                        Logger::db("UPDATE", &format!("users (clerk_id: {})", event.data.id));
                        Ok(())
                    }
                    Err(e) => {
                        Logger::error("WEBHOOK", &format!("Failed to update user: {}", e));
                        Err(e.to_string())
                    }
                }
            }
            _ => {
                Logger::warn(
                    "WEBHOOK",
                    &format!("Unhandled event type: {}", event.r#type),
                );
                Ok(())
            }
        }
    }

    pub async fn handle_clerk_delete_webhook(
        pool: &DbPool,
        event: ClerkDeleteWebhookEvent,
    ) -> Result<(), String> {
        Logger::webhook(
            &event.r#type,
            format!(
                "clerk_id: {}, deleted: {}",
                event.data.id, event.data.deleted
            ),
        );
        Logger::info("WEBHOOK", "Processing user.deleted event");

        // 유저 존재 확인
        let existing_user = match UserRepository::find_by_clerk_id(pool, &event.data.id).await {
            Ok(Some(user)) => user,
            Ok(None) => {
                Logger::error(
                    "WEBHOOK",
                    &format!("User not found for deletion: {}", event.data.id),
                );
                return Err("User not found".into());
            }
            Err(e) => {
                Logger::error("WEBHOOK", &format!("Failed to find user: {}", e));
                return Err(e.to_string());
            }
        };

        match UserRepository::delete(pool, existing_user.id).await {
            Ok(rows) => {
                Logger::success("WEBHOOK", &format!("User deleted (rows: {})", rows));
                Logger::db("DELETE", &format!("users (clerk_id: {})", event.data.id));
                Ok(())
            }
            Err(e) => {
                Logger::error("WEBHOOK", &format!("Failed to delete user: {}", e));
                Err(e.to_string())
            }
        }
    }
}
