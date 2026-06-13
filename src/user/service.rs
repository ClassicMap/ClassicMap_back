use super::model::{
    AutoCollection, ClerkDeleteWebhookEvent, ClerkWebhookEvent, CreateUser, FavoriteArtistItem,
    FavoriteComposerItem, FavoriteConcertItem, FavoriteGroups, FavoritePieceItem, ProfileHeader,
    ProfileSummary, ProfileVisibility, PublicProfileResponse, RatedConcertListItem,
    UpdateProfileVisibility, UpdateUser, User, UserPublicProfile,
};
use super::repository::UserRepository;
use crate::db::DbPool;
use crate::logger::Logger;
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

    fn validate_positive_id(id: i32, label: &str) -> Result<(), String> {
        if id <= 0 {
            return Err(format!("{} must be positive", label));
        }

        Ok(())
    }

    pub async fn get_my_ratings(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<RatedConcertListItem>, String> {
        UserRepository::find_ratings(pool, user_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_favorite_concerts(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoriteConcertItem>, String> {
        UserRepository::find_favorite_concerts(pool, user_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn add_favorite_concert(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(concert_id, "concert_id")?;
        UserRepository::add_favorite_concert(pool, user_id, concert_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_favorite_concert(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(concert_id, "concert_id")?;
        UserRepository::delete_favorite_concert(pool, user_id, concert_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_favorite_artists(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoriteArtistItem>, String> {
        UserRepository::find_favorite_artists(pool, user_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn add_favorite_artist(
        pool: &DbPool,
        user_id: i32,
        artist_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(artist_id, "artist_id")?;
        UserRepository::add_favorite_artist(pool, user_id, artist_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_favorite_artist(
        pool: &DbPool,
        user_id: i32,
        artist_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(artist_id, "artist_id")?;
        UserRepository::delete_favorite_artist(pool, user_id, artist_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_favorite_composers(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoriteComposerItem>, String> {
        UserRepository::find_favorite_composers(pool, user_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn add_favorite_composer(
        pool: &DbPool,
        user_id: i32,
        composer_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(composer_id, "composer_id")?;
        UserRepository::add_favorite_composer(pool, user_id, composer_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_favorite_composer(
        pool: &DbPool,
        user_id: i32,
        composer_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(composer_id, "composer_id")?;
        UserRepository::delete_favorite_composer(pool, user_id, composer_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_favorite_pieces(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoritePieceItem>, String> {
        UserRepository::find_favorite_pieces(pool, user_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn add_favorite_piece(
        pool: &DbPool,
        user_id: i32,
        piece_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(piece_id, "piece_id")?;
        UserRepository::add_favorite_piece(pool, user_id, piece_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_favorite_piece(
        pool: &DbPool,
        user_id: i32,
        piece_id: i32,
    ) -> Result<u64, String> {
        Self::validate_positive_id(piece_id, "piece_id")?;
        UserRepository::delete_favorite_piece(pool, user_id, piece_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_profile_visibility(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<UserPublicProfile, String> {
        UserRepository::ensure_public_profile(pool, user_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_profile_visibility(
        pool: &DbPool,
        user_id: i32,
        profile: UpdateProfileVisibility,
    ) -> Result<UserPublicProfile, String> {
        UserRepository::update_public_profile(pool, user_id, profile)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_public_profile(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Option<PublicProfileResponse>, String> {
        if UserRepository::find_by_id(pool, user_id)
            .await
            .map_err(|e| e.to_string())?
            .is_none()
        {
            return Ok(None);
        }

        let profile = UserRepository::ensure_public_profile(pool, user_id)
            .await
            .map_err(|e| e.to_string())?;
        let ratings = UserRepository::find_ratings(pool, user_id)
            .await
            .map_err(|e| e.to_string())?;
        let favorites = UserRepository::find_favorites(pool, user_id)
            .await
            .map_err(|e| e.to_string())?;
        let collections = Self::build_auto_collections(&ratings, &favorites);
        let summary = Self::build_profile_summary(&ratings, &favorites, &collections);

        Ok(Some(Self::build_public_profile_response(
            profile.header(),
            profile.visibility(),
            summary,
            ratings,
            favorites,
            collections,
        )))
    }

    pub fn build_auto_collections(
        ratings: &[RatedConcertListItem],
        favorites: &FavoriteGroups,
    ) -> Vec<AutoCollection> {
        vec![
            AutoCollection {
                id: "five-star-concerts".to_string(),
                title: "별점 5점 공연".to_string(),
                count: ratings
                    .iter()
                    .filter(|rating| (rating.my_rating - 5.0).abs() < f64::EPSILON)
                    .count() as i64,
            },
            AutoCollection {
                id: "recent-ratings".to_string(),
                title: "최근 평가".to_string(),
                count: ratings.len() as i64,
            },
            AutoCollection {
                id: "wanted-concerts".to_string(),
                title: "보고싶은 공연".to_string(),
                count: favorites.concerts.len() as i64,
            },
            AutoCollection {
                id: "favorite-artists".to_string(),
                title: "좋아하는 아티스트".to_string(),
                count: favorites.artists.len() as i64,
            },
        ]
    }

    pub fn build_profile_summary(
        ratings: &[RatedConcertListItem],
        favorites: &FavoriteGroups,
        collections: &[AutoCollection],
    ) -> ProfileSummary {
        let ratings_count = ratings.len() as i64;
        let average_rating = if ratings.is_empty() {
            0.0
        } else {
            let sum: f64 = ratings.iter().map(|rating| rating.my_rating).sum();
            (sum / ratings.len() as f64 * 10.0).round() / 10.0
        };
        let collections_count = collections
            .iter()
            .filter(|collection| collection.count > 0)
            .count() as i64;

        ProfileSummary {
            ratings_count,
            average_rating,
            favorites_count: favorites.total_count(),
            collections_count,
        }
    }

    pub fn build_public_profile_response(
        header: ProfileHeader,
        visibility: ProfileVisibility,
        summary: ProfileSummary,
        ratings: Vec<RatedConcertListItem>,
        favorites: FavoriteGroups,
        collections: Vec<AutoCollection>,
    ) -> PublicProfileResponse {
        PublicProfileResponse {
            user_id: header.user_id,
            display_name: header.display_name,
            bio: header.bio,
            avatar_url: header.avatar_url,
            summary: visibility.summary_public.then_some(summary),
            ratings: visibility.ratings_public.then_some(ratings),
            favorites: visibility.favorites_public.then_some(favorites),
            collections: visibility.collections_public.then_some(collections),
            visibility,
        }
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

#[cfg(test)]
mod tests {
    use super::UserService;
    use crate::user::model::{
        AutoCollection, FavoriteGroups, ProfileHeader, ProfileSummary, ProfileVisibility,
        PublicProfileResponse, RatedConcertListItem,
    };

    fn sample_public_profile() -> PublicProfileResponse {
        UserService::build_public_profile_response(
            ProfileHeader {
                user_id: 7,
                display_name: Some("테스트 유저".to_string()),
                bio: Some("공연 기록 중".to_string()),
                avatar_url: None,
            },
            ProfileVisibility::default(),
            ProfileSummary {
                ratings_count: 2,
                average_rating: 4.25,
                favorites_count: 3,
                collections_count: 1,
            },
            vec![RatedConcertListItem {
                concert_id: 11,
                title: "브람스 리사이틀".to_string(),
                poster_url: None,
                start_date: "2026-06-13".to_string(),
                facility_name: Some("예술의전당".to_string()),
                my_rating: 5.0,
                rated_at: "2026-06-13 09:30:00".to_string(),
            }],
            FavoriteGroups::default(),
            vec![AutoCollection {
                id: "five-star".to_string(),
                title: "별점 5점 공연".to_string(),
                count: 1,
            }],
        )
    }

    #[test]
    fn default_public_profile_only_exposes_summary() {
        let response = sample_public_profile();

        assert_eq!(response.user_id, 7);
        assert!(response.summary.is_some());
        assert!(response.ratings.is_none());
        assert!(response.favorites.is_none());
        assert!(response.collections.is_none());
    }
}
