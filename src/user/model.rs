use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Serialize, Deserialize, FromRow)]
pub struct User {
    pub id: i32,
    pub clerk_id: String,
    pub email: String,
    pub role: String,
    pub is_first_visit: bool,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct CreateUser {
    pub clerk_id: String,
    pub email: String,
    pub role: Option<String>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct UpdateUser {
    pub is_first_visit: Option<bool>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkWebhookEvent {
    pub data: ClerkUserData,
    pub r#type: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkDeleteWebhookEvent {
    pub data: ClerkDeleteData,
    pub r#type: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkUserData {
    pub id: String,
    pub email_addresses: Vec<ClerkEmailAddress>,
    pub primary_email_address_id: Option<String>,
    pub deleted: Option<bool>,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkDeleteData {
    pub id: String,
    pub deleted: bool,
    pub object: String,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct ClerkEmailAddress {
    pub id: String,
    pub email_address: String,
}
