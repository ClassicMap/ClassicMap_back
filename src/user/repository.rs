use super::model::{
    CreateUser, FavoriteArtistItem, FavoriteComposerItem, FavoriteConcertItem, FavoriteGroups,
    FavoritePieceItem, RatedConcertListItem, UpdateProfileVisibility, UpdateUser, User,
    UserPublicProfile,
};
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
        let role = user.role.as_deref().unwrap_or("user");

        let result = sqlx::query(
            "INSERT INTO users (clerk_id, email, role, favorite_era) 
             VALUES (?, ?, ?, ?)",
        )
        .bind(&user.clerk_id)
        .bind(&user.email)
        .bind(role)
        .bind(&user.favorite_era)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, user: UpdateUser) -> Result<u64, Error> {
        let result = sqlx::query(
            "UPDATE users SET is_first_visit = COALESCE(?, is_first_visit), favorite_era = COALESCE(?, favorite_era) WHERE id = ?",
        )
        .bind(&user.is_first_visit)
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

    pub async fn find_ratings(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<RatedConcertListItem>, Error> {
        sqlx::query_as::<_, RatedConcertListItem>(
            "SELECT
                c.id AS concert_id,
                c.title,
                c.poster_url,
                DATE_FORMAT(c.start_date, '%Y-%m-%d') AS start_date,
                c.facility_name,
                CAST(r.rating AS DOUBLE) AS my_rating,
                DATE_FORMAT(r.updated_at, '%Y-%m-%d %H:%i:%s') AS rated_at
             FROM user_concert_ratings r
             JOIN concerts c ON c.id = r.concert_id
             WHERE r.user_id = ?
             ORDER BY r.updated_at DESC, r.id DESC",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await
    }

    pub async fn find_favorite_concerts(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoriteConcertItem>, Error> {
        sqlx::query_as::<_, FavoriteConcertItem>(
            "SELECT
                c.id AS concert_id,
                c.title,
                c.poster_url,
                DATE_FORMAT(c.start_date, '%Y-%m-%d') AS start_date,
                c.facility_name,
                DATE_FORMAT(f.created_at, '%Y-%m-%d %H:%i:%s') AS created_at
             FROM user_favorite_concerts f
             JOIN concerts c ON c.id = f.concert_id
             WHERE f.user_id = ?
             ORDER BY f.created_at DESC, f.id DESC",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await
    }

    pub async fn add_favorite_concert(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
    ) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO user_favorite_concerts (user_id, concert_id)
             VALUES (?, ?)
             ON DUPLICATE KEY UPDATE user_id = user_id",
        )
        .bind(user_id)
        .bind(concert_id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete_favorite_concert(
        pool: &DbPool,
        user_id: i32,
        concert_id: i32,
    ) -> Result<u64, Error> {
        let result =
            sqlx::query("DELETE FROM user_favorite_concerts WHERE user_id = ? AND concert_id = ?")
                .bind(user_id)
                .bind(concert_id)
                .execute(pool)
                .await?;

        Ok(result.rows_affected())
    }

    pub async fn find_favorite_artists(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoriteArtistItem>, Error> {
        sqlx::query_as::<_, FavoriteArtistItem>(
            "SELECT
                a.id AS artist_id,
                a.name,
                a.english_name,
                a.category,
                a.image_url,
                DATE_FORMAT(f.created_at, '%Y-%m-%d %H:%i:%s') AS created_at
             FROM user_favorite_artists f
             JOIN artists a ON a.id = f.artist_id
             WHERE f.user_id = ?
             ORDER BY f.created_at DESC, f.id DESC",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await
    }

    pub async fn add_favorite_artist(
        pool: &DbPool,
        user_id: i32,
        artist_id: i32,
    ) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO user_favorite_artists (user_id, artist_id)
             VALUES (?, ?)
             ON DUPLICATE KEY UPDATE user_id = user_id",
        )
        .bind(user_id)
        .bind(artist_id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete_favorite_artist(
        pool: &DbPool,
        user_id: i32,
        artist_id: i32,
    ) -> Result<u64, Error> {
        let result =
            sqlx::query("DELETE FROM user_favorite_artists WHERE user_id = ? AND artist_id = ?")
                .bind(user_id)
                .bind(artist_id)
                .execute(pool)
                .await?;

        Ok(result.rows_affected())
    }

    pub async fn find_favorite_composers(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoriteComposerItem>, Error> {
        sqlx::query_as::<_, FavoriteComposerItem>(
            "SELECT
                c.id AS composer_id,
                c.name,
                c.full_name,
                c.english_name,
                c.period,
                c.avatar_url,
                DATE_FORMAT(f.created_at, '%Y-%m-%d %H:%i:%s') AS created_at
             FROM user_favorite_composers f
             JOIN composers c ON c.id = f.composer_id
             WHERE f.user_id = ?
             ORDER BY f.created_at DESC, f.id DESC",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await
    }

    pub async fn add_favorite_composer(
        pool: &DbPool,
        user_id: i32,
        composer_id: i32,
    ) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO user_favorite_composers (user_id, composer_id)
             VALUES (?, ?)
             ON DUPLICATE KEY UPDATE user_id = user_id",
        )
        .bind(user_id)
        .bind(composer_id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete_favorite_composer(
        pool: &DbPool,
        user_id: i32,
        composer_id: i32,
    ) -> Result<u64, Error> {
        let result = sqlx::query(
            "DELETE FROM user_favorite_composers WHERE user_id = ? AND composer_id = ?",
        )
        .bind(user_id)
        .bind(composer_id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn find_favorite_pieces(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Vec<FavoritePieceItem>, Error> {
        sqlx::query_as::<_, FavoritePieceItem>(
            "SELECT
                p.id AS piece_id,
                p.title,
                p.title_en,
                p.composer_id,
                c.name AS composer_name,
                DATE_FORMAT(f.created_at, '%Y-%m-%d %H:%i:%s') AS created_at
             FROM user_favorite_pieces f
             JOIN pieces p ON p.id = f.piece_id
             JOIN composers c ON c.id = p.composer_id
             WHERE f.user_id = ?
             ORDER BY f.created_at DESC, f.id DESC",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await
    }

    pub async fn add_favorite_piece(
        pool: &DbPool,
        user_id: i32,
        piece_id: i32,
    ) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO user_favorite_pieces (user_id, piece_id)
             VALUES (?, ?)
             ON DUPLICATE KEY UPDATE user_id = user_id",
        )
        .bind(user_id)
        .bind(piece_id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete_favorite_piece(
        pool: &DbPool,
        user_id: i32,
        piece_id: i32,
    ) -> Result<u64, Error> {
        let result =
            sqlx::query("DELETE FROM user_favorite_pieces WHERE user_id = ? AND piece_id = ?")
                .bind(user_id)
                .bind(piece_id)
                .execute(pool)
                .await?;

        Ok(result.rows_affected())
    }

    pub async fn find_favorites(pool: &DbPool, user_id: i32) -> Result<FavoriteGroups, Error> {
        Ok(FavoriteGroups {
            concerts: Self::find_favorite_concerts(pool, user_id).await?,
            artists: Self::find_favorite_artists(pool, user_id).await?,
            composers: Self::find_favorite_composers(pool, user_id).await?,
            pieces: Self::find_favorite_pieces(pool, user_id).await?,
        })
    }

    pub async fn ensure_public_profile(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<UserPublicProfile, Error> {
        sqlx::query(
            "INSERT INTO user_public_profiles (user_id)
             VALUES (?)
             ON DUPLICATE KEY UPDATE user_id = user_id",
        )
        .bind(user_id)
        .execute(pool)
        .await?;

        Self::find_public_profile(pool, user_id)
            .await?
            .ok_or(Error::RowNotFound)
    }

    pub async fn find_public_profile(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<Option<UserPublicProfile>, Error> {
        sqlx::query_as::<_, UserPublicProfile>(
            "SELECT
                user_id,
                display_name,
                bio,
                avatar_url,
                summary_public,
                ratings_public,
                favorites_public,
                collections_public
             FROM user_public_profiles
             WHERE user_id = ?",
        )
        .bind(user_id)
        .fetch_optional(pool)
        .await
    }

    pub async fn update_public_profile(
        pool: &DbPool,
        user_id: i32,
        profile: UpdateProfileVisibility,
    ) -> Result<UserPublicProfile, Error> {
        Self::ensure_public_profile(pool, user_id).await?;

        sqlx::query(
            "UPDATE user_public_profiles
             SET display_name = COALESCE(?, display_name),
                 bio = COALESCE(?, bio),
                 avatar_url = COALESCE(?, avatar_url),
                 summary_public = COALESCE(?, summary_public),
                 ratings_public = COALESCE(?, ratings_public),
                 favorites_public = COALESCE(?, favorites_public),
                 collections_public = COALESCE(?, collections_public),
                 updated_at = CURRENT_TIMESTAMP
             WHERE user_id = ?",
        )
        .bind(profile.display_name)
        .bind(profile.bio)
        .bind(profile.avatar_url)
        .bind(profile.summary_public)
        .bind(profile.ratings_public)
        .bind(profile.favorites_public)
        .bind(profile.collections_public)
        .bind(user_id)
        .execute(pool)
        .await?;

        Self::ensure_public_profile(pool, user_id).await
    }
}
