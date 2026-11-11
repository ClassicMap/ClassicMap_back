use super::model::{
    order_part_tree, CatalogRow, ComposerPieceQuery, ComposerPieceRow, ComposerPieceSort,
    CreatePiece, GenreFilter, HighlightRow, Piece, PiecePart, PiecePartRow, PieceSearchResult,
    UpdatePiece,
};
use crate::db::DbPool;
use crate::search::SearchText;
use crate::search_terms::search_tokens;
use sqlx::Error;
use ClassicMap_back::comparison::repository::PUBLIC_COMPARISON_CTE;

pub struct PieceRepository;

/// 「처음 듣는다면」에 싣는 최대 곡 수. 화면은 5곡을 보이고 '더 보기'로 10곡까지 편다.
pub const MAX_HIGHLIGHTS: i64 = 10;

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

// 작곡가 작품 목록 정렬.
//
// 국제 시드가 넣은 작품은 제목과 식별자만 있고 설명·스트리밍 링크가 없다.
// 정렬이 없으면 손으로 채운 작품이 시드 작품 수백 건에 묻히므로, 들을 거리가 있는 작품을
// 먼저 준다. 스트리밍 링크나 설명이 있거나, 보이는 part 가 그런 작품을 가리키면 들을 거리가 있다.
// 「혁명」처럼 링크 있는 낱곡을 품은 묶음(「연습곡 Op. 10」, 링크·설명 없음)이 시드 작품 뒤로
// 가라앉지 않게 한다.
//
// 그보다 먼저 편집자가 손본 작품(설명이나 비교 구간이 있거나, 보이는 part 가 그런 작품을
// 가리킴)을 준다. 카탈로그로 다시 짠 시드 작품도 스트리밍 링크를 많이 가지고 있어서, 이 단계가
// 없으면 바흐 칸타타 BWV 1–200 이 골드베르크 변주곡·브란덴부르크 협주곡보다 앞선다.
//
// 그 안에서는 작품번호 순이다. catalogue_number 가 있으면 `catalogue_system catalogue_number`,
// 없으면 opus_number 를 작품번호로 본다(예: "Op. 10, No. 12", "B. 49", "BWV 1046–1051").
// 1. 작품번호가 없는 작품은 뒤로.
// 2. Op. 로 시작하는 번호를 먼저, 그다음 나머지 목록(B., BWV, K. …)을 접두어의 글자만 떼어
//    알파벳 순으로 묶는다. 쇼팽의 유작(B. 49)이 Op. 작품 뒤에 오게 한다.
// 3. 같은 접두어 안에서는 첫 숫자(작품 번호), 둘째 숫자(No.)를 숫자로 비교한다.
//    둘째 숫자가 없는 묶음(Op. 10)이 그 안의 곡(Op. 10, No. 1)보다 앞선다.
// 4. 그래도 같으면 작품번호 문자열("M. 57" < "M. 57b"), 마지막 id 로 페이지 경계를 고정한다.

/// 작품번호 칸: catalogue_number 가 있으면 `catalogue_system catalogue_number`, 없으면 opus_number.
const CATALOGUE_LABEL: &str = "(CASE
            WHEN piece.catalogue_number IS NOT NULL AND TRIM(piece.catalogue_number) <> ''
                THEN TRIM(CONCAT_WS(' ', piece.catalogue_system, piece.catalogue_number))
            ELSE NULLIF(TRIM(piece.opus_number), '')
        END)";

/// 작품번호순 정렬 항목(위 1~4).
fn catalogue_order_terms() -> String {
    let label = CATALOGUE_LABEL;
    format!(
        "{label} IS NULL ASC,
            REGEXP_LIKE({label}, '^op', 'i') DESC,
            REGEXP_REPLACE(LOWER(REGEXP_SUBSTR({label}, '^[^0-9]*')), '[^a-z]', '') ASC,
            REGEXP_SUBSTR({label}, '[0-9]+') IS NULL ASC,
            CAST(REGEXP_SUBSTR({label}, '[0-9]+') AS UNSIGNED) ASC,
            CAST(REGEXP_SUBSTR({label}, '[0-9]+', 1, 2) AS UNSIGNED) ASC,
            {label} ASC,
            piece.id ASC"
    )
}

/// 손본 작품 0 → 들을 거리 있는 작품 1 → 나머지 2.
fn listening_tier() -> String {
    format!(
        "CASE
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
        END",
        piece_curation = has_curation("piece"),
        linked_curation = has_curation("linked"),
        piece_listening = has_listening("piece"),
        linked_listening = has_listening("linked"),
    )
}

/// 대표곡이거나 세트 안에 대표 곡이 있다. 작품 행을 `piece` 로 부르는 쿼리에서만 쓴다.
fn notable_condition() -> String {
    format!(
        "(piece.notable = 1 OR EXISTS (
            SELECT 1 FROM piece_parts part
            WHERE part.piece_id = piece.id
              AND part.parent_part_id IS NULL
              AND part.notable = 1
              AND {VISIBLE_PART}
        ))"
    )
}

/// 정렬 절과 그 바인드 값(관련도 정렬만 검색어를 바인드한다).
fn composer_pieces_order(query: &ComposerPieceQuery) -> (String, Vec<String>) {
    let catalogue = catalogue_order_terms();
    let order = match query.sort {
        ComposerPieceSort::Listening => {
            format!("ORDER BY {tier} ASC, {catalogue}", tier = listening_tier())
        }
        ComposerPieceSort::Catalogue => format!("ORDER BY {catalogue}"),
        ComposerPieceSort::Year => format!(
            "ORDER BY piece.composition_year IS NULL ASC, piece.composition_year ASC, {catalogue}"
        ),
        ComposerPieceSort::Notable => format!(
            "ORDER BY {notable} DESC, {tier} ASC, COALESCE(piece.fame_score, 0) DESC, {catalogue}",
            notable = notable_condition(),
            tier = listening_tier()
        ),
        ComposerPieceSort::Relevance => {
            let Some(contains) = query.search_patterns.first() else {
                return (format!("ORDER BY {catalogue}"), Vec::new());
            };
            // contains 는 이미 LIKE 이스케이프한 「%검색어%」다. 앞뒤 % 를 떼어 일치·접두사 패턴을 만든다
            let exact = contains
                .trim_start_matches('%')
                .trim_end_matches('%')
                .to_string();
            let prefix = format!("{exact}%");
            let any = query
                .search_patterns
                .iter()
                .map(|_| "piece.title LIKE ? OR piece.title_en LIKE ?")
                .collect::<Vec<_>>()
                .join(" OR ");
            let catalogue_any = query
                .search_patterns
                .iter()
                .map(|_| format!("piece.opus_number LIKE ? OR {CATALOGUE_LABEL} LIKE ?"))
                .collect::<Vec<_>>()
                .join(" OR ");
            let alias_any = query
                .search_patterns
                .iter()
                .map(|_| "alias.alias_value LIKE ?")
                .collect::<Vec<_>>()
                .join(" OR ");
            let mut binds = vec![exact, prefix];
            for pattern in &query.search_patterns {
                binds.push(pattern.clone());
                binds.push(pattern.clone());
            }
            for pattern in &query.search_patterns {
                binds.push(pattern.clone());
                binds.push(pattern.clone());
            }
            for pattern in &query.search_patterns {
                binds.push(pattern.clone());
            }
            return (
                format!(
                    "ORDER BY CASE
                        WHEN piece.title LIKE ? THEN 0
                        WHEN piece.title LIKE ? THEN 1
                        WHEN {any} THEN 2
                        WHEN {catalogue_any} THEN 3
                        WHEN EXISTS (SELECT 1 FROM piece_aliases alias
                                     WHERE alias.piece_id = piece.id AND ({alias_any})) THEN 4
                        ELSE 5
                    END ASC,
                    {notable} DESC,
                    COALESCE(piece.fame_score, 0) DESC,
                    {catalogue}",
                    notable = notable_condition(),
                ),
                binds,
            );
        }
    };
    (order, Vec::new())
}

/// 작곡가 작품 목록의 거르기·검색 조건과 그 바인드 값(순서대로).
fn composer_piece_filters(query: &ComposerPieceQuery) -> (String, Vec<String>) {
    let mut sql = String::new();
    let mut binds = Vec::new();
    match &query.genre {
        GenreFilter::Any => {}
        GenreFilter::Unclassified => sql.push_str(" AND piece.genre IS NULL"),
        GenreFilter::Genre(genre) => {
            sql.push_str(" AND piece.genre = ?");
            binds.push(genre.clone());
        }
    }
    if let Some(form) = &query.form {
        sql.push_str(" AND piece.form_key = ?");
        binds.push(form.clone());
    }
    if query.notable_only {
        sql.push_str(&format!(" AND {}", notable_condition()));
    }
    // 낱말마다(AND) 그 낱말의 변형 중 하나(OR)가 어느 칸에든 맞아야 한다
    for variants in &query.search_tokens {
        let mut groups = Vec::new();
        for pattern in variants {
            groups.push(format!(
                "piece.title LIKE ? OR piece.title_en LIKE ? OR piece.opus_number LIKE ?
                 OR {CATALOGUE_LABEL} LIKE ?
                 OR EXISTS (SELECT 1 FROM piece_aliases alias
                            WHERE alias.piece_id = piece.id AND alias.alias_value LIKE ?)
                 OR EXISTS (SELECT 1 FROM piece_parts part
                            WHERE part.piece_id = piece.id AND {VISIBLE_PART}
                              AND (part.name_ko LIKE ? OR part.name_en LIKE ?))"
            ));
            binds.extend(std::iter::repeat_n(pattern.clone(), 7));
        }
        sql.push_str(&format!(" AND ({})", groups.join(" OR ")));
    }
    (sql, binds)
}

/// 검색어가 걸린 첫 세트 안 곡(번호·이름) 칼럼과 그 바인드 값. 검색하지 않으면 빈 칼럼이다.
fn matched_part_columns(query: &ComposerPieceQuery) -> (String, Vec<String>) {
    // 낱말 하나라도 맞는 첫 곡을 보인다(「Op. 27 월광」이면 「월광」이 맞는 14번)
    let patterns: Vec<&String> = query.search_tokens.iter().flatten().collect();
    if patterns.is_empty() {
        return (String::new(), Vec::new());
    }
    let condition = patterns
        .iter()
        .map(|_| "part.name_ko LIKE ? OR part.name_en LIKE ?")
        .collect::<Vec<_>>()
        .join(" OR ");
    let from = format!(
        "FROM piece_parts part
         WHERE part.piece_id = piece.id AND part.parent_part_id IS NULL AND {VISIBLE_PART}
           AND ({condition})
         ORDER BY part.sequence_number, part.id
         LIMIT 1"
    );
    let mut binds = Vec::new();
    for _ in 0..2 {
        for pattern in &patterns {
            binds.push((*pattern).clone());
            binds.push((*pattern).clone());
        }
    }
    (
        format!(
            ", (SELECT part.sequence_number {from}) AS matched_part_sequence,
               (SELECT COALESCE(NULLIF(TRIM(part.name_ko), ''), part.name_en) {from}) AS matched_part_name"
        ),
        binds,
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

    /// 작곡가 작품 목록. 다른 작품의 part 로 이어진 작품은 묶음 안에서 보이므로 뺀다.
    pub async fn find_composer_pieces(
        pool: &DbPool,
        composer_id: i32,
        query: &ComposerPieceQuery,
        page: Option<(i64, i64)>,
    ) -> Result<Vec<ComposerPieceRow>, Error> {
        let (matched, matched_binds) = matched_part_columns(query);
        let (filters, filter_binds) = composer_piece_filters(query);
        let (order, order_binds) = composer_pieces_order(query);
        let sql = format!(
            "SELECT piece.*, {part_summary},
                    (SELECT GROUP_CONCAT(part.sequence_number ORDER BY part.sequence_number)
                     FROM piece_parts part
                     WHERE part.piece_id = piece.id AND part.parent_part_id IS NULL
                       AND part.notable = 1 AND {VISIBLE_PART}) AS notable_part_numbers
                    {matched}
             FROM pieces piece
             WHERE piece.composer_id = ?
               AND {listed}
               AND {top_level}
               {filters}
             {order}{page}",
            part_summary = part_summary_columns(),
            listed = listed_condition("piece"),
            top_level = top_level_piece_condition("piece"),
            page = if page.is_some() {
                " LIMIT ? OFFSET ?"
            } else {
                ""
            },
        );
        let mut statement = sqlx::query_as::<_, ComposerPieceRow>(&sql);
        for value in &matched_binds {
            statement = statement.bind(value);
        }
        statement = statement.bind(composer_id);
        for value in &filter_binds {
            statement = statement.bind(value);
        }
        for value in &order_binds {
            statement = statement.bind(value);
        }
        if let Some((offset, limit)) = page {
            statement = statement.bind(limit).bind(offset);
        }
        statement.fetch_all(pool).await
    }

    /// 기본 목록(손본 작품 먼저) 전체. `find_composer_pieces` 를 거르기 없이 부른다.
    pub async fn find_by_composer_id(pool: &DbPool, composer_id: i32) -> Result<Vec<Piece>, Error> {
        Self::find_composer_pieces(pool, composer_id, &ComposerPieceQuery::listing(), None)
            .await
            .map(|rows| rows.into_iter().map(|row| row.piece).collect())
    }

    /// 기본 목록(손본 작품 먼저)의 한 페이지.
    pub async fn find_page_by_composer_id(
        pool: &DbPool,
        composer_id: i32,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<Piece>, Error> {
        Self::find_composer_pieces(
            pool,
            composer_id,
            &ComposerPieceQuery::listing(),
            Some((offset, limit)),
        )
        .await
        .map(|rows| rows.into_iter().map(|row| row.piece).collect())
    }

    /// 작곡가 작품의 갈래·형식별 개수와 대표곡 수. 작품 목록과 같은 최상위·숨김 조건을 쓴다.
    /// 검색어가 있으면 그 검색에 걸린 작품만 센다(검색 중 갈래 칩의 결과 수).
    pub async fn composer_catalog(
        pool: &DbPool,
        composer_id: i32,
        query: &ComposerPieceQuery,
    ) -> Result<Vec<CatalogRow>, Error> {
        let (filters, filter_binds) = composer_piece_filters(query);
        let sql = format!(
            "SELECT piece.genre AS genre,
                    piece.form_key AS form_key,
                    form.name_ko AS form_name,
                    form.sort_order AS form_order,
                    COUNT(*) AS piece_count,
                    CAST(SUM(CASE WHEN {notable} THEN 1 ELSE 0 END) AS SIGNED) AS notable_count
             FROM pieces piece
             LEFT JOIN piece_forms form ON form.form_key = piece.form_key
             WHERE piece.composer_id = ?
               AND {listed}
               AND {top_level}{filters}
             GROUP BY piece.genre, piece.form_key, form.name_ko, form.sort_order",
            notable = notable_condition(),
            listed = listed_condition("piece"),
            top_level = top_level_piece_condition("piece"),
        );
        let mut statement = sqlx::query_as::<_, CatalogRow>(&sql).bind(composer_id);
        for value in filter_binds {
            statement = statement.bind(value);
        }
        statement.fetch_all(pool).await
    }

    /// 「처음 듣는다면」: 공개한(PUBLISHED) 줄을 순서대로 `MAX_HIGHLIGHTS` 곡까지 준다.
    /// 숨긴 작품과 다른 작곡가 작품을 가리키는 줄은 뺀다. 대표 곡은 그 작품의 보이는 최상위 part 일 때만 싣는다.
    /// 비교할 작품은 비교 화면과 같은 공개 기준(`PUBLIC_COMPARISON_CTE`)으로 작품 자체 → 대표 곡이 가리키는 작품
    /// 순으로 고른다.
    pub async fn composer_highlights(
        pool: &DbPool,
        composer_id: i32,
    ) -> Result<Vec<HighlightRow>, Error> {
        let sql = format!(
            "{PUBLIC_COMPARISON_CTE},
             public_piece AS (
                 SELECT DISTINCT sector.piece_id
                 FROM public_sector
                 JOIN performance_sectors sector ON sector.id = public_sector.sector_id
             )
             SELECT piece.id AS piece_id,
                    piece.title,
                    piece.title_en,
                    piece.genre,
                    piece.form_key,
                    piece.opus_number,
                    piece.catalogue_system,
                    piece.catalogue_number,
                    piece.composition_year,
                    {part_summary},
                    part.sequence_number AS part_number,
                    part.name_ko AS part_name_ko,
                    part.name_en AS part_name_en,
                    linked.title AS part_linked_title,
                    CASE
                        WHEN own_public.piece_id IS NOT NULL THEN piece.id
                        WHEN linked_public.piece_id IS NOT NULL THEN linked.id
                    END AS compare_piece_id,
                    highlight.reason,
                    highlight.reason_en
             FROM composer_highlights highlight
             JOIN pieces piece
               ON piece.id = highlight.piece_id
              AND piece.composer_id = highlight.composer_id
             LEFT JOIN piece_parts part
               ON part.id = highlight.part_id
              AND part.piece_id = highlight.piece_id
              AND part.parent_part_id IS NULL
              AND {VISIBLE_PART}
             LEFT JOIN pieces linked ON linked.id = part.linked_piece_id
             LEFT JOIN public_piece own_public ON own_public.piece_id = piece.id
             LEFT JOIN public_piece linked_public ON linked_public.piece_id = linked.id
             WHERE highlight.composer_id = ?
               AND highlight.status = 'PUBLISHED'
               AND {listed}
             ORDER BY highlight.sort_order ASC, highlight.id ASC
             LIMIT {MAX_HIGHLIGHTS}",
            part_summary = part_summary_columns(),
            listed = listed_condition("piece"),
        );
        sqlx::query_as::<_, HighlightRow>(&sql)
            .bind(composer_id)
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
                    linked.apple_music_url AS linked_apple_music_url,
                    part.notable AS notable,
                    part.apple_music_url AS apple_music_url,
                    part.spotify_url AS spotify_url
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
    /// 낱말마다(AND) 그 낱말의 다른 말(「에튀드」→「연습곡」「Etude」) 중 하나(OR)가 어느 칸에든 맞아야 한다.
    /// 검색어 전체가 제목과 완전 일치, 접두사, 포함(별칭 포함), 작품번호 순으로 앞에 둔다.
    pub async fn search(
        pool: &DbPool,
        query: Option<&str>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<PieceSearchResult>, Error> {
        let Some(text) = SearchText::parse(query) else {
            return sqlx::query_as::<_, PieceSearchResult>(&format!(
                "SELECT piece.*, {part_summary},
                        composer.name AS composer_name, composer.english_name AS composer_name_en,
                        composer.avatar_url AS composer_avatar_url
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

        let tokens = search_tokens(text.exact());
        let mut conditions = Vec::new();
        let mut token_binds: Vec<&str> = Vec::new();
        for variants in &tokens {
            let any = variants
                .iter()
                .map(|_| {
                    "piece.title LIKE ? OR piece.title_en LIKE ? OR piece.opus_number LIKE ?
                     OR composer.name LIKE ? OR composer.full_name LIKE ? OR composer.english_name LIKE ?
                     OR EXISTS (SELECT 1 FROM piece_aliases alias
                                WHERE alias.piece_id = piece.id AND alias.alias_value LIKE ?)"
                })
                .collect::<Vec<_>>()
                .join(" OR ");
            conditions.push(format!("({any})"));
            for pattern in variants {
                token_binds.extend(std::iter::repeat_n(pattern.as_str(), 7));
            }
        }
        if conditions.is_empty() {
            return Ok(Vec::new());
        }

        let sql = format!(
            "SELECT piece.*,
                    {part_summary},
                    composer.name AS composer_name,
                    composer.english_name AS composer_name_en,
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
               AND {conditions}
             ORDER BY relevance ASC, {tiebreak}
             LIMIT ? OFFSET ?",
            part_summary = part_summary_columns(),
            listed = Self::listed_across_composers(),
            conditions = conditions.join(" AND "),
            tiebreak = Self::SEARCH_TIEBREAK_COLUMNS
        );
        let mut statement = sqlx::query_as::<_, PieceSearchResult>(&sql)
            .bind(exact)
            .bind(exact)
            .bind(prefix)
            .bind(prefix)
            .bind(contains)
            .bind(contains)
            .bind(contains)
            .bind(contains);
        for value in token_binds {
            statement = statement.bind(value);
        }
        statement.bind(limit).bind(offset).fetch_all(pool).await
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
