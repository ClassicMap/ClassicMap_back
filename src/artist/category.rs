//! 아티스트 분류 코드 표.
//!
//! 수동 데이터는 영문 역할 코드(`pianist`)를, 국제 시드는 위키데이터 한국어 악기명(`피아노`)을
//! 저장한다. DB 원본은 그대로 두고 응답·필터·검색이 모두 이 표 하나로 코드를 정한다.
//! 표에 없는 원본은 `other`로 내보내 필터 칩이 다시 쪼개지지 않게 한다.

use crate::logger::Logger;
use serde::Serializer;

pub const OTHER_CATEGORY: &str = "other";

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ArtistCategory {
    pub code: &'static str,
    /// 검색어 매칭에만 쓴다. 화면 라벨은 프론트가 코드로 정한다.
    pub label_ko: &'static str,
    /// 코드 자신 외에 이 코드로 묶이는 DB 원본 값.
    pub source_values: &'static [&'static str],
}

pub const ARTIST_CATEGORIES: &[ArtistCategory] = &[
    ArtistCategory {
        code: "pianist",
        label_ko: "피아니스트",
        source_values: &["피아노", "피아니스트"],
    },
    ArtistCategory {
        code: "violinist",
        label_ko: "바이올리니스트",
        source_values: &["바이올린"],
    },
    ArtistCategory {
        code: "violist",
        label_ko: "비올리스트",
        source_values: &["비올라"],
    },
    ArtistCategory {
        code: "cellist",
        label_ko: "첼리스트",
        source_values: &["첼로"],
    },
    ArtistCategory {
        code: "double_bassist",
        label_ko: "더블베이시스트",
        source_values: &["콘트라베이스"],
    },
    ArtistCategory {
        code: "guitarist",
        label_ko: "기타리스트",
        source_values: &["기타"],
    },
    ArtistCategory {
        code: "harpist",
        label_ko: "하피스트",
        source_values: &["하프"],
    },
    ArtistCategory {
        code: "flutist",
        label_ko: "플루티스트",
        source_values: &["플루트"],
    },
    ArtistCategory {
        code: "oboist",
        label_ko: "오보이스트",
        source_values: &["오보에"],
    },
    ArtistCategory {
        code: "clarinetist",
        label_ko: "클라리네티스트",
        source_values: &["클라리넷"],
    },
    ArtistCategory {
        code: "bassoonist",
        label_ko: "바수니스트",
        source_values: &["바순"],
    },
    ArtistCategory {
        code: "saxophonist",
        label_ko: "색소포니스트",
        source_values: &["색소폰"],
    },
    ArtistCategory {
        code: "hornist",
        label_ko: "호르니스트",
        source_values: &["호른"],
    },
    ArtistCategory {
        code: "percussionist",
        label_ko: "타악기 연주자",
        source_values: &["타악기", "마림바"],
    },
    ArtistCategory {
        code: "recorder_player",
        label_ko: "리코더 연주자",
        source_values: &["리코더"],
    },
    ArtistCategory {
        code: "gambist",
        label_ko: "비올라 다 감바 연주자",
        source_values: &["비올족"],
    },
    ArtistCategory {
        code: "vocalist",
        label_ko: "성악가",
        source_values: &["목소리", "soprano", "mezzo_soprano", "tenor", "baritone", "bass-baritone"],
    },
    ArtistCategory {
        code: "conductor",
        label_ko: "지휘자",
        source_values: &[],
    },
    ArtistCategory {
        code: "orchestra",
        label_ko: "오케스트라",
        source_values: &[],
    },
];

impl ArtistCategory {
    /// 코드 자신을 포함해 이 코드로 묶이는 원본 값 전부.
    pub fn stored_values(&self) -> impl Iterator<Item = &'static str> {
        std::iter::once(self.code).chain(self.source_values.iter().copied())
    }
}

/// DB 원본 값의 코드. 표에 없으면 `None`.
pub fn known_code(stored: &str) -> Option<&'static str> {
    let stored = stored.trim();
    ARTIST_CATEGORIES
        .iter()
        .find(|category| category.stored_values().any(|value| value == stored))
        .map(|category| category.code)
}

/// 응답에 쓸 코드. 표에 없으면 `other`로 내보내고 경고를 남긴다.
pub fn response_code(stored: &str) -> &'static str {
    known_code(stored).unwrap_or_else(|| {
        if stored.trim() != OTHER_CATEGORY {
            Logger::warn(
                "ARTIST_CATEGORY",
                &format!("분류 표에 없는 category 값을 other로 내보냄: {stored:?}"),
            );
        }
        OTHER_CATEGORY
    })
}

pub fn serialize_category<S: Serializer>(stored: &str, serializer: S) -> Result<S::Ok, S::Error> {
    serializer.serialize_str(response_code(stored))
}

/// `category=` 필터를 SQL 조건으로 바꾼 결과.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum CategoryFilter {
    /// `category IN (...)`
    AnyOf(Vec<&'static str>),
    /// `other`: `category NOT IN (...)`
    NoneOf(Vec<&'static str>),
}

impl CategoryFilter {
    /// 코드를 받는다. 기존 호출 호환을 위해 표에 있는 원본 값도 그 코드로 받는다.
    pub fn parse(value: &str) -> Result<Self, String> {
        let value = value.trim();
        if value == OTHER_CATEGORY {
            return Ok(Self::NoneOf(all_stored_values()));
        }

        let code = known_code(value).ok_or_else(|| format!("지원하지 않는 category: {value}"))?;
        let category = ARTIST_CATEGORIES
            .iter()
            .find(|category| category.code == code)
            .expect("known_code는 표에 있는 코드만 준다");

        Ok(Self::AnyOf(category.stored_values().collect()))
    }

    pub fn sql(&self, column: &str) -> String {
        let (operator, values) = match self {
            Self::AnyOf(values) => ("IN", values),
            Self::NoneOf(values) => ("NOT IN", values),
        };
        let placeholders = vec!["?"; values.len()].join(", ");
        format!("{column} {operator} ({placeholders})")
    }

    pub fn values(&self) -> &[&'static str] {
        match self {
            Self::AnyOf(values) | Self::NoneOf(values) => values,
        }
    }
}

fn all_stored_values() -> Vec<&'static str> {
    ARTIST_CATEGORIES
        .iter()
        .flat_map(ArtistCategory::stored_values)
        .collect()
}

/// 검색어가 코드나 한국어 라벨에 들어가는 분류의 원본 값(`피아` → 피아노·피아니스트·pianist).
pub fn stored_values_matching_label(query: &str) -> Vec<&'static str> {
    let query = query.trim().to_lowercase();
    if query.is_empty() {
        return Vec::new();
    }

    ARTIST_CATEGORIES
        .iter()
        .filter(|category| category.code.contains(&query) || category.label_ko.contains(&query))
        .flat_map(ArtistCategory::stored_values)
        .collect()
}

#[cfg(test)]
mod tests {
    use super::{
        known_code, response_code, stored_values_matching_label, CategoryFilter, ARTIST_CATEGORIES,
        OTHER_CATEGORY,
    };
    use std::collections::HashSet;

    #[test]
    fn codes_and_stored_values_are_unique() {
        let mut codes = HashSet::new();
        let mut values = HashSet::new();
        for category in ARTIST_CATEGORIES {
            assert!(codes.insert(category.code), "{}", category.code);
            assert_ne!(category.code, OTHER_CATEGORY);
            for value in category.stored_values() {
                assert!(values.insert(value), "{value}");
            }
        }
    }

    #[test]
    fn stored_values_map_to_codes() {
        assert_eq!(known_code("pianist"), Some("pianist"));
        assert_eq!(known_code("피아노"), Some("pianist"));
        assert_eq!(known_code("피아니스트"), Some("pianist"));
        assert_eq!(known_code("목소리"), Some("vocalist"));
        // 비교 시드 수동 등록분은 음역을 그대로 적었다
        assert_eq!(known_code("mezzo_soprano"), Some("vocalist"));
        assert_eq!(known_code("baritone"), Some("vocalist"));
        assert_eq!(known_code("bass-baritone"), Some("vocalist"));
        assert_eq!(known_code("기타"), Some("guitarist"));
        assert_eq!(known_code("conductor"), Some("conductor"));
    }

    #[test]
    fn unknown_values_are_sent_as_other() {
        assert_eq!(known_code("테오르보"), None);
        assert_eq!(response_code("테오르보"), OTHER_CATEGORY);
        assert_eq!(response_code(OTHER_CATEGORY), OTHER_CATEGORY);
    }

    #[test]
    fn filter_expands_code_to_stored_values() {
        let filter = CategoryFilter::parse("pianist").expect("코드 필터");
        assert_eq!(filter.values(), ["pianist", "피아노", "피아니스트"]);
        assert_eq!(filter.sql("category"), "category IN (?, ?, ?)");

        assert_eq!(CategoryFilter::parse("피아노"), Ok(filter));
        assert!(CategoryFilter::parse("unknown").is_err());
    }

    #[test]
    fn other_filter_excludes_every_known_value() {
        let filter = CategoryFilter::parse("other").expect("other 필터");
        assert!(matches!(filter, CategoryFilter::NoneOf(_)));
        assert!(filter.values().contains(&"목소리"));
        assert!(filter.sql("category").starts_with("category NOT IN (?"));
    }

    #[test]
    fn label_search_finds_grouped_values() {
        let values = stored_values_matching_label("피아");
        assert!(values.contains(&"pianist"));
        assert!(values.contains(&"피아노"));
        assert!(stored_values_matching_label("성악").contains(&"목소리"));
        assert!(stored_values_matching_label("Conduct").contains(&"conductor"));
        assert!(stored_values_matching_label("  ").is_empty());
    }
}
