//! 이름 검색의 LIKE 패턴과 관련도 정렬 식.

/// LIKE 패턴에서 사용자 입력의 `%`, `_`, `\`를 글자 그대로 찾게 한다.
pub fn escape_like(value: &str) -> String {
    let mut escaped = String::with_capacity(value.len());
    for character in value.chars() {
        if matches!(character, '\\' | '%' | '_') {
            escaped.push('\\');
        }
        escaped.push(character);
    }
    escaped
}

/// 앞뒤 공백을 뺀 검색어와 그로부터 만든 LIKE 패턴.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct SearchText {
    exact: String,
    prefix: String,
    word_prefix: String,
    contains: String,
}

impl SearchText {
    pub fn parse(query: Option<&str>) -> Option<Self> {
        let exact = query.map(str::trim).filter(|value| !value.is_empty())?;
        let escaped = escape_like(exact);

        Some(Self {
            exact: exact.to_string(),
            prefix: format!("{escaped}%"),
            word_prefix: format!("% {escaped}%"),
            contains: format!("%{escaped}%"),
        })
    }

    pub fn exact(&self) -> &str {
        &self.exact
    }

    pub fn prefix(&self) -> &str {
        &self.prefix
    }

    pub fn contains(&self) -> &str {
        &self.contains
    }

    /// 이름 열에 대한 관련도 CASE 식과 바인드 값을 순서대로 준다.
    ///
    /// 0 완전 일치, 1 접두사, 2 단어 접두사(`Yunchan Lim`의 `Lim`), 3 이름에 포함,
    /// 4 이름이 아닌 다른 열에서만 일치.
    pub fn name_relevance(&self, columns: &[&str]) -> (String, Vec<String>) {
        let tiers = [
            ("=", &self.exact),
            ("LIKE", &self.prefix),
            ("LIKE", &self.word_prefix),
            ("LIKE", &self.contains),
        ];

        let mut sql = String::from("CASE");
        let mut binds = Vec::with_capacity(tiers.len() * columns.len());
        for (rank, (operator, value)) in tiers.iter().enumerate() {
            let condition = columns
                .iter()
                .map(|column| format!("{column} {operator} ?"))
                .collect::<Vec<_>>()
                .join(" OR ");
            sql.push_str(&format!(" WHEN {condition} THEN {rank}"));
            binds.extend(columns.iter().map(|_| (*value).clone()));
        }
        sql.push_str(&format!(" ELSE {} END", tiers.len()));

        (sql, binds)
    }
}

#[cfg(test)]
mod tests {
    use super::{escape_like, SearchText};

    #[test]
    fn like_wildcards_are_escaped() {
        assert_eq!(escape_like("100%"), "100\\%");
        assert_eq!(escape_like("a_b"), "a\\_b");
        assert_eq!(escape_like("c:\\x"), "c:\\\\x");
        assert_eq!(escape_like("월광"), "월광");
    }

    #[test]
    fn blank_query_is_not_a_search() {
        assert_eq!(SearchText::parse(None), None);
        assert_eq!(SearchText::parse(Some("   ")), None);
    }

    #[test]
    fn patterns_use_trimmed_escaped_query() {
        let text = SearchText::parse(Some("  임_ ")).expect("검색어");
        assert_eq!(text.exact(), "임_");
        assert_eq!(text.prefix(), "임\\_%");
        assert_eq!(text.contains(), "%임\\_%");
    }

    #[test]
    fn name_relevance_binds_every_placeholder_in_order() {
        let text = SearchText::parse(Some("Lim")).expect("검색어");
        let (sql, binds) = text.name_relevance(&["name", "english_name"]);

        assert_eq!(sql.matches('?').count(), binds.len());
        assert_eq!(
            sql,
            "CASE WHEN name = ? OR english_name = ? THEN 0 \
             WHEN name LIKE ? OR english_name LIKE ? THEN 1 \
             WHEN name LIKE ? OR english_name LIKE ? THEN 2 \
             WHEN name LIKE ? OR english_name LIKE ? THEN 3 ELSE 4 END"
        );
        assert_eq!(
            binds,
            ["Lim", "Lim", "Lim%", "Lim%", "% Lim%", "% Lim%", "%Lim%", "%Lim%"]
        );
    }
}
