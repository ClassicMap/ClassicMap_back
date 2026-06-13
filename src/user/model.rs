use serde::{Deserialize, Serialize};
use sqlx::FromRow;

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct User {
    pub id: i32,
    pub clerk_id: String,
    pub email: String,
    pub role: String,
    pub is_first_visit: bool,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreateUser {
    pub clerk_id: String,
    pub email: String,
    pub role: Option<String>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateUser {
    pub is_first_visit: Option<bool>,
    pub favorite_era: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ProfileHeader {
    pub user_id: i32,
    pub display_name: Option<String>,
    pub bio: Option<String>,
    pub avatar_url: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct ProfileVisibility {
    pub summary_public: bool,
    pub ratings_public: bool,
    pub favorites_public: bool,
    pub collections_public: bool,
}

impl Default for ProfileVisibility {
    fn default() -> Self {
        Self {
            summary_public: true,
            ratings_public: false,
            favorites_public: false,
            collections_public: false,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct UserPublicProfile {
    pub user_id: i32,
    pub display_name: Option<String>,
    pub bio: Option<String>,
    pub avatar_url: Option<String>,
    pub summary_public: bool,
    pub ratings_public: bool,
    pub favorites_public: bool,
    pub collections_public: bool,
}

impl UserPublicProfile {
    pub fn header(&self) -> ProfileHeader {
        ProfileHeader {
            user_id: self.user_id,
            display_name: self.display_name.clone(),
            bio: self.bio.clone(),
            avatar_url: self.avatar_url.clone(),
        }
    }

    pub fn visibility(&self) -> ProfileVisibility {
        ProfileVisibility {
            summary_public: self.summary_public,
            ratings_public: self.ratings_public,
            favorites_public: self.favorites_public,
            collections_public: self.collections_public,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdateProfileVisibility {
    pub display_name: Option<String>,
    pub bio: Option<String>,
    pub avatar_url: Option<String>,
    pub summary_public: Option<bool>,
    pub ratings_public: Option<bool>,
    pub favorites_public: Option<bool>,
    pub collections_public: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct RatedConcertListItem {
    pub concert_id: i32,
    pub title: String,
    pub poster_url: Option<String>,
    pub start_date: String,
    pub facility_name: Option<String>,
    pub my_rating: f64,
    pub rated_at: String,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteConcertItem {
    pub concert_id: i32,
    pub title: String,
    pub poster_url: Option<String>,
    pub start_date: String,
    pub facility_name: Option<String>,
    pub created_at: String,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteArtistItem {
    pub artist_id: i32,
    pub name: String,
    pub english_name: String,
    pub category: String,
    pub image_url: Option<String>,
    pub created_at: String,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteComposerItem {
    pub composer_id: i32,
    pub name: String,
    pub full_name: String,
    pub english_name: String,
    pub period: String,
    pub avatar_url: Option<String>,
    pub created_at: String,
}

#[derive(Debug, Clone, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct FavoritePieceItem {
    pub piece_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    pub composer_id: i32,
    pub composer_name: String,
    pub created_at: String,
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteGroups {
    pub concerts: Vec<FavoriteConcertItem>,
    pub artists: Vec<FavoriteArtistItem>,
    pub composers: Vec<FavoriteComposerItem>,
    pub pieces: Vec<FavoritePieceItem>,
}

impl FavoriteGroups {
    pub fn total_count(&self) -> i64 {
        (self.concerts.len() + self.artists.len() + self.composers.len() + self.pieces.len()) as i64
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct ProfileSummary {
    pub ratings_count: i64,
    pub average_rating: f64,
    pub favorites_count: i64,
    pub collections_count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AutoCollection {
    pub id: String,
    pub title: String,
    pub count: i64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct PublicProfileResponse {
    pub user_id: i32,
    pub display_name: Option<String>,
    pub bio: Option<String>,
    pub avatar_url: Option<String>,
    pub visibility: ProfileVisibility,
    pub summary: Option<ProfileSummary>,
    pub ratings: Option<Vec<RatedConcertListItem>>,
    pub favorites: Option<FavoriteGroups>,
    pub collections: Option<Vec<AutoCollection>>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteConcertRequest {
    pub concert_id: i32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteArtistRequest {
    pub artist_id: i32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FavoriteComposerRequest {
    pub composer_id: i32,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct FavoritePieceRequest {
    pub piece_id: i32,
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
