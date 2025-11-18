use crate::db::DbPool;
use super::model::{Piece, CreatePiece, UpdatePiece};
use sqlx::Error;

pub struct PieceRepository;

impl PieceRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Piece>, Error> {
        sqlx::query_as::<_, Piece>("SELECT * FROM pieces")
            .fetch_all(pool)
            .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Piece>, Error> {
        sqlx::query_as::<_, Piece>("SELECT * FROM pieces WHERE id = ?")
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn find_by_composer_id(pool: &DbPool, composer_id: i32) -> Result<Vec<Piece>, Error> {
        sqlx::query_as::<_, Piece>("SELECT * FROM pieces WHERE composer_id = ?")
            .bind(composer_id)
            .fetch_all(pool)
            .await
    }

    pub async fn create(pool: &DbPool, piece: CreatePiece) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO pieces (composer_id, title, title_en, type, description, opus_number, composition_year, difficulty_level, duration_minutes, spotify_url, apple_music_url, youtube_music_url)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(piece.composer_id)
        .bind(&piece.title)
        .bind(&piece.title_en)
        .bind(&piece.r#type)
        .bind(&piece.description)
        .bind(&piece.opus_number)
        .bind(piece.composition_year)
        .bind(piece.difficulty_level)
        .bind(piece.duration_minutes)
        .bind(&piece.spotify_url)
        .bind(&piece.apple_music_url)
        .bind(&piece.youtube_music_url)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, piece: UpdatePiece) -> Result<u64, Error> {
        let result = sqlx::query(
            "UPDATE pieces SET
                title = COALESCE(?, title),
                title_en = COALESCE(?, title_en),
                type = COALESCE(?, type),
                description = COALESCE(?, description),
                opus_number = COALESCE(?, opus_number),
                composition_year = COALESCE(?, composition_year),
                difficulty_level = COALESCE(?, difficulty_level),
                duration_minutes = COALESCE(?, duration_minutes),
                spotify_url = COALESCE(?, spotify_url),
                apple_music_url = COALESCE(?, apple_music_url),
                youtube_music_url = COALESCE(?, youtube_music_url)
             WHERE id = ?"
        )
        .bind(&piece.title)
        .bind(&piece.title_en)
        .bind(&piece.r#type)
        .bind(&piece.description)
        .bind(&piece.opus_number)
        .bind(piece.composition_year)
        .bind(piece.difficulty_level)
        .bind(piece.duration_minutes)
        .bind(&piece.spotify_url)
        .bind(&piece.apple_music_url)
        .bind(&piece.youtube_music_url)
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM pieces WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
