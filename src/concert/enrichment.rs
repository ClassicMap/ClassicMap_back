//! KOPIS 공연 데이터 보강: 출연진 문자열을 이름 목록으로 나누고, 제목과 출연 아티스트 분류로 편성을 붙인다.

use crate::artist::category::known_code;

/// 출연진 문자열의 구분자. KOPIS `prfcast`는 대개 쉼표지만 가운뎃점·슬래시·줄바꿈도 섞인다.
const CAST_SEPARATORS: &[char] = &[',', '，', '、', '·', '/', '\n', '&', ';', '|'];

/// "홍길동, 김철수 등" → ["홍길동", "김철수"].
/// 괄호 안 역할 표기, 끝의 "등"·"외 N명"을 떼고, 두 글자 미만은 버린다. 순서를 지키며 중복은 한 번만 남긴다.
pub fn split_cast_names(cast: &str) -> Vec<String> {
    let mut names: Vec<String> = Vec::new();
    for raw in cast.split(CAST_SEPARATORS) {
        let without_brackets = strip_brackets(raw);
        let name = collapse_spaces(strip_trailing_etc(without_brackets.trim()));
        if name.chars().count() < 2 || names.contains(&name) {
            continue;
        }
        names.push(name);
    }
    names
}

fn strip_brackets(value: &str) -> String {
    let mut depth = 0usize;
    let mut out = String::with_capacity(value.len());
    for ch in value.chars() {
        match ch {
            '(' | '[' | '（' | '【' | '〈' | '<' => depth += 1,
            ')' | ']' | '）' | '】' | '〉' | '>' => depth = depth.saturating_sub(1),
            _ if depth == 0 => out.push(ch),
            _ => {}
        }
    }
    out
}

fn strip_trailing_etc(value: &str) -> &str {
    let mut name = value.trim_end();
    if let Some(pos) = name.rfind(" 외") {
        let tail = name[pos + " 외".len()..].trim();
        let count_only = tail
            .strip_suffix('명')
            .map(|digits| !digits.trim().is_empty() && digits.trim().chars().all(|c| c.is_ascii_digit()))
            .unwrap_or(false);
        if tail.is_empty() || tail == "다수" || count_only {
            name = name[..pos].trim_end();
        }
    }
    if let Some(stripped) = name.strip_suffix('등') {
        name = stripped.trim_end();
    }
    name
}

fn collapse_spaces(value: &str) -> String {
    value.split_whitespace().collect::<Vec<_>>().join(" ")
}

/// 편성 코드. 프론트 공연 필터와 같은 목록이다. 저장·응답 순서도 이 순서를 따른다.
pub const INSTRUMENT_CODES: &[&str] = &[
    "piano",
    "strings",
    "winds",
    "vocal",
    "choir",
    "orchestra",
    "chamber",
    "opera",
    "crossover",
];

pub fn is_instrument_code(value: &str) -> bool {
    INSTRUMENT_CODES.contains(&value)
}

/// 제목 키워드. 소문자로 바꾼 제목에서 찾는다.
/// '기타'는 "그 밖의"라는 뜻으로도 쓰여 악기로 확실한 표현만 쓰고, '베이스'(콘트라베이스·성악)와 '알토'(성악·색소폰)는
/// 겹쳐서, '관악'은 '관악구' 같은 지명과 겹쳐서 뺀다. 영어는 다른 단어 속에 들어가기 쉬운 짧은 말(ost 등)을 넣지 않는다.
const TITLE_KEYWORDS: &[(&str, &[&str])] = &[
    (
        "piano",
        &["피아노", "피아니스트", "하프시코드", "쳄발로", "piano", "pianist", "harpsichord"],
    ),
    (
        "strings",
        &[
            "바이올린",
            "바이올리니스트",
            "비올라",
            "첼로",
            "첼리스트",
            "더블베이스",
            "콘트라베이스",
            "현악",
            "기타리스트",
            "클래식 기타",
            "클래식기타",
            "기타 리사이틀",
            "기타 독주",
            "하프 리사이틀",
            "하피스트",
            "violin",
            "viola",
            "cello",
            "guitar",
            "harpist",
        ],
    ),
    (
        "winds",
        &[
            "플루트",
            "플루티스트",
            "오보에",
            "클라리넷",
            "바순",
            "호른",
            "트럼펫",
            "트롬본",
            "튜바",
            "색소폰",
            "리코더",
            "목관",
            "금관",
            "관악단",
            "관악 앙상블",
            "관악앙상블",
            "관악 5중주",
            "관악5중주",
            "flute",
            "oboe",
            "clarinet",
            "bassoon",
            "trumpet",
            "trombone",
            "saxophone",
            "brass",
        ],
    ),
    (
        "vocal",
        &[
            "소프라노",
            "메조",
            "테너",
            "카운터테너",
            "바리톤",
            "베이스바리톤",
            "가곡",
            "성악",
            "soprano",
            "mezzo",
            "tenor",
            "baritone",
        ],
    ),
    ("choir", &["합창", "콰이어", "성가대", "chorus", "choir", "chorale"]),
    (
        "orchestra",
        &[
            "교향악단",
            "교향악",
            "필하모닉",
            "필하모니",
            "심포니",
            "오케스트라",
            "관현악",
            "시향",
            "orchestra",
            "symphony",
            "philharmonic",
        ],
    ),
    (
        "chamber",
        &[
            "콰르텟",
            "퀸텟",
            "사중주",
            "오중주",
            "트리오",
            "삼중주",
            "이중주",
            "앙상블",
            "듀오",
            "실내악",
            "챔버",
            "quartet",
            "quintet",
            "trio",
            "ensemble",
            "duo",
            "chamber",
        ],
    ),
    ("opera", &["오페라", "opera"]),
    (
        "crossover",
        &["크로스오버", "재즈", "영화음악", "게임", "애니메이션", "jazz", "crossover"],
    ),
];

/// 아티스트 분류 코드 → 편성.
fn category_instrument(code: &str) -> Option<&'static str> {
    match code {
        "pianist" => Some("piano"),
        "violinist" | "violist" | "cellist" | "double_bassist" | "guitarist" | "harpist" | "gambist" => {
            Some("strings")
        }
        "flutist" | "oboist" | "clarinetist" | "bassoonist" | "hornist" | "trumpeter" | "saxophonist"
        | "recorder_player" => Some("winds"),
        "vocalist" => Some("vocal"),
        "choir" => Some("choir"),
        "orchestra" | "conductor" => Some("orchestra"),
        "ensemble" => Some("chamber"),
        _ => None,
    }
}

/// 제목 키워드와 출연 아티스트 분류(DB 원본 값도 받는다)로 편성 코드를 고른다. `INSTRUMENT_CODES` 순서로 돌려준다.
pub fn classify_instrumentation(title: &str, artist_categories: &[&str]) -> Vec<&'static str> {
    let lowered = title.to_lowercase();
    let mut hits: Vec<&'static str> = Vec::new();
    for (code, keywords) in TITLE_KEYWORDS {
        if keywords.iter().any(|keyword| lowered.contains(keyword)) {
            hits.push(code);
        }
    }
    for category in artist_categories {
        if let Some(code) = known_code(category).and_then(category_instrument) {
            hits.push(code);
        }
    }
    INSTRUMENT_CODES
        .iter()
        .copied()
        .filter(|code| hits.contains(code))
        .collect()
}

/// 저장 형태: 쉼표로 이은 코드. 분류가 없으면 빈 문자열(처리했지만 해당 없음)이다.
pub fn instrumentation_value(codes: &[&str]) -> String {
    codes.join(",")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn splits_cast_and_drops_trailing_etc() {
        assert_eq!(split_cast_names("홍길동, 김철수 등"), vec!["홍길동", "김철수"]);
        assert_eq!(split_cast_names("임윤찬"), vec!["임윤찬"]);
        assert_eq!(split_cast_names("홍길동, 김철수등"), vec!["홍길동", "김철수"]);
        assert_eq!(split_cast_names("홍길동 외 3명"), vec!["홍길동"]);
        assert_eq!(split_cast_names("홍길동 외 다수"), vec!["홍길동"]);
    }

    #[test]
    fn strips_role_brackets_and_other_separators() {
        assert_eq!(
            split_cast_names("손열음(피아노) · 클라라 주미 강 (바이올린)/ 서울시립교향악단"),
            vec!["손열음", "클라라 주미 강", "서울시립교향악단"]
        );
        assert_eq!(split_cast_names("조성진 & 임윤찬\n선우예권"), vec!["조성진", "임윤찬", "선우예권"]);
    }

    #[test]
    fn skips_short_and_duplicate_names() {
        assert_eq!(split_cast_names("김, 이, 홍길동, 홍길동 등"), vec!["홍길동"]);
        assert!(split_cast_names("  ,  등").is_empty());
    }

    #[test]
    fn keeps_names_that_only_contain_oe() {
        // "외"가 이름 안에 있거나 뒤에 다른 말이 오면 자르지 않는다
        assert_eq!(split_cast_names("김외숙"), vec!["김외숙"]);
        assert_eq!(split_cast_names("홍길동 외교관"), vec!["홍길동 외교관"]);
    }

    #[test]
    fn classifies_by_title_keywords() {
        assert_eq!(classify_instrumentation("임윤찬 피아노 리사이틀 [울산]", &[]), vec!["piano"]);
        assert_eq!(classify_instrumentation("블래져 목관앙상블 정기연주회", &[]), vec!["winds", "chamber"]);
        assert_eq!(
            classify_instrumentation("제447회 인천시립교향악단 정기연주회", &[]),
            vec!["orchestra"]
        );
        assert_eq!(classify_instrumentation("소프라노 박지영 & 피아니스트 양기훈 듀오 리사이틀", &[]), vec![
            "piano", "vocal", "chamber"
        ]);
        assert_eq!(classify_instrumentation("제14회 한국남성합창단 합동 연주회", &[]), vec!["choir"]);
        assert_eq!(classify_instrumentation("라움마티네콘서트, 오페라 갈라", &[]), vec!["opera"]);
        assert_eq!(classify_instrumentation("트릭컬 리바이브 오케스트라 콘서트: 게임 음악", &[]), vec![
            "orchestra",
            "crossover"
        ]);
        assert_eq!(classify_instrumentation("Esmé Quartet Recital", &[]), vec!["chamber"]);
    }

    #[test]
    fn avoids_ambiguous_words() {
        assert!(classify_instrumentation("기타 문의는 공연장으로", &[]).is_empty());
        assert!(classify_instrumentation("베이스캠프 콘서트", &[]).is_empty());
        assert!(classify_instrumentation("관악구민 음악회", &[]).is_empty());
        assert!(classify_instrumentation("Boston Recital", &[]).is_empty());
        assert_eq!(classify_instrumentation("하프시코드 독주회", &[]), vec!["piano"]);
    }

    #[test]
    fn adds_linked_artist_categories() {
        assert_eq!(
            classify_instrumentation("SAC 월드스타시리즈, 알렉산더 가지예프 리사이틀", &["pianist"]),
            vec!["piano"]
        );
        assert_eq!(
            classify_instrumentation("빈 필하모닉 내한공연", &["conductor", "pianist"]),
            vec!["piano", "orchestra"]
        );
        // DB에 남은 원본 한국어 분류도 코드로 바꿔 쓴다
        assert_eq!(classify_instrumentation("리사이틀", &["피아노"]), vec!["piano"]);
    }

    #[test]
    fn stores_codes_as_comma_string() {
        assert_eq!(instrumentation_value(&["piano", "chamber"]), "piano,chamber");
        assert_eq!(instrumentation_value(&[]), "");
        assert!(INSTRUMENT_CODES.iter().all(|code| is_instrument_code(code)));
        assert!(!is_instrument_code("guitar"));
    }
}
