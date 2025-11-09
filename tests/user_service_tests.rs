use std::sync::atomic::{AtomicU32, Ordering};
use ClassicMap_back::db::DbPool;
use ClassicMap_back::user::model::{CreateUser, UpdateUser};
use ClassicMap_back::user::service::UserService;

static TEST_COUNTER: AtomicU32 = AtomicU32::new(0);

fn unique_email(prefix: &str) -> String {
    let id = TEST_COUNTER.fetch_add(1, Ordering::SeqCst);
    let timestamp = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis();
    format!("{}_{}_{}@test.com", prefix, id, timestamp)
}

fn unique_clerk_id(prefix: &str) -> String {
    let id = TEST_COUNTER.fetch_add(1, Ordering::SeqCst);
    let timestamp = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis();
    format!("{}_{}_{}", prefix, id, timestamp)
}

async fn setup_test_pool() -> DbPool {
    dotenv::dotenv().ok();
    let database_url = std::env::var("DATABASE_URL")
        .unwrap_or_else(|_| "mysql://root:password@localhost:3306/classicmap_test".to_string());

    sqlx::mysql::MySqlPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Failed to create test pool")
}

#[tokio::test]
async fn test_create_user_success() {
    let pool = setup_test_pool().await;

    let new_user = CreateUser {
        clerk_id: unique_clerk_id("service_create"),
        email: unique_email("service_create"),
        first_name: Some("Test".to_string()),
        last_name: Some("User".to_string()),
        favorite_era: Some("바로크".to_string()),
    };

    let result = UserService::create_user(&pool, new_user).await;
    assert!(result.is_ok());
    let user_id = result.unwrap();
    assert!(user_id > 0);

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_create_user_duplicate_email() {
    let pool = setup_test_pool().await;

    let email = unique_email("duplicate");
    let new_user = CreateUser {
        clerk_id: unique_clerk_id("dup1"),
        email: email.clone(),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let duplicate_user = CreateUser {
        clerk_id: unique_clerk_id("dup2"),
        email,
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let result = UserService::create_user(&pool, duplicate_user).await;
    assert!(result.is_err());
    assert_eq!(result.unwrap_err(), "Email already exists");

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_create_user_duplicate_clerk_id() {
    let pool = setup_test_pool().await;

    let clerk_id = unique_clerk_id("duplicate_clerk");
    let new_user = CreateUser {
        clerk_id: clerk_id.clone(),
        email: unique_email("clerk1"),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let duplicate_user = CreateUser {
        clerk_id,
        email: unique_email("clerk2"),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let result = UserService::create_user(&pool, duplicate_user).await;
    assert!(result.is_err());
    assert_eq!(result.unwrap_err(), "Clerk ID already exists");

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_get_user_by_id() {
    let pool = setup_test_pool().await;

    let new_user = CreateUser {
        clerk_id: unique_clerk_id("get_id"),
        email: unique_email("get_id"),
        first_name: Some("John".to_string()),
        last_name: Some("Doe".to_string()),
        favorite_era: Some("낭만주의".to_string()),
    };

    let email_clone = new_user.email.clone();
    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let result = UserService::get_user_by_id(&pool, user_id).await;
    assert!(result.is_ok());

    let user = result.unwrap();
    assert!(user.is_some());

    let user = user.unwrap();
    assert_eq!(user.id, user_id);
    assert_eq!(user.email, email_clone);
    assert_eq!(user.first_name.unwrap(), "John");

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_get_user_by_id_not_found() {
    let pool = setup_test_pool().await;

    let result = UserService::get_user_by_id(&pool, 999999).await;
    assert!(result.is_ok());
    assert!(result.unwrap().is_none());
}

#[tokio::test]
async fn test_get_user_by_clerk_id() {
    let pool = setup_test_pool().await;

    let clerk_id = unique_clerk_id("get_clerk");
    let new_user = CreateUser {
        clerk_id: clerk_id.clone(),
        email: unique_email("get_clerk"),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let result = UserService::get_user_by_clerk_id(&pool, &clerk_id).await;
    assert!(result.is_ok());

    let user = result.unwrap();
    assert!(user.is_some());
    assert_eq!(user.unwrap().clerk_id, clerk_id);

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_get_user_by_email() {
    let pool = setup_test_pool().await;

    let email = unique_email("get_email");
    let new_user = CreateUser {
        clerk_id: unique_clerk_id("get_email"),
        email: email.clone(),
        first_name: Some("Jane".to_string()),
        last_name: Some("Smith".to_string()),
        favorite_era: Some("고전주의".to_string()),
    };

    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let result = UserService::get_user_by_email(&pool, &email).await;
    assert!(result.is_ok());

    let user = result.unwrap();
    assert!(user.is_some());

    let user = user.unwrap();
    assert_eq!(user.email, email);
    assert_eq!(user.first_name.unwrap(), "Jane");

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_get_all_users() {
    let pool = setup_test_pool().await;

    let user1 = CreateUser {
        clerk_id: unique_clerk_id("all_1"),
        email: unique_email("all_1"),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let user2 = CreateUser {
        clerk_id: unique_clerk_id("all_2"),
        email: unique_email("all_2"),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let user_id1 = UserService::create_user(&pool, user1).await.unwrap();
    let user_id2 = UserService::create_user(&pool, user2).await.unwrap();

    let result = UserService::get_all_users(&pool).await;
    assert!(result.is_ok());
    assert!(result.unwrap().len() >= 2);

    UserService::delete_user(&pool, user_id1).await.ok();
    UserService::delete_user(&pool, user_id2).await.ok();
}

#[tokio::test]
async fn test_update_user_success() {
    let pool = setup_test_pool().await;

    let new_user = CreateUser {
        clerk_id: unique_clerk_id("update"),
        email: unique_email("update"),
        first_name: Some("Old".to_string()),
        last_name: Some("Name".to_string()),
        favorite_era: None,
    };

    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let update_data = UpdateUser {
        first_name: Some("New".to_string()),
        last_name: Some("Updated".to_string()),
        favorite_era: Some("현대음악".to_string()),
    };

    let result = UserService::update_user(&pool, user_id, update_data).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);

    let updated_user = UserService::get_user_by_id(&pool, user_id)
        .await
        .unwrap()
        .unwrap();
    assert_eq!(updated_user.first_name.unwrap(), "New");
    assert_eq!(updated_user.last_name.unwrap(), "Updated");
    assert_eq!(updated_user.favorite_era.unwrap(), "현대음악");

    UserService::delete_user(&pool, user_id).await.ok();
}

#[tokio::test]
async fn test_update_user_not_found() {
    let pool = setup_test_pool().await;

    let update_data = UpdateUser {
        first_name: Some("Test".to_string()),
        last_name: Some("User".to_string()),
        favorite_era: None,
    };

    let result = UserService::update_user(&pool, 999999, update_data).await;
    assert!(result.is_err());
    assert_eq!(result.unwrap_err(), "User not found");
}

#[tokio::test]
async fn test_delete_user() {
    let pool = setup_test_pool().await;

    let new_user = CreateUser {
        clerk_id: unique_clerk_id("delete"),
        email: unique_email("delete"),
        first_name: None,
        last_name: None,
        favorite_era: None,
    };

    let user_id = UserService::create_user(&pool, new_user).await.unwrap();

    let result = UserService::delete_user(&pool, user_id).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);

    let deleted_user = UserService::get_user_by_id(&pool, user_id).await.unwrap();
    assert!(deleted_user.is_none());
}

#[tokio::test]
async fn test_delete_user_not_exists() {
    let pool = setup_test_pool().await;

    let result = UserService::delete_user(&pool, 999999).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 0);
}
