use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct User {
    pub id: i32,
    pub clerk_id: String,
    pub email: String,
    pub first_name: Option<String>,
    pub last_name: Option<String>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateUser {
    pub clerk_id: String,
    pub email: String,
    pub first_name: Option<String>,
    pub last_name: Option<String>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UpdateUser {
    pub first_name: Option<String>,
    pub last_name: Option<String>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkWebhookEvent {
    pub data: ClerkUserData,
    pub r#type: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkUserData {
    pub id: String,
    pub first_name: Option<String>,
    pub last_name: Option<String>,
    pub email_addresses: Vec<ClerkEmailAddress>,
    pub primary_email_address_id: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkEmailAddress {
    pub id: String,
    pub email_address: String,
}
