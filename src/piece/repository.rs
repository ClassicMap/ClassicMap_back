use super::model::{
    order_part_tree, CreatePiece, Piece, PiecePart, PiecePartRow, PieceSearchResult, UpdatePiece,
};
use crate::db::DbPool;
use crate::search::SearchText;
use sqlx::Error;
use ClassicMap_back::comparison::repository::PUBLIC_COMPARISON_CTE;

pub struct PieceRepository;

/// 화면에 내놓는 part. 편집자가 확인한 part 만 쓴다.
///
/// 국제 시드 part(IDENTIFIERS_MATCHED)와 손으로 넣은 옛 악장(FACTS_VERIFIED, 대부분 이름이
/// "Winterreise, op. 89, D. 911: I. Gute Nacht" 같은 MusicBrainz 원제)는 숨긴다.
/// `part_count`·`part_kind`, `/pieces/<id>/parts`, 목록 숨김, 정렬의 들을 거리가 모두 이 조건을
/// 써서 개수·목록·숨김이 어긋나지 않게 한다. piece_parts 행을 `part` 로 부르는 쿼리에서만 쓴다.
const VISIBLE_PART: &str = "part.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')";

/// 목록에 내놓는 작품·작곡가 행: 숨김 까닭(`hidden_reason`)이 없다.
///
/// 국제 시드가 넣은 대중음악 작곡가와 잡음 작품(악장 하나짜리, 팝 편곡 등)은 지우지 않고 까닭을 적어
/// 숨긴다. 작곡가 목록·검색, 작품 목록·검색, 작곡가 작품 수가 모두 이 조건을 써서 목록과 개수가
/// 어긋나지 않게 한다. 상세(`/composers/<id>`, `/pieces/<id>`)와 `/pieces/<id>/parts` 는 쓰지 않아
/// 직접 링크·즐겨찾기로는 열린다. `pieces`·`composers` 행의 별칭을 받는다.
pub fn listed_condition(alias: &str) -> String {
    format!("{alias}.hidden_reason IS NULL")
}

/// 편집자가 손본 작품 행: 설명이 있거나 비교 구간이 붙어 있다.
fn has_curation(alias: &str) -> String {
    format!(
        "(({alias}.description IS NOT NULL AND {alias}.description <> '')
          OR EXISTS (SELECT 1 FROM performance_sectors sector WHERE sector.piece_id = {alias}.id))"
    )
}

/// 들을 거리가 있는 작품 행: 스트리밍 링크나 설명이 있다.
fn has_listening(alias: &str) -> String {
    format!(
        "({alias}.spotify_url IS NOT NULL
          OR {alias}.apple_music_url IS NOT NULL
          OR ({alias}.description IS NOT NULL AND {alias}.description <> ''))"
    )
}

/// `Piece.part_count`·`part_kind`: 보이는 최상위 part 의 수와 종류.
/// 종류는 전부 악장 번호가 있으면 movement(교향곡 4악장), 하나라도 없으면 work(연습곡집 12곡),
/// 0개면 NULL 이다. 작품 행을 `piece` 로 부르는 쿼리에서만 쓴다.
fn part_summary_columns() -> String {
    let top_parts = format!(
        "FROM piece_parts part
         WHERE part.piece_id = piece.id
           AND part.parent_part_id IS NULL
           AND {VISIBLE_PART}"
    );
    format!(
        "(SELECT COUNT(*) {top_parts}) AS part_count,
         (SELECT CASE
                     WHEN COUNT(*) = 0 THEN NULL
                     WHEN COUNT(*) = COUNT(NULLIF(TRIM(part.movement_number), '')) THEN 'movement'
                     ELSE 'work'
                 END
          {top_parts}) AS part_kind"
    )
}

/// 같은 작곡가의 다른 작품(묶음)의 보이는 part 가 가리키는 작품이 아니다.
///
/// 그런 작품은 묶음을 펼치면 보이므로 작곡가 작품 목록 최상위와 작곡가 작품 수에서 뺀다.
/// 숨은 part 가 가리키는 작품은 펼쳐도 안 보이니 남긴다.
/// 목록에서 숨긴 묶음(`listed_condition`)도 펼칠 길이 없으니 그 묶음이 가리키는 작품은 남긴다.
/// 다른 작곡가의 묶음이 가리키는 경우는 이 작곡가 목록에서 볼 길이 없으니 남긴다.
/// 검색과 `/pieces/<id>` 는 이 조건을 쓰지 않는다.
///
/// 작곡가 비교를 바깥 행(`{alias}.composer_id`)과 하면 MySQL 이 같은 작곡가의 작품을
/// 작품마다 다시 훑는 antijoin 을 고른다(작품 2만 건에서 작곡가 목록 3초).
/// 안쪽의 `linked` 와 비교하면 이어진 작품 집합을 한 번만 만들어 찾는다.
/// 그래도 바깥 쿼리의 행 수를 작게 어림하면 `bundle` 을 작곡가 인덱스로 훑는 같은 antijoin 으로
/// 돌아갈 수 있어(숨김 조건을 붙이다 본 작곡가 목록 40초) `bundle` 은 기본 키로만 찾게 못 박는다.
/// 그러면 작품마다 `part.linked_piece_id` 인덱스로 이어진 part 를 찾고 그 묶음을 기본 키로 본다.
pub fn top_level_piece_condition(alias: &str) -> String {
    format!(
        "NOT EXISTS (
            SELECT 1
            FROM piece_parts part
            JOIN pieces linked ON linked.id = part.linked_piece_id
            JOIN pieces bundle FORCE INDEX (PRIMARY) ON bundle.id = part.piece_id
            WHERE part.linked_piece_id = {alias}.id
              AND {VISIBLE_PART}
              AND bundle.id <> linked.id
              AND bundle.composer_id = linked.composer_id
              AND {listed_bundle}
        )",
        listed_bundle = listed_condition("bundle"),
    )
}

/// 작곡가 작품 목록 정렬.
///
/// 국제 시드가 넣은 작품은 제목과 식별자만 있고 설명·스트리밍 링크가 없다.
/// 정렬이 없으면 손으로 채운 작품이 시드 작품 수백 건에 묻히므로, 들을 거리가 있는 작품을
/// 먼저 준다. 스트리밍 링크나 설명이 있거나, 보이는 part 가 그런 작품을 가리키면 들을 거리가 있다.
/// 「혁명」처럼 링크 있는 낱곡을 품은 묶음(「연습곡 Op. 10」, 링크·설명 없음)이 시드 작품 뒤로
/// 가라앉지 않게 한다.
///
/// 그보다 먼저 편집자가 손본 작품(설명이나 비교 구간이 있거나, 보이는 part 가 그런 작품을
/// 가리킴)을 준다. 카탈로그로 다시 짠 시드 작품도 스트리밍 링크를 많이 가지고 있어서, 이 단계가
/// 없으면 바흐 칸타타 BWV 1–200 이 골드베르크 변주곡·브란덴부르크 협주곡보다 앞선다.
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
            CASE
                WHEN {piece_curation} OR EXISTS (
                    SELECT 1
                    FROM piece_parts part
                    JOIN pieces linked ON linked.id = part.linked_piece_id
                    WHERE part.piece_id = piece.id
                      AND {VISIBLE_PART}
                      AND {linked_curation}
                ) THEN 0
                WHEN {piece_listening} OR EXISTS (
                    SELECT 1
                    FROM piece_parts part
                    JOIN pieces linked ON linked.id = part.linked_piece_id
                    WHERE part.piece_id = piece.id
                      AND {VISIBLE_PART}
                      AND {linked_listening}
                ) THEN 1
                ELSE 2
            END ASC,
            {label} IS NULL ASC,
            REGEXP_LIKE({label}, '^op', 'i') DESC,
            REGEXP_REPLACE(LOWER(REGEXP_SUBSTR({label}, '^[^0-9]*')), '[^a-z]', '') ASC,
            REGEXP_SUBSTR({label}, '[0-9]+') IS NULL ASC,
            CAST(REGEXP_SUBSTR({label}, '[0-9]+') AS UNSIGNED) ASC,
            CAST(REGEXP_SUBSTR({label}, '[0-9]+', 1, 2) AS UNSIGNED) ASC,
            {label} ASC,
            piece.id ASC",
        piece_curation = has_curation("piece"),
        linked_curation = has_curation("linked"),
        piece_listening = has_listening("piece"),
        linked_listening = has_listening("linked"),
    )
}

impl PieceRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Piece>, Error> {
        sqlx::query_as::<_, Piece>(&format!(
            "SELECT piece.*, {part_summary}
             FROM pieces piece
             JOIN composers composer ON composer.id = piece.composer_id
             WHERE {listed}",
            part_summary = part_summary_columns(),
            listed = Self::listed_across_composers(),
        ))
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Piece>, Error> {
        sqlx::query_as::<_, Piece>(&format!(
            "SELECT piece.*, {} FROM pieces piece WHERE piece.id = ?",
            part_summary_columns()
        ))
        .bind(id)
        .fetch_optional(pool)
        .await
    }

    fn composer_pieces_sql(paged: bool) -> String {
        format!(
            "SELECT piece.*, {part_summary}
             FROM pieces piece
             WHERE piece.composer_id = ?
               AND {listed}
               AND {top_level}
             {order}{page}",
            part_summary = part_summary_columns(),
            listed = listed_condition("piece"),
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

    /// 작품의 보이는 part 를 화면 순서로 준다. 없는 작품이면 다른 `/pieces/<id>/…` 목록처럼 빈 목록이다.
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
             WHERE part.piece_id = ?
               AND {VISIBLE_PART}"
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
                "SELECT piece.*, {part_summary},
                        composer.name AS composer_name, composer.avatar_url AS composer_avatar_url
                 FROM pieces piece
                 JOIN composers composer ON composer.id = piece.composer_id
                 WHERE {listed}
                 ORDER BY {tiebreak}
                 LIMIT ? OFFSET ?",
                part_summary = part_summary_columns(),
                listed = Self::listed_across_composers(),
                tiebreak = Self::SEARCH_TIEBREAK_COLUMNS
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
                    {part_summary},
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
             WHERE {listed}
               AND (piece.title LIKE ?
                    OR piece.title_en LIKE ?
                    OR piece.opus_number LIKE ?
                    OR composer.name LIKE ?
                    OR composer.full_name LIKE ?
                    OR composer.english_name LIKE ?
                    OR EXISTS (
                        SELECT 1 FROM piece_aliases alias
                        WHERE alias.piece_id = piece.id AND alias.alias_value LIKE ?
                    ))
             ORDER BY relevance ASC, {tiebreak}
             LIMIT ? OFFSET ?",
            part_summary = part_summary_columns(),
            listed = Self::listed_across_composers(),
            tiebreak = Self::SEARCH_TIEBREAK_COLUMNS
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

    /// 작곡가를 가로지르는 작품 목록(`/pieces`, `/pieces/search`): 작품도 작곡가도 숨기지 않았다.
    /// 작곡가 작품 목록은 숨긴 작곡가의 상세에서도 열리므로 작품 숨김만 본다.
    /// 작품 행을 `piece`, 작곡가 행을 `composer` 로 부르는 쿼리에서만 쓴다.
    fn listed_across_composers() -> String {
        format!(
            "{} AND {}",
            listed_condition("piece"),
            listed_condition("composer")
        )
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
