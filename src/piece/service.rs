use super::model::{
    ComposerCatalog, ComposerPiece, ComposerPieceQuery, ComposerPieceSort, CreatePiece,
    GenreFilter, Piece, PiecePart, PieceSearchResult, UpdatePiece, GENRE_ORDER,
};
use super::repository::PieceRepository;
use crate::db::DbPool;
use crate::search::SearchText;

pub struct PieceService;

pub const DEFAULT_PIECE_PAGE_SIZE: i64 = 20;
pub const MAX_PIECE_PAGE_SIZE: i64 = 100;

/// 작품 목록 페이지 범위. 둘 다 없으면 기존 호출과 같이 전체를 준다.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum PieceListRange {
    All,
    Page { offset: i64, limit: i64 },
}

impl PieceListRange {
    pub fn parse(offset: Option<i64>, limit: Option<i64>) -> Result<Self, String> {
        if offset.is_none() && limit.is_none() {
            return Ok(Self::All);
        }

        let offset = offset.unwrap_or(0);
        if offset < 0 {
            return Err(format!("offset은 0 이상이어야 합니다: {offset}"));
        }
        let limit = limit
            .unwrap_or(DEFAULT_PIECE_PAGE_SIZE)
            .clamp(1, MAX_PIECE_PAGE_SIZE);

        Ok(Self::Page { offset, limit })
    }
}

/// 작곡가 안 검색에서 같은 뜻으로 찾는 말. 데이터의 표기(오른쪽)로 바꿔 한 번 더 찾는다.
const SEARCH_ALIASES: [(&str, &str); 6] = [
    ("야상곡", "녹턴"),
    ("에튀드", "연습곡"),
    ("폴로네이즈", "폴로네즈"),
    ("프렐류드", "전주곡"),
    ("판타지", "환상곡"),
    ("랩소디", "광시곡"),
];

/// 「op10」「op 10」「op.10」을 데이터 표기 「Op. 10」으로 바꾼다. 아니면 그대로 둔다.
fn normalize_opus(text: &str) -> String {
    let lower = text.to_lowercase();
    let Some(rest) = lower.strip_prefix("op") else {
        return text.to_string();
    };
    let digits = rest.trim_start_matches(['.', ' ']);
    if digits.chars().next().is_some_and(|c| c.is_ascii_digit()) {
        format!("Op. {digits}")
    } else {
        text.to_string()
    }
}

impl ComposerPieceQuery {
    /// `/composers/<id>/pieces` 의 쿼리 값. 모르는 갈래·정렬·형식 이름은 거절한다.
    pub fn parse(
        genre: Option<&str>,
        form: Option<&str>,
        sort: Option<&str>,
        q: Option<&str>,
        notable: Option<&str>,
    ) -> Result<Self, String> {
        let genre = match genre.map(str::trim).filter(|value| !value.is_empty()) {
            None => GenreFilter::Any,
            Some("other") => GenreFilter::Unclassified,
            Some(value) if GENRE_ORDER.contains(&value) => GenreFilter::Genre(value.to_string()),
            Some(value) => return Err(format!("모르는 갈래예요: {value}")),
        };
        let form = match form.map(str::trim).filter(|value| !value.is_empty()) {
            None => None,
            Some(value)
                if value.len() <= 32
                    && value.chars().all(|c| c.is_ascii_lowercase() || c == '_') =>
            {
                Some(value.to_string())
            }
            Some(value) => return Err(format!("모르는 형식이에요: {value}")),
        };
        let sort = match sort.map(str::trim).filter(|value| !value.is_empty()) {
            None | Some("listening") => ComposerPieceSort::Listening,
            Some("catalogue") => ComposerPieceSort::Catalogue,
            Some("year") => ComposerPieceSort::Year,
            Some("notable") => ComposerPieceSort::Notable,
            Some(value) => return Err(format!("모르는 정렬이에요: {value}")),
        };
        let notable_only = matches!(notable.map(str::trim), Some("1" | "true"));

        let mut search_patterns = Vec::new();
        if let Some(text) = SearchText::parse(q) {
            search_patterns.push(text.contains().to_string());
            let mut normalized = normalize_opus(text.exact());
            for (alias, canonical) in SEARCH_ALIASES {
                normalized = normalized.replace(alias, canonical);
            }
            if let Some(other) = SearchText::parse(Some(&normalized)) {
                if other.contains() != text.contains() {
                    search_patterns.push(other.contains().to_string());
                }
            }
        }

        Ok(Self {
            genre,
            form,
            sort,
            search_patterns,
            notable_only,
        })
    }
}

impl PieceService {
    pub async fn get_all_pieces(pool: &DbPool) -> Result<Vec<Piece>, String> {
        PieceRepository::find_all(pool)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_piece_by_id(pool: &DbPool, id: i32) -> Result<Option<Piece>, String> {
        PieceRepository::find_by_id(pool, id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn get_pieces_by_composer(
        pool: &DbPool,
        composer_id: i32,
        range: PieceListRange,
        query: &ComposerPieceQuery,
    ) -> Result<Vec<ComposerPiece>, String> {
        let page = match range {
            PieceListRange::All => None,
            PieceListRange::Page { offset, limit } => Some((offset, limit)),
        };
        PieceRepository::find_composer_pieces(pool, composer_id, query, page)
            .await
            .map(|rows| rows.into_iter().map(ComposerPiece::from).collect())
            .map_err(|e| e.to_string())
    }

    pub async fn get_composer_catalog(
        pool: &DbPool,
        composer_id: i32,
    ) -> Result<ComposerCatalog, String> {
        PieceRepository::composer_catalog(pool, composer_id)
            .await
            .map(ComposerCatalog::from_rows)
            .map_err(|e| e.to_string())
    }

    pub async fn get_piece_parts(pool: &DbPool, piece_id: i32) -> Result<Vec<PiecePart>, String> {
        PieceRepository::find_parts(pool, piece_id)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn search_pieces(
        pool: &DbPool,
        query: Option<&str>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<PieceSearchResult>, String> {
        PieceRepository::search(pool, query, offset, limit)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn create_piece(pool: &DbPool, piece: CreatePiece) -> Result<i32, String> {
        PieceRepository::create(pool, piece)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn update_piece(pool: &DbPool, id: i32, piece: UpdatePiece) -> Result<u64, String> {
        PieceRepository::update(pool, id, piece)
            .await
            .map_err(|e| e.to_string())
    }

    pub async fn delete_piece(pool: &DbPool, id: i32) -> Result<u64, String> {
        PieceRepository::delete(pool, id)
            .await
            .map_err(|e| e.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::{normalize_opus, PieceListRange};
    use crate::piece::model::{ComposerPieceQuery, ComposerPieceSort, GenreFilter};

    #[test]
    fn composer_piece_query_defaults_keep_listening_order() {
        let query = ComposerPieceQuery::parse(None, None, None, None, None).expect("기본값");
        assert_eq!(query.genre, GenreFilter::Any);
        assert_eq!(query.sort, ComposerPieceSort::Listening);
        assert!(query.search_patterns.is_empty());
        assert!(!query.notable_only);
    }

    #[test]
    fn composer_piece_query_reads_genre_form_sort_and_aliases() {
        let query = ComposerPieceQuery::parse(
            Some("piano"),
            Some("nocturne"),
            Some("catalogue"),
            Some("야상곡"),
            Some("1"),
        )
        .expect("값");
        assert_eq!(query.genre, GenreFilter::Genre("piano".to_string()));
        assert_eq!(query.form.as_deref(), Some("nocturne"));
        assert_eq!(query.sort, ComposerPieceSort::Catalogue);
        assert_eq!(query.search_patterns, vec!["%야상곡%", "%녹턴%"]);
        assert!(query.notable_only);

        let other =
            ComposerPieceQuery::parse(Some("other"), None, None, Some("op10"), None).expect("기타");
        assert_eq!(other.genre, GenreFilter::Unclassified);
        assert_eq!(other.search_patterns, vec!["%op10%", "%Op. 10%"]);
    }

    #[test]
    fn composer_piece_query_rejects_unknown_values() {
        assert!(ComposerPieceQuery::parse(Some("jazz"), None, None, None, None).is_err());
        assert!(ComposerPieceQuery::parse(None, Some("No'te"), None, None, None).is_err());
        assert!(ComposerPieceQuery::parse(None, None, Some("random"), None, None).is_err());
    }

    #[test]
    fn opus_shorthand_becomes_data_spelling() {
        assert_eq!(normalize_opus("op 28"), "Op. 28");
        assert_eq!(normalize_opus("Op.9"), "Op. 9");
        assert_eq!(normalize_opus("오페라"), "오페라");
    }

    #[test]
    fn no_page_params_keep_full_list() {
        assert_eq!(PieceListRange::parse(None, None), Ok(PieceListRange::All));
    }

    #[test]
    fn page_params_apply_defaults_and_limits() {
        assert_eq!(
            PieceListRange::parse(Some(40), None),
            Ok(PieceListRange::Page {
                offset: 40,
                limit: 20
            })
        );
        assert_eq!(
            PieceListRange::parse(None, Some(500)),
            Ok(PieceListRange::Page {
                offset: 0,
                limit: 100
            })
        );
        assert_eq!(
            PieceListRange::parse(None, Some(0)),
            Ok(PieceListRange::Page {
                offset: 0,
                limit: 1
            })
        );
    }

    #[test]
    fn negative_offset_is_rejected() {
        assert!(PieceListRange::parse(Some(-1), Some(20)).is_err());
    }
}
