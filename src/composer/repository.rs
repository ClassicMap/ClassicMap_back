use super::model::{
    Composer, ComposerWithMajorPieces, ComposerWithPerformance, CreateComposer, UpdateComposer,
};
use super::service::ComposerSort;
use crate::db::DbPool;
use crate::search::SearchText;
use sqlx::Error;
use ClassicMap_back::comparison::repository::PUBLIC_COMPARISON_CTE;

pub struct ComposerRepository;

/// 곡이 한 곡도 없는 작곡가는 목록에서 뺀다.
///
/// 국제 시드는 두 종류의 빈 작곡가를 만든다. Wikidata 의 P106 에 작곡가가 있으면
/// 지휘자·피아니스트도 작곡가로 투영되고, 덤프에서 발굴한 작곡가는 아직 작품을
/// 가져오지 않아 곡이 없다. 어느 쪽이든 목록에서는 눌러도 볼 것이 없다.
///
/// 손으로 채운 작곡가는 전원 곡을 가지고 있어 이 조건에 걸리지 않는다.
/// 작품이 한 곡이라도 적재되면 조건이 풀려 자동으로 다시 보인다.
/// tier(S > A > 없음 > B > C) → 공개 비교 섹터 보유 → 초상 → 소개 → 작품 수 → id.
/// 초상과 소개를 따로 보는 건 목록 첫 화면에서 눈에 띄는 게 초상이기 때문이다.
/// 마지막 id는 offset 페이지를 넘길 때 순서가 흔들리지 않게 한다.
/// `PUBLIC_COMPARISON_CTE`가 앞에 붙은 쿼리에서만 쓴다.
const RECOMMENDED_ORDER: &str = "CASE c.tier
        WHEN 'S' THEN 0
        WHEN 'A' THEN 1
        WHEN 'B' THEN 3
        WHEN 'C' THEN 4
        ELSE 2
    END ASC,
    EXISTS (
        SELECT 1
        FROM public_sector
        JOIN performance_sectors sector ON sector.id = public_sector.sector_id
        JOIN pieces sector_piece ON sector_piece.id = sector.piece_id
        WHERE sector_piece.composer_id = c.id
    ) DESC,
    (c.avatar_url IS NOT NULL AND c.avatar_url <> '') DESC,
    (c.bio IS NOT NULL AND c.bio <> '') DESC,
    COUNT(p.id) DESC,
    c.id ASC";

const HIDE_EMPTY_COMPOSER: &str = "EXISTS (SELECT 1 FROM pieces own WHERE own.composer_id = c.id)";

impl ComposerRepository {
    pub async fn find_all(pool: &DbPool, offset: i64, limit: i64) -> Result<Vec<Composer>, Error> {
        sqlx::query_as::<_, Composer>(&format!(
            "SELECT c.*, COUNT(p.id) as piece_count
             FROM composers c
             LEFT JOIN pieces p ON c.id = p.composer_id
             WHERE {HIDE_EMPTY_COMPOSER}
             GROUP BY c.id
             ORDER BY c.birth_year ASC
             LIMIT ? OFFSET ?"
        ))
        .bind(limit)
        .bind(offset)
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(
        pool: &DbPool,
        id: i32,
    ) -> Result<Option<ComposerWithMajorPieces>, Error> {
        sqlx::query_as::<_, ComposerWithMajorPieces>(
            "SELECT v.*,
                    (SELECT COUNT(*) FROM pieces p WHERE p.composer_id = v.id) AS piece_count
             FROM v_composers_full v
             WHERE v.id = ?",
        )
        .bind(id)
        .fetch_optional(pool)
        .await
    }

    pub async fn create(pool: &DbPool, composer: CreateComposer) -> Result<i32, Error> {
        let result = sqlx::query(
            "INSERT INTO composers (name, full_name, english_name, period, tier, birth_year, death_year, nationality, avatar_url, cover_image_url, bio, style, influence)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&composer.name)
        .bind(&composer.full_name)
        .bind(&composer.english_name)
        .bind(&composer.period)
        .bind(&composer.tier)
        .bind(composer.birth_year)
        .bind(composer.death_year)
        .bind(&composer.nationality)
        .bind(&composer.avatar_url)
        .bind(&composer.cover_image_url)
        .bind(&composer.bio)
        .bind(&composer.style)
        .bind(&composer.influence)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &DbPool, id: i32, composer: UpdateComposer) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE composers SET name = ?, full_name = ?, english_name = ?, period = ?, tier = ?,
             birth_year = ?, death_year = ?, nationality = ?, avatar_url = ?,
             cover_image_url = ?, bio = ?, style = ?, influence = ?
             WHERE id = ?",
        )
        .bind(composer.name.unwrap_or(current.name))
        .bind(composer.full_name.unwrap_or(current.full_name))
        .bind(composer.english_name.unwrap_or(current.english_name))
        .bind(composer.period.unwrap_or(current.period))
        .bind(composer.tier.or(current.tier))
        .bind(composer.birth_year.unwrap_or(current.birth_year))
        .bind(composer.death_year.or(current.death_year))
        .bind(composer.nationality.unwrap_or(current.nationality))
        .bind(composer.avatar_url.or(current.avatar_url))
        .bind(composer.cover_image_url.or(current.cover_image_url))
        .bind(composer.bio.or(current.bio))
        .bind(composer.style.or(current.style))
        .bind(composer.influence.or(current.influence))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM composers WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }

    pub async fn search_composers(
        pool: &DbPool,
        query: Option<String>,
        period: Option<String>,
        offset: i64,
        limit: i64,
        sort: ComposerSort,
    ) -> Result<Vec<Composer>, Error> {
        // 추천순은 곡 비교 화면과 같은 공개 기준으로 비교 가능 여부를 본다.
        let mut sql = match sort {
            ComposerSort::BirthYear => String::new(),
            ComposerSort::Recommended => format!("{PUBLIC_COMPARISON_CTE} "),
        };
        sql.push_str(
            "SELECT c.*, COUNT(p.id) as piece_count
             FROM composers c
             LEFT JOIN pieces p ON c.id = p.composer_id",
        );

        let mut where_clauses = vec![HIDE_EMPTY_COMPOSER.to_string()];
        let mut bind_values: Vec<String> = Vec::new();
        let search_text = SearchText::parse(query.as_deref());

        // Add search condition if query provided
        if let Some(text) = &search_text {
            where_clauses
                .push("(c.name LIKE ? OR c.full_name LIKE ? OR c.english_name LIKE ?)".to_string());
            for _ in 0..3 {
                bind_values.push(text.contains().to_string());
            }
        }

        // Add period filter if provided and not 'all'
        if let Some(p) = period {
            if p != "all" {
                where_clauses.push("c.period = ?".to_string());
                bind_values.push(p);
            }
        }

        // Append WHERE clause if conditions exist
        if !where_clauses.is_empty() {
            sql.push_str(&format!(" WHERE {}", where_clauses.join(" AND ")));
        }

        // 검색어가 있으면 이름 관련도를 먼저 보고, 없으면 기존처럼 연대순이다.
        sql.push_str(" GROUP BY c.id ORDER BY ");
        if let Some(text) = &search_text {
            let (relevance_sql, relevance_binds) =
                text.name_relevance(&["c.name", "c.full_name", "c.english_name"]);
            sql.push_str(&relevance_sql);
            sql.push_str(", ");
            bind_values.extend(relevance_binds);
        }
        match sort {
            ComposerSort::BirthYear => sql.push_str("c.birth_year ASC, c.id ASC"),
            ComposerSort::Recommended => sql.push_str(RECOMMENDED_ORDER),
        }

        // limit=0이면 전체 반환, 아니면 페이징
        if limit > 0 {
            sql.push_str(" LIMIT ? OFFSET ?");
        }

        // Build query with dynamic bindings
        let mut query = sqlx::query_as::<_, Composer>(&sql);

        // Bind all search/filter values
        for value in bind_values {
            query = query.bind(value);
        }

        // Bind limit and offset
        if limit > 0 {
            query = query.bind(limit).bind(offset);
        }

        query.fetch_all(pool).await
    }

    pub async fn find_with_performances(
        pool: &DbPool,
        limit: i64,
    ) -> Result<Vec<ComposerWithPerformance>, Error> {
        sqlx::query_as::<_, ComposerWithPerformance>(
            "SELECT c.id AS composer_id, c.name AS composer_name,
                    c.avatar_url AS composer_avatar_url,
                    p.id AS piece_id, p.title AS piece_title,
                    COUNT(pf.id) AS performance_count,
                    GROUP_CONCAT(DISTINCT a.name) AS artist_names
             FROM composers c
             JOIN pieces p ON p.composer_id = c.id
             JOIN performances pf ON pf.piece_id = p.id
             JOIN artists a ON a.id = pf.artist_id
             GROUP BY c.id, c.name, c.avatar_url, p.id, p.title
             ORDER BY RAND()
             LIMIT ?",
        )
        .bind(limit)
        .fetch_all(pool)
        .await
    }
}
