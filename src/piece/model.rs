use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use std::collections::HashMap;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct Piece {
    pub id: i32,
    pub composer_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    #[serde(rename = "type")]
    pub r#type: String,
    pub description: Option<String>,
    /// 영어판 설명(없으면 null)
    #[sqlx(default)]
    pub description_en: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
    /// 보이는 최상위 part(악장·번호곡) 수. 0이면 낱곡이고, 1 이상이면 `/pieces/<id>/parts` 로 펼친다.
    #[serde(default)]
    pub part_count: i64,
    /// part 종류. "movement"(전부 악장 번호가 있음, 예: 4악장) | "work"(예: 12곡) | part 가 없으면 None
    #[serde(default)]
    pub part_kind: Option<String>,
    /// 작품 목록 체계와 번호(예: "Op." "10", "K." "331"). 없으면 opus_number 를 쓴다
    #[sqlx(default)]
    #[serde(default)]
    pub catalogue_system: Option<String>,
    #[sqlx(default)]
    #[serde(default)]
    pub catalogue_number: Option<String>,
    /// 장르 7종(symphony·concerto·piano·chamber·orchestral·stage·vocal). 못 정한 작품은 None 이고
    /// 작곡가 화면은 '기타'로 묶는다.
    #[sqlx(default)]
    #[serde(default)]
    pub genre: Option<String>,
    /// 갈래 안 형식(`piece_forms.form_key`, 예: nocturne·string_quartet). 장르가 없으면 None
    #[sqlx(default)]
    #[serde(default)]
    pub form_key: Option<String>,
    /// 대표곡 표시. 목록 순서는 바꾸지 않고 표시만 한다
    #[sqlx(default)]
    #[serde(default)]
    pub notable: bool,
}

/// 작곡가 작품 목록 정렬.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ComposerPieceSort {
    /// 손본 작품 → 들을 거리 있는 작품 → 나머지, 그 안은 작품번호순(기존 기본값)
    Listening,
    /// 작품번호순
    Catalogue,
    /// 작곡 연도순(연도 없는 작품은 뒤), 같으면 작품번호순
    Year,
    /// 대표곡(세트 안 대표 곡 포함) → 손본 작품 → 유명도(위키데이터 언어판 수) → 작품번호순
    Notable,
    /// 검색 관련도: 제목 일치 → 제목 접두사 → 제목·영어 제목 포함 → 작품번호 → 별칭 → 세트 안 곡 이름,
    /// 같으면 대표곡·유명도·작품번호순. 검색어가 없으면 작품번호순과 같다
    Relevance,
}

/// 작곡가 작품 목록의 갈래 거르기.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum GenreFilter {
    Any,
    /// 장르를 못 정한 작품(화면의 '기타', 쿼리 `unclassified`)
    Unclassified,
    /// 옛 앱(1.3.2 이하)의 '기타'(쿼리 `other`). 그 앱은 사운드트랙을 몰라 '기타'로 보이므로 함께 준다
    UnclassifiedOrScreen,
    Genre(String),
}

/// `/composers/<id>/pieces` 의 거르기·정렬·검색. 검색은 LIKE 패턴(별칭을 고친 것 포함)이다.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ComposerPieceQuery {
    pub genre: GenreFilter,
    pub form: Option<String>,
    pub sort: ComposerPieceSort,
    /// 검색어 전체의 LIKE 패턴(별칭을 고친 것 포함). 관련도와 걸린 세트 안 곡에 쓴다
    pub search_patterns: Vec<String>,
    /// 띄어 쓴 낱말마다의 LIKE 패턴들. 모든 낱말이 맞아야 걸린다(「소나타 열정」)
    pub search_tokens: Vec<Vec<String>>,
    pub notable_only: bool,
}

impl ComposerPieceQuery {
    /// 거르기·검색 없는 기본 목록(손본 작품 먼저). 기존 호출과 같다.
    pub fn listing() -> Self {
        Self {
            genre: GenreFilter::Any,
            form: None,
            sort: ComposerPieceSort::Listening,
            search_patterns: Vec::new(),
            search_tokens: Vec::new(),
            notable_only: false,
        }
    }
}

/// 작곡가 작품 목록 한 줄. 작품에 세트 안 대표 곡 번호와, 검색어가 걸린 세트 안 곡을 더한다.
#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ComposerPiece {
    #[serde(flatten)]
    pub piece: Piece,
    /// 대표 곡으로 표시한 세트 안 곡(최상위 part)의 sequence_number. 없으면 빈 목록
    pub notable_parts: Vec<i32>,
    /// 검색어가 세트 안 곡 이름에 걸렸으면 그 곡. 검색하지 않으면 None
    pub matched_part: Option<MatchedPart>,
}

#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct MatchedPart {
    pub sequence_number: i32,
    pub name: String,
}

#[derive(Debug, FromRow)]
pub struct ComposerPieceRow {
    #[sqlx(flatten)]
    pub piece: Piece,
    pub notable_part_numbers: Option<String>,
    #[sqlx(default)]
    pub matched_part_sequence: Option<i32>,
    #[sqlx(default)]
    pub matched_part_name: Option<String>,
}

impl From<ComposerPieceRow> for ComposerPiece {
    fn from(row: ComposerPieceRow) -> Self {
        let notable_parts = row
            .notable_part_numbers
            .as_deref()
            .unwrap_or("")
            .split(',')
            .filter_map(|value| value.trim().parse::<i32>().ok())
            .collect();
        let matched_part =
            row.matched_part_sequence
                .zip(row.matched_part_name)
                .map(|(sequence_number, name)| MatchedPart {
                    sequence_number,
                    name,
                });
        Self {
            piece: row.piece,
            notable_parts,
            matched_part,
        }
    }
}

/// 장르(7종 + 사운드트랙)의 화면 순서. 작곡가 화면은 대표곡이 많은 갈래부터, 같으면 작품 수가 많은 갈래부터,
/// 그것도 같으면 이 순서로 보인다.
pub const GENRE_ORDER: [&str; 8] = [
    "symphony",
    "concerto",
    "piano",
    "chamber",
    "orchestral",
    "stage",
    "vocal",
    "screen",
];

#[derive(Debug, FromRow)]
pub struct CatalogRow {
    pub genre: Option<String>,
    pub form_key: Option<String>,
    pub form_name: Option<String>,
    pub form_order: Option<i32>,
    pub piece_count: i64,
    pub notable_count: i64,
}

/// `/composers/<id>/catalog`: 작곡가 작품의 갈래·형식별 개수와 「처음 듣는다면」. 작품 목록 없이 준다.
#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct ComposerCatalog {
    pub total: i64,
    pub notable_total: i64,
    pub genres: Vec<CatalogGenre>,
    /// 「처음 듣는다면」: 사람이 확인해 공개한(PUBLISHED) 작품을 순서대로 최대 10곡.
    /// 숨긴 작품은 빼고, 검색어(q)로 센 응답에는 싣지 않아 빈 목록이다
    pub highlights: Vec<ComposerHighlight>,
}

/// 「처음 듣는다면」 한 곡. 작곡가 화면 작품 목록 한 줄(최상위 작품)을 가리킨다.
#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct ComposerHighlight {
    pub piece_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    /// 장르 7종. 못 정한 작품은 None
    pub genre: Option<String>,
    pub form_key: Option<String>,
    pub opus_number: Option<String>,
    pub catalogue_system: Option<String>,
    pub catalogue_number: Option<String>,
    pub composition_year: Option<i32>,
    /// 보이는 최상위 part 수와 종류(`Piece.part_count`·`part_kind` 와 같다)
    pub part_count: i64,
    pub part_kind: Option<String>,
    /// 세트면 대표 곡(최상위 part, 예: 녹턴 Op. 9 의 2번). 없거나 확인 전 곡이면 None
    pub part: Option<HighlightPart>,
    /// 비교 화면에 공개 구간이 뜨는지. 작품 자체나 대표 곡으로 이어진 작품 중 하나라도 뜨면 true
    pub comparable: bool,
    /// 비교 화면으로 열 작품. 작품 자체가 비교되면 그 작품, 아니면 대표 곡으로 이어진 작품
    pub compare_piece_id: Option<i32>,
    /// 한 줄 이유(사실 한 줄). 근거가 없어 비워 둔 곡은 None
    pub reason: Option<String>,
    pub reason_en: Option<String>,
}

#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct HighlightPart {
    pub sequence_number: i32,
    /// 화면 이름. 한국어 이름 → 영어 이름 → 이어진 작품 제목 순(`PiecePart.name` 과 같다)
    pub name: String,
    pub name_en: Option<String>,
}

/// `composer_highlights` 를 작품·대표 곡과 이은 행.
#[derive(Debug, FromRow)]
pub struct HighlightRow {
    pub piece_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    pub genre: Option<String>,
    pub form_key: Option<String>,
    pub opus_number: Option<String>,
    pub catalogue_system: Option<String>,
    pub catalogue_number: Option<String>,
    pub composition_year: Option<i32>,
    pub part_count: i64,
    pub part_kind: Option<String>,
    pub part_number: Option<i32>,
    pub part_name_ko: Option<String>,
    pub part_name_en: Option<String>,
    pub part_linked_title: Option<String>,
    pub compare_piece_id: Option<i32>,
    pub reason: Option<String>,
    pub reason_en: Option<String>,
}

fn non_blank(value: Option<String>) -> Option<String> {
    value
        .map(|text| text.trim().to_string())
        .filter(|text| !text.is_empty())
}

impl From<HighlightRow> for ComposerHighlight {
    fn from(row: HighlightRow) -> Self {
        let name_en = non_blank(row.part_name_en);
        let part = row.part_number.map(|sequence_number| HighlightPart {
            sequence_number,
            name: non_blank(row.part_name_ko)
                .or_else(|| name_en.clone())
                .or_else(|| non_blank(row.part_linked_title))
                .unwrap_or_default(),
            name_en,
        });
        Self {
            piece_id: row.piece_id,
            title: row.title,
            title_en: row.title_en,
            genre: row.genre,
            form_key: row.form_key,
            opus_number: row.opus_number,
            catalogue_system: row.catalogue_system,
            catalogue_number: row.catalogue_number,
            composition_year: row.composition_year,
            part_count: row.part_count,
            part_kind: row.part_kind,
            part,
            comparable: row.compare_piece_id.is_some(),
            compare_piece_id: row.compare_piece_id,
            reason: non_blank(row.reason),
            reason_en: non_blank(row.reason_en),
        }
    }
}

#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct CatalogGenre {
    /// 장르 키. None 은 장르를 못 정한 작품('기타')이다
    pub genre: Option<String>,
    pub count: i64,
    pub notable_count: i64,
    /// 형식별 개수(piece_forms.sort_order 순). '기타'는 빈 목록
    pub forms: Vec<CatalogForm>,
}

#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct CatalogForm {
    pub form_key: String,
    pub name: String,
    pub count: i64,
    pub notable_count: i64,
}

impl ComposerCatalog {
    /// 갈래는 대표곡 수 → 작품 수가 많은 순(같으면 `GENRE_ORDER`), '기타'는 맨 뒤다. 형식은 사전 순서다.
    pub fn from_rows(mut rows: Vec<CatalogRow>) -> Self {
        rows.sort_by(|a, b| {
            a.form_order
                .unwrap_or(i32::MAX)
                .cmp(&b.form_order.unwrap_or(i32::MAX))
                .then_with(|| a.form_key.cmp(&b.form_key))
        });
        let mut genres: Vec<CatalogGenre> = Vec::new();
        for row in rows {
            let index = match genres.iter().position(|genre| genre.genre == row.genre) {
                Some(index) => index,
                None => {
                    genres.push(CatalogGenre {
                        genre: row.genre.clone(),
                        count: 0,
                        notable_count: 0,
                        forms: Vec::new(),
                    });
                    genres.len() - 1
                }
            };
            let genre = &mut genres[index];
            genre.count += row.piece_count;
            genre.notable_count += row.notable_count;
            if row.genre.is_some() {
                genre.forms.push(CatalogForm {
                    form_key: row.form_key.unwrap_or_else(|| "other".to_string()),
                    name: row.form_name.unwrap_or_else(|| "그 밖의 곡".to_string()),
                    count: row.piece_count,
                    notable_count: row.notable_count,
                });
            }
        }
        let rank = |genre: &Option<String>| -> usize {
            genre
                .as_deref()
                .and_then(|key| GENRE_ORDER.iter().position(|known| *known == key))
                .unwrap_or(GENRE_ORDER.len())
        };
        genres.sort_by(|a, b| {
            a.genre
                .is_none()
                .cmp(&b.genre.is_none())
                .then_with(|| b.notable_count.cmp(&a.notable_count))
                .then_with(|| b.count.cmp(&a.count))
                .then_with(|| rank(&a.genre).cmp(&rank(&b.genre)))
        });
        Self {
            total: genres.iter().map(|genre| genre.count).sum(),
            notable_total: genres.iter().map(|genre| genre.notable_count).sum(),
            genres,
            highlights: Vec::new(),
        }
    }
}

/// 작품 검색 결과. 목록에 작곡가를 함께 보여줄 수 있게 이름을 싣는다.
#[derive(Debug, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct PieceSearchResult {
    #[serde(flatten)]
    #[sqlx(flatten)]
    pub piece: Piece,
    pub composer_name: String,
    /// 영어판 작곡가 이름
    #[sqlx(default)]
    pub composer_name_en: Option<String>,
    /// 검색 결과 작품 행에 작곡가 초상을 얼굴로 쓴다
    pub composer_avatar_url: Option<String>,
}

/// 묶음 작품 안의 곡 하나(악장·번호곡).
#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct PiecePart {
    pub id: u64,
    pub parent_part_id: Option<u64>,
    pub sequence_number: i32,
    pub movement_number: Option<String>,
    /// 화면에 쓸 이름. 한국어 이름 → 영어 이름 → 이어진 작품 제목 순으로 고른다
    pub name: String,
    pub name_ko: Option<String>,
    pub name_en: Option<String>,
    /// 이 곡이 따로 작품 행으로 있으면 그 작품. 눌러서 그 작품 화면으로 간다
    pub linked_piece: Option<LinkedPiece>,
    /// 세트 안 대표 곡 표시
    pub notable: bool,
    /// 이 곡의 Apple Music 트랙 링크. 이어진 작품이 있으면 그 작품 링크(`linked_piece`)를 쓴다
    pub apple_music_url: Option<String>,
    /// 이 곡의 Spotify 트랙 링크. 쓰는 법은 `apple_music_url` 과 같다
    pub spotify_url: Option<String>,
}

#[derive(Debug, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct LinkedPiece {
    pub id: i32,
    pub title: String,
    /// 비교 화면에 공개 구간이 하나라도 뜨는지. 비교 카탈로그와 같은 공개 기준이다
    pub comparable: bool,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
}

#[derive(Debug, FromRow)]
pub struct PiecePartRow {
    pub id: u64,
    pub parent_part_id: Option<u64>,
    pub sequence_number: i32,
    pub movement_number: Option<String>,
    pub name_ko: Option<String>,
    pub name_en: Option<String>,
    pub linked_piece_id: Option<i32>,
    pub linked_title: Option<String>,
    pub linked_comparable: i64,
    pub linked_spotify_url: Option<String>,
    pub linked_apple_music_url: Option<String>,
    pub notable: bool,
    pub apple_music_url: Option<String>,
    pub spotify_url: Option<String>,
}

impl From<PiecePartRow> for PiecePart {
    fn from(row: PiecePartRow) -> Self {
        let linked_piece = row
            .linked_piece_id
            .zip(row.linked_title)
            .map(|(id, title)| LinkedPiece {
                id,
                title,
                comparable: row.linked_comparable != 0,
                spotify_url: row.linked_spotify_url,
                apple_music_url: row.linked_apple_music_url,
            });
        let name = [row.name_ko.as_deref(), row.name_en.as_deref()]
            .into_iter()
            .flatten()
            .map(str::trim)
            .find(|name| !name.is_empty())
            .map(str::to_string)
            .or_else(|| linked_piece.as_ref().map(|piece| piece.title.clone()))
            .unwrap_or_default();

        Self {
            id: row.id,
            parent_part_id: row.parent_part_id,
            sequence_number: row.sequence_number,
            movement_number: row.movement_number,
            name,
            name_ko: row.name_ko,
            name_en: row.name_en,
            linked_piece,
            notable: row.notable,
            apple_music_url: row.apple_music_url,
            spotify_url: row.spotify_url,
        }
    }
}

/// part 를 화면 순서로 편다. 같은 부모 아래는 sequence_number(같으면 id) 순이고,
/// 자식은 부모 바로 뒤에 온다.
///
/// 최상위 part 에서 닿지 않는 part 는 뺀다. 부모가 숨긴 상태(확인 전 시드)라 목록에 없으면
/// 그 아래도 숨긴다. 그래야 최상위 개수(`part_count`)와 펼친 목록의 최상위가 같다.
pub fn order_part_tree(rows: Vec<PiecePartRow>) -> Vec<PiecePartRow> {
    let mut children: HashMap<Option<u64>, Vec<PiecePartRow>> = HashMap::new();
    for row in rows {
        children.entry(row.parent_part_id).or_default().push(row);
    }
    for siblings in children.values_mut() {
        siblings.sort_by_key(|row| (row.sequence_number, row.id));
    }

    let mut ordered = Vec::new();
    // 뒤에서 꺼내므로 형제를 거꾸로 쌓는다
    let mut stack: Vec<PiecePartRow> = children.remove(&None).unwrap_or_default();
    stack.reverse();
    while let Some(row) = stack.pop() {
        if let Some(mut kids) = children.remove(&Some(row.id)) {
            kids.reverse();
            stack.extend(kids);
        }
        ordered.push(row);
    }
    ordered
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct CreatePiece {
    pub composer_id: i32,
    pub title: String,
    pub title_en: Option<String>,
    #[serde(rename = "type")]
    pub r#type: String,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}

#[derive(Debug, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct UpdatePiece {
    pub title: Option<String>,
    pub title_en: Option<String>,
    #[serde(rename = "type")]
    pub r#type: Option<String>,
    pub description: Option<String>,
    pub opus_number: Option<String>,
    pub composition_year: Option<i32>,
    pub difficulty_level: Option<i32>,
    pub duration_minutes: Option<i32>,
    pub spotify_url: Option<String>,
    pub apple_music_url: Option<String>,
    pub youtube_music_url: Option<String>,
}

#[cfg(test)]
mod tests {
    use super::{
        order_part_tree, ComposerCatalog, ComposerHighlight, HighlightPart, HighlightRow,
        LinkedPiece, PiecePart, PiecePartRow,
    };

    fn highlight_row(piece_id: i32) -> HighlightRow {
        HighlightRow {
            piece_id,
            title: "녹턴 Op. 9".to_string(),
            title_en: Some("Nocturnes, Op. 9".to_string()),
            genre: Some("piano".to_string()),
            form_key: Some("nocturne".to_string()),
            opus_number: None,
            catalogue_system: Some("Op.".to_string()),
            catalogue_number: Some("9".to_string()),
            composition_year: Some(1832),
            part_count: 3,
            part_kind: Some("work".to_string()),
            part_number: None,
            part_name_ko: None,
            part_name_en: None,
            part_linked_title: None,
            compare_piece_id: None,
            reason: None,
            reason_en: None,
        }
    }

    #[test]
    fn highlight_keeps_representative_part_and_compare_target() {
        let mut row = highlight_row(26068);
        row.part_number = Some(2);
        row.part_name_ko = Some("  ".to_string());
        row.part_name_en = Some("No. 2 in E-flat major".to_string());
        row.part_linked_title = Some("녹턴 E♭장조".to_string());
        row.compare_piece_id = Some(131);
        row.reason = Some("세 곡 가운데 가장 많이 녹음된 곡".to_string());
        row.reason_en = Some("   ".to_string());

        let highlight = ComposerHighlight::from(row);
        assert_eq!(
            highlight.part,
            Some(HighlightPart {
                sequence_number: 2,
                name: "No. 2 in E-flat major".to_string(),
                name_en: Some("No. 2 in E-flat major".to_string()),
            })
        );
        assert!(highlight.comparable);
        assert_eq!(highlight.compare_piece_id, Some(131));
        assert_eq!(
            highlight.reason.as_deref(),
            Some("세 곡 가운데 가장 많이 녹음된 곡")
        );
        assert_eq!(highlight.reason_en, None, "빈 이유는 비운다");
    }

    #[test]
    fn highlight_part_name_falls_back_to_linked_title() {
        let mut row = highlight_row(26069);
        row.part_number = Some(3);
        row.part_linked_title = Some("연습곡 Op. 10, No. 3 \"이별의 곡\"".to_string());
        let part = ComposerHighlight::from(row).part.expect("대표 곡");
        assert_eq!(part.name, "연습곡 Op. 10, No. 3 \"이별의 곡\"");
        assert_eq!(part.name_en, None);
    }

    #[test]
    fn highlight_serializes_with_camel_case_contract() {
        let json =
            serde_json::to_value(ComposerHighlight::from(highlight_row(26068))).expect("직렬화");
        assert_eq!(
            json,
            serde_json::json!({
                "pieceId": 26068,
                "title": "녹턴 Op. 9",
                "titleEn": "Nocturnes, Op. 9",
                "genre": "piano",
                "formKey": "nocturne",
                "opusNumber": null,
                "catalogueSystem": "Op.",
                "catalogueNumber": "9",
                "compositionYear": 1832,
                "partCount": 3,
                "partKind": "work",
                "part": null,
                "comparable": false,
                "comparePieceId": null,
                "reason": null,
                "reasonEn": null
            })
        );
    }

    #[test]
    fn catalog_starts_without_highlights() {
        let catalog = ComposerCatalog::from_rows(Vec::new());
        assert!(catalog.highlights.is_empty());
        let json = serde_json::to_value(&catalog).expect("직렬화");
        assert_eq!(json["highlights"], serde_json::json!([]));
    }

    fn row(id: u64, parent: Option<u64>, sequence: i32) -> PiecePartRow {
        PiecePartRow {
            id,
            parent_part_id: parent,
            sequence_number: sequence,
            movement_number: None,
            name_ko: None,
            name_en: Some(format!("part {id}")),
            linked_piece_id: None,
            linked_title: None,
            linked_comparable: 0,
            linked_spotify_url: None,
            linked_apple_music_url: None,
            notable: false,
            apple_music_url: None,
            spotify_url: None,
        }
    }

    fn ids(rows: &[PiecePartRow]) -> Vec<u64> {
        rows.iter().map(|row| row.id).collect()
    }

    #[test]
    fn children_follow_their_parent_in_sequence_order() {
        let rows = vec![
            row(10, None, 2),
            row(11, Some(10), 2),
            row(1, None, 1),
            row(12, Some(10), 1),
            row(3, Some(1), 1),
            row(20, None, 3),
        ];

        assert_eq!(ids(&order_part_tree(rows)), vec![1, 3, 10, 12, 11, 20]);
    }

    #[test]
    fn same_sequence_falls_back_to_id() {
        let rows = vec![row(5, None, 1), row(4, None, 1)];

        assert_eq!(ids(&order_part_tree(rows)), vec![4, 5]);
    }

    #[test]
    fn parts_under_a_hidden_parent_are_dropped() {
        // 30 의 부모 99 는 숨긴 상태라 목록에 없다. 31 은 30 아래, 7·8 은 서로를 가리킨다
        let rows = vec![
            row(1, None, 1),
            row(30, Some(99), 1),
            row(31, Some(30), 1),
            row(7, Some(8), 1),
            row(8, Some(7), 2),
            row(2, Some(1), 1),
        ];

        assert_eq!(ids(&order_part_tree(rows)), vec![1, 2]);
    }

    #[test]
    fn display_name_prefers_korean_then_english_then_linked_title() {
        let mut korean = row(1, None, 1);
        korean.name_ko = Some("12번 C단조 \"혁명\"".to_string());
        assert_eq!(PiecePart::from(korean).name, "12번 C단조 \"혁명\"");

        let mut blank_korean = row(2, None, 2);
        blank_korean.name_ko = Some("  ".to_string());
        assert_eq!(PiecePart::from(blank_korean).name, "part 2");

        let mut linked_only = row(3, None, 3);
        linked_only.name_en = None;
        linked_only.linked_piece_id = Some(127);
        linked_only.linked_title = Some("연습곡 Op. 10, No. 12 \"혁명\"".to_string());
        linked_only.linked_comparable = 1;
        let part = PiecePart::from(linked_only);
        assert_eq!(part.name, "연습곡 Op. 10, No. 12 \"혁명\"");
        assert_eq!(
            part.linked_piece,
            Some(LinkedPiece {
                id: 127,
                title: "연습곡 Op. 10, No. 12 \"혁명\"".to_string(),
                comparable: true,
                spotify_url: None,
                apple_music_url: None,
            })
        );
    }

    #[test]
    fn part_serializes_with_camel_case_contract() {
        let mut linked = row(9, Some(1), 4);
        linked.movement_number = Some("12".to_string());
        linked.linked_piece_id = Some(127);
        linked.linked_title = Some("혁명".to_string());
        linked.linked_spotify_url = Some("https://open.spotify.com/track/x".to_string());
        linked.apple_music_url = Some("https://music.apple.com/us/album/x/1?i=2".to_string());
        linked.spotify_url = Some("https://open.spotify.com/track/y".to_string());

        let json = serde_json::to_value(PiecePart::from(linked)).expect("직렬화");
        assert_eq!(
            json,
            serde_json::json!({
                "id": 9,
                "parentPartId": 1,
                "sequenceNumber": 4,
                "movementNumber": "12",
                "name": "part 9",
                "nameKo": null,
                "nameEn": "part 9",
                "linkedPiece": {
                    "id": 127,
                    "title": "혁명",
                    "comparable": false,
                    "spotifyUrl": "https://open.spotify.com/track/x",
                    "appleMusicUrl": null
                },
                "notable": false,
                "appleMusicUrl": "https://music.apple.com/us/album/x/1?i=2",
                "spotifyUrl": "https://open.spotify.com/track/y"
            })
        );
        assert_eq!(
            serde_json::to_value(PiecePart::from(row(2, None, 1))).expect("직렬화")["linkedPiece"],
            serde_json::Value::Null
        );
    }
}
