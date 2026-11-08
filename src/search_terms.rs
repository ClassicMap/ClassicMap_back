//! 검색어 낱말을 다른 말로도 찾게 하는 다국어 낱말 묶음.
//!
//! 작품 이름은 한국어(「연습곡」), 영어(「Etude」), 원어(「Étude」「Studie」)가 섞여 있다.
//! 검색어 낱말이 묶음의 한 말과 같으면 같은 묶음의 다른 말로도 찾는다.
//! DB 비교(utf8mb4_unicode_ci)가 대소문자·악센트를 가리지 않으므로 라틴 낱말은 악센트 없이 한 번만 적는다.

use crate::search::SearchText;

/// 같은 뜻의 갈래·편성·조성 낱말 묶음. 첫 말이 데이터의 한국어 표기다.
const TERM_GROUPS: &[&[&str]] = &[
    // 갈래
    &[
        "연습곡",
        "에튀드",
        "에뛰드",
        "에튜드",
        "etude",
        "etudes",
        "study",
        "studies",
        "studie",
        "studien",
    ],
    &[
        "교향곡",
        "심포니",
        "symphony",
        "symphonies",
        "symphonie",
        "sinfonie",
        "sinfonien",
    ],
    &["신포니아", "sinfonia", "sinfonias"],
    &[
        "교향시",
        "symphonic poem",
        "tone poem",
        "tondichtung",
        "poeme symphonique",
    ],
    &[
        "협주곡",
        "콘체르토",
        "concerto",
        "concertos",
        "concerti",
        "konzert",
    ],
    &["소나타", "sonata", "sonatas", "sonate", "sonaten"],
    &["소나티네", "소나티나", "sonatina", "sonatine"],
    &["녹턴", "야상곡", "nocturne", "nocturnes", "notturno"],
    &[
        "전주곡",
        "프렐류드",
        "프렐루드",
        "prelude",
        "preludes",
        "praeludium",
        "preludio",
    ],
    &[
        "환상곡",
        "판타지",
        "판타지아",
        "fantasia",
        "fantasy",
        "fantaisie",
        "fantasie",
    ],
    &["광시곡", "랩소디", "rhapsody", "rhapsodie", "rapsodia"],
    &["즉흥곡", "impromptu", "impromptus"],
    &["왈츠", "waltz", "waltzes", "valse", "valses", "walzer"],
    &["마주르카", "mazurka", "mazurkas", "mazurek"],
    &["폴로네즈", "폴로네이즈", "polonaise", "polonaises"],
    &["발라드", "ballade", "ballades"],
    &["스케르초", "scherzo", "scherzi"],
    &[
        "변주곡",
        "variations",
        "variation",
        "variationen",
        "variazioni",
    ],
    &["서곡", "overture", "ouverture"],
    &["모음곡", "suite", "suites"],
    &["행진곡", "march", "marche", "marsch", "marcia"],
    &["미사", "mass", "messe", "missa"],
    &["레퀴엠", "진혼곡", "requiem"],
    &["칸타타", "cantata", "cantatas", "kantate"],
    &["오라토리오", "oratorio"],
    &["오페라", "opera"],
    &["발레", "ballet"],
    &[
        "가곡", "song", "songs", "lied", "lieder", "melodie", "melodies",
    ],
    &["자장가", "berceuse", "lullaby", "wiegenlied"],
    &["뱃노래", "barcarolle", "barcarola"],
    &["세레나데", "serenade", "serenata", "standchen"],
    &["디베르티멘토", "divertimento"],
    &["론도", "rondo", "rondeau"],
    &["푸가", "fugue", "fuga", "fuge"],
    &["토카타", "toccata"],
    &["파르티타", "partita"],
    &["카논", "canon", "kanon"],
    &["샤콘", "샤콘느", "chaconne", "ciaccona"],
    &["파사칼리아", "passacaglia"],
    &["미뉴에트", "minuet", "menuet", "menuetto"],
    &["무언가", "songs without words", "lieder ohne worte"],
    // 편성
    &["2중주", "이중주", "duo"],
    &["3중주", "삼중주", "trio"],
    &["4중주", "사중주", "quartet", "quartett", "quatuor"],
    &["5중주", "오중주", "quintet", "quintett", "quintette"],
    &["6중주", "육중주", "sextet", "sextett"],
    &["8중주", "팔중주", "octet", "oktett"],
    &["현악", "string", "strings", "streich"],
    &["피아노", "piano", "klavier", "pianoforte"],
    &["바이올린", "violin", "violon", "violine"],
    &["비올라", "viola"],
    &["첼로", "cello", "violoncello", "violoncelle"],
    &["플루트", "flute", "flote"],
    &["클라리넷", "clarinet", "klarinette", "clarinette"],
    &["오보에", "oboe", "hautbois"],
    &["호른", "horn"],
    &["트럼펫", "trumpet", "trompete", "trompette"],
    &["하프", "harp", "harpe", "harfe"],
    &["기타", "guitar", "guitare", "gitarre"],
    &["오르간", "organ", "orgue", "orgel"],
    &["합창", "choir", "chorus", "chor", "choeur"],
    &["관현악", "orchestra", "orchester", "orchestre"],
    // 조성
    &["장조", "major", "dur"],
    &["단조", "minor", "moll"],
];

/// 낱말을 묶음에서 찾을 꼴로: 소문자, 라틴 악센트는 뗀다.
fn fold(word: &str) -> String {
    word.to_lowercase()
        .chars()
        .map(|c| match c {
            'à' | 'á' | 'â' | 'ä' | 'ã' | 'å' => 'a',
            'ç' => 'c',
            'è' | 'é' | 'ê' | 'ë' => 'e',
            'ì' | 'í' | 'î' | 'ï' => 'i',
            'ñ' => 'n',
            'ò' | 'ó' | 'ô' | 'ö' | 'õ' => 'o',
            'ù' | 'ú' | 'û' | 'ü' => 'u',
            other => other,
        })
        .collect()
}

/// 「5번」 ↔ 「No. 5」「Nr. 5」.
fn number_variants(word: &str) -> Vec<String> {
    let folded = fold(word);
    let number = folded
        .strip_suffix('번')
        .or_else(|| folded.strip_prefix("no."))
        .or_else(|| folded.strip_prefix("nr."))
        .or_else(|| folded.strip_prefix("no"))
        .or_else(|| folded.strip_prefix("nr"))
        .map(str::trim)
        .filter(|rest| !rest.is_empty() && rest.chars().all(|c| c.is_ascii_digit()));
    match number {
        Some(n) => vec![format!("{n}번"), format!("No. {n}"), format!("Nr. {n}")],
        None => Vec::new(),
    }
}

/// 「E♭장조」「C#단조」 ↔ 「E-flat major」「E♭ major」「C-sharp minor」「C# minor」.
fn key_variants(word: &str) -> Vec<String> {
    let folded = fold(word);
    let (rest, mode) = if let Some(rest) = folded.strip_suffix("장조") {
        (rest, "major")
    } else if let Some(rest) = folded.strip_suffix("단조") {
        (rest, "minor")
    } else {
        return Vec::new();
    };
    let mut chars = rest.trim().chars();
    let Some(letter) = chars.next().filter(|c| ('a'..='g').contains(c)) else {
        return Vec::new();
    };
    let letter = letter.to_ascii_uppercase();
    let accidental: String = chars.collect();
    let names: Vec<String> = match accidental.trim() {
        "" => vec![format!("{letter} {mode}")],
        "♭" | "b" => vec![format!("{letter}-flat {mode}"), format!("{letter}♭ {mode}")],
        "♯" | "#" => vec![
            format!("{letter}-sharp {mode}"),
            format!("{letter}♯ {mode}"),
            format!("{letter}# {mode}"),
        ],
        _ => return Vec::new(),
    };
    names
}

/// 검색어 낱말 하나와 같은 뜻으로 찾을 말들. 첫 값은 낱말 그대로다(겹치는 말은 뺀다).
pub fn word_variants(word: &str) -> Vec<String> {
    let mut found = vec![word.to_string()];
    let folded = fold(word.trim());
    for group in TERM_GROUPS {
        if group.iter().any(|term| fold(term) == folded) {
            found.extend(group.iter().map(|term| (*term).to_string()));
        }
    }
    found.extend(number_variants(word.trim()));
    found.extend(key_variants(word.trim()));
    let mut seen = std::collections::HashSet::new();
    found.retain(|term| seen.insert(fold(term)));
    found
}

/// 「op10」「op 10」「op.10」을 데이터 표기 「Op. 10」으로 바꾼다. 아니면 그대로 둔다.
pub fn normalize_opus(text: &str) -> String {
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

/// 검색어의 LIKE 패턴: 그대로, 작품번호 표기를 고친 것, 다른 말(「에튀드」→「연습곡」「Etude」)로 바꾼 것.
pub fn contains_variants(text: &str) -> Vec<String> {
    let Some(original) = SearchText::parse(Some(text)) else {
        return Vec::new();
    };
    let mut variants = vec![original.contains().to_string()];
    let mut others = vec![normalize_opus(original.exact())];
    others.extend(word_variants(original.exact()).into_iter().skip(1));
    for other in others {
        if let Some(parsed) = SearchText::parse(Some(&other)) {
            let pattern = parsed.contains().to_string();
            if !variants.contains(&pattern) {
                variants.push(pattern);
            }
        }
    }
    variants
}

/// 낱말마다의 LIKE 패턴들. 낱말은 다섯 개까지 보고, 「Op. 10」「No. 5」는 띄어 써도 한 낱말이다.
pub fn search_tokens(text: &str) -> Vec<Vec<String>> {
    join_opus(text.split_whitespace().collect())
        .into_iter()
        .take(5)
        .map(|word| contains_variants(&word))
        .filter(|variants| !variants.is_empty())
        .collect()
}

/// 「Op.」·「op」·「K.」·「BWV」 같은 작품번호 머리 낱말은 뒤 숫자와 붙여 한 낱말로 본다.
fn join_opus(words: Vec<&str>) -> Vec<String> {
    const HEADS: [&str; 12] = [
        "op", "op.", "k", "k.", "kv", "bwv", "hob.", "rv", "no", "no.", "nr", "nr.",
    ];
    let mut joined: Vec<String> = Vec::new();
    let mut index = 0;
    while index < words.len() {
        let word = words[index];
        let next_is_number = words
            .get(index + 1)
            .is_some_and(|next| next.chars().next().is_some_and(|c| c.is_ascii_digit()));
        if HEADS.contains(&word.to_lowercase().as_str()) && next_is_number {
            joined.push(format!("{word} {}", words[index + 1]));
            index += 2;
        } else {
            joined.push(word.to_string());
            index += 1;
        }
    }
    joined
}

#[cfg(test)]
mod tests {
    use super::word_variants;

    #[test]
    fn etude_matches_every_language() {
        for word in ["연습곡", "에튀드", "Etude", "étude", "Études"] {
            let variants = word_variants(word);
            assert!(
                variants.iter().any(|v| v == "연습곡"),
                "{word}: {variants:?}"
            );
            assert!(
                variants.iter().any(|v| v == "studie"),
                "{word}: {variants:?}"
            );
            // 대소문자·악센트만 다른 말(「Etude」「etude」)은 DB 가 같게 보므로 하나만 둔다
            assert_eq!(
                variants
                    .iter()
                    .filter(|v| super::fold(v) == "etude")
                    .count(),
                1,
                "{word}: {variants:?}"
            );
        }
    }

    #[test]
    fn symphony_matches_korean_and_german() {
        let variants = word_variants("Symphony");
        assert!(variants.contains(&"교향곡".to_string()));
        assert!(variants.contains(&"sinfonie".to_string()));
        assert!(!variants.contains(&"sinfonia".to_string()));
    }

    #[test]
    fn numbers_and_keys_cross_languages() {
        assert_eq!(word_variants("5번"), vec!["5번", "No. 5", "Nr. 5"]);
        assert_eq!(word_variants("No.5"), vec!["No.5", "5번", "No. 5", "Nr. 5"]);
        assert_eq!(word_variants("C단조"), vec!["C단조", "C minor"]);
        assert_eq!(
            word_variants("E♭장조"),
            vec!["E♭장조", "E-flat major", "E♭ major"]
        );
    }

    #[test]
    fn unknown_word_stays_alone() {
        assert_eq!(word_variants("쇼팽"), vec!["쇼팽"]);
        assert_eq!(word_variants("Op. 10"), vec!["Op. 10"]);
    }
}
