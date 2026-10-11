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
}

/// 작품 검색 결과. 목록에 작곡가를 함께 보여줄 수 있게 이름을 싣는다.
#[derive(Debug, Serialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct PieceSearchResult {
    #[serde(flatten)]
    #[sqlx(flatten)]
    pub piece: Piece,
    pub composer_name: String,
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
    use super::{order_part_tree, LinkedPiece, PiecePart, PiecePartRow};

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
                }
            })
        );
        assert_eq!(
            serde_json::to_value(PiecePart::from(row(2, None, 1))).expect("직렬화")["linkedPiece"],
            serde_json::Value::Null
        );
    }
}
