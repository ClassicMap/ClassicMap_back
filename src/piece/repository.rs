use super::model::{
    order_part_tree, CreatePiece, Piece, PiecePart, PiecePartRow, PieceSearchResult, UpdatePiece,
};
use crate::db::DbPool;
use crate::search::SearchText;
use sqlx::Error;
use ClassicMap_back::comparison::repository::PUBLIC_COMPARISON_CTE;

pub struct PieceRepository;

/// `Piece.part_count`: 최상위 part 수. 작품 행을 `piece` 로 부르는 쿼리에서만 쓴다.
const PART_COUNT_COLUMN: &str = "(SELECT COUNT(*)
         FROM piece_parts top_part
         WHERE top_part.piece_id = piece.id
           AND top_part.parent_part_id IS NULL) AS part_count";

/// 같은 작곡가의 다른 작품(묶음) part 가 가리키는 작품이 아니다.
///
/// 그런 작품은 묶음을 펼치면 보이므로 작곡가 작품 목록 최상위와 작곡가 작품 수에서 뺀다.
/// 다른 작곡가의 묶음이 가리키는 경우는 이 작곡가 목록에서 볼 길이 없으니 남긴다.
/// 검색과 `/pieces/<id>` 는 이 조건을 쓰지 않는다.
///
/// 작곡가 비교를 바깥 행(`{alias}.composer_id`)과 하면 MySQL 이 같은 작곡가의 작품을
/// 작품마다 다시 훑는 antijoin 을 고른다(작품 2만 건에서 작곡가 목록 3초).
/// 안쪽의 `linked` 와 비교하면 이어진 작품 집합을 한 번만 만들어 찾는다.
pub fn top_level_piece_condition(alias: &str) -> String {
    format!(
        "NOT EXISTS (
            SELECT 1
            FROM piece_parts linked_part
            JOIN pieces linked ON linked.id = linked_part.linked_piece_id
            JOIN pieces bundle ON bundle.id = linked_part.piece_id
            WHERE linked_part.linked_piece_id = {alias}.id
              AND bundle.id <> linked.id
              AND bundle.composer_id = linked.composer_id
        )"
    )
}

/// 작곡가 작품 목록 정렬.
///
/// 국제 시드가 넣은 작품은 제목과 식별자만 있고 설명·스트리밍 링크가 없다.
/// 정렬이 없으면 손으로 채운 작품이 시드 작품 수백 건에 묻히므로,
/// 들을 수 있고 설명이 있는 작품을 먼저 준다.
///
/// 그 안에서는 작품번호 순이다. catalogue_number 가 있으면 `catalogue_system catalogue_number`,
/// 없으면 opus_number 를 작품번호로 본다(예: "Op. 10, No. 12", "B. 49", "BWV 1046–1051").
/// 1. 작품번호가 없는 작품은 뒤로.
/// 2. Op. 로 시작하는 번호를 먼저, 그다음 나머지 목록(B., BWV, K. …)을 접두어의 글자만 떼어
///    알파벳 순으로 묶는다. 쇼팽의 유작(B. 49)이 Op. 작품 뒤에 오게 한다.
/// 3. 같은 접두어 안에서는 첫 숫자(작품 번호), 둘째 숫자(No.)를 숫자로 비교한다.
///    둘째 숫자가 없는 묶음(Op. 10)이 그 안의 곡(Op. 10, No. 1)보다 앞선다.
/// 4. 그래도 같으면 작품번호 문자열("M. 57" < "M. 57b"), 마지막 id 로 페이지 경계를 고정한다.
fn composer_pieces_order() -> String {
    let label = "(CASE
            WHEN piece.catalogue_number IS NOT NULL AND TRIM(piece.catalogue_number) <> ''
                THEN TRIM(CONCAT_WS(' ', piece.catalogue_system, piece.catalogue_number))
            ELSE NULLIF(TRIM(piece.opus_number), '')
        END)";
    format!(
        "ORDER BY
            (piece.spotify_url IS NOT NULL OR piece.apple_music_url IS NOT NULL) DESC,
            (piece.description IS NOT NULL AND piece.description <> '') DESC,
            {label} IS NULL ASC,
            REGEXP_LIKE({label}, '^op', 'i') DESC,
            REGEXP_REPLACE(LOWER(REGEXP_SUBSTR({label}, '^[^0-9]*')), '[^a-z]', '') ASC,
            REGEXP_SUBSTR({label}, '[0-9]+') IS NULL ASC,
            CAST(REGEXP_SUBSTR({label}, '[0-9]+') AS UNSIGNED) ASC,
            CAST(REGEXP_SUBSTR({label}, '[0-9]+', 1, 2) AS UNSIGNED) ASC,
            {label} ASC,
            piece.id ASC"
    )
}

impl PieceRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Piece>, Error> {
        sqlx::query_as::<_, Piece>(&format!(
            "SELECT piece.*, {PART_COUNT_COLUMN} FROM pieces piece"
        ))
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Piece>, Error> {
        sqlx::query_as::<_, Piece>(&format!(
            "SELECT piece.*, {PART_COUNT_COLUMN} FROM pieces piece WHERE piece.id = ?"
        ))
        .bind(id)
        .fetch_optional(pool)
        .await
    }

    fn composer_pieces_sql(paged: bool) -> String {
        format!(
            "SELECT piece.*, {PART_COUNT_COLUMN}
             FROM pieces piece
             WHERE piece.composer_id = ?
               AND {top_level}
             {order}{page}",
            top_level = top_level_piece_condition("piece"),
            order = composer_pieces_order(),
            page = if paged { " LIMIT ? OFFSET ?" } else { "" },
        )
    }

    pub async fn find_by_composer_id(pool: &DbPool, composer_id: i32) -> Result<Vec<Piece>, Error> {
        sqlx::query_as::<_, Piece>(&Self::composer_pieces_sql(false))
            .bind(composer_id)
            .fetch_all(pool)
            .await
    }

    pub async fn find_page_by_composer_id(
        pool: &DbPool,
        composer_id: i32,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<Piece>, Error> {
        sqlx::query_as::<_, Piece>(&Self::composer_pieces_sql(true))
            .bind(composer_id)
            .bind(limit)
            .bind(offset)
            .fetch_all(pool)
            .await
    }

    /// 작품의 part 를 화면 순서로 준다. 없는 작품이면 다른 `/pieces/<id>/…` 목록처럼 빈 목록이다.
    /// 이어진 작품의 `comparable` 은 비교 화면과 같은 공개 기준(`PUBLIC_COMPARISON_CTE`)으로 본다.
    pub async fn find_parts(pool: &DbPool, piece_id: i32) -> Result<Vec<PiecePart>, Error> {
        let rows = sqlx::query_as::<_, PiecePartRow>(&format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT part.id,
                    part.parent_part_id,
                    part.sequence_number,
                    part.movement_number,
                    part.name_ko,
                    part.name_en,
                    linked.id AS linked_piece_id,
                    linked.title AS linked_title,
                    EXISTS (
                        SELECT 1
                        FROM public_sector
                        JOIN performance_sectors sector ON sector.id = public_sector.sector_id
                        WHERE sector.piece_id = linked.id
                    ) AS linked_comparable,
                    linked.spotify_url AS linked_spotify_url,
                    linked.apple_music_url AS linked_apple_music_url
             FROM piece_parts part
             LEFT JOIN pieces linked ON linked.id = part.linked_piece_id
             WHERE part.piece_id = ?"
        ))
        .bind(piece_id)
        .fetch_all(pool)
        .await?;

        Ok(order_part_tree(rows)
            .into_iter()
            .map(PiecePart::from)
            .collect())
    }

    /// 제목·영문 제목·별칭·작품번호·작곡가 이름으로 찾는다.
    /// 제목 완전 일치, 접두사, 포함(별칭 포함), 작품번호, 작곡가 이름 순으로 앞에 둔다.
    pub async fn search(
        pool: &DbPool,
        query: Option<&str>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<PieceSearchResult>, Error> {
        let Some(text) = SearchText::parse(query) else {
            return sqlx::query_as::<_, PieceSearchResult>(&format!(
                "SELECT piece.*, {PART_COUNT_COLUMN},
                        composer.name AS composer_name, composer.avatar_url AS composer_avatar_url
                 FROM pieces piece
                 JOIN composers composer ON composer.id = piece.composer_id
                 ORDER BY {}
                 LIMIT ? OFFSET ?",
                Self::SEARCH_TIEBREAK_COLUMNS
            ))
            .bind(limit)
            .bind(offset)
            .fetch_all(pool)
            .await;
        };

        let exact = text.exact();
        let prefix = text.prefix();
        let contains = text.contains();

        sqlx::query_as::<_, PieceSearchResult>(&format!(
            "SELECT piece.*,
                    {PART_COUNT_COLUMN},
                    composer.name AS composer_name,
                    composer.avatar_url AS composer_avatar_url,
                    CASE
                        WHEN piece.title = ? OR piece.title_en = ? THEN 0
                        WHEN piece.title LIKE ? OR piece.title_en LIKE ? THEN 1
                        WHEN piece.title LIKE ? OR piece.title_en LIKE ? OR EXISTS (
                            SELECT 1 FROM piece_aliases alias
                            WHERE alias.piece_id = piece.id AND alias.alias_value LIKE ?
                        ) THEN 2
                        WHEN piece.opus_number LIKE ? THEN 3
                        ELSE 4
                    END AS relevance
             FROM pieces piece
             JOIN composers composer ON composer.id = piece.composer_id
             WHERE piece.title LIKE ?
                OR piece.title_en LIKE ?
                OR piece.opus_number LIKE ?
                OR composer.name LIKE ?
                OR composer.full_name LIKE ?
                OR composer.english_name LIKE ?
                OR EXISTS (
                    SELECT 1 FROM piece_aliases alias
                    WHERE alias.piece_id = piece.id AND alias.alias_value LIKE ?
                )
             ORDER BY relevance ASC, {}
             LIMIT ? OFFSET ?",
            Self::SEARCH_TIEBREAK_COLUMNS
        ))
        .bind(exact)
        .bind(exact)
        .bind(prefix)
        .bind(prefix)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(contains)
        .bind(limit)
        .bind(offset)
        .fetch_all(pool)
        .await
    }

    const SEARCH_TIEBREAK_COLUMNS: &'static str =
        "(piece.spotify_url IS NOT NULL OR piece.apple_music_url IS NOT NULL) DESC, piece.id ASC";

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
             WHERE id = ?",
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
