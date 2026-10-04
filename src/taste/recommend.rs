//! 홈 추천 점수.
//!
//! 비교 작품마다 네 가지 점수를 더한다.
//! 점수 = 0.35 × 편성 맞음 + 0.30 × 고른 곡과 닮음 + 0.25 × 친숙도 맞춤 + 0.10 × 새로움
//! 같은 점수는 날마다 바뀌는 순서로 가른다. 그래서 답이 같아도 셸프가 매일 조금씩 달라진다.
//! DB 를 보지 않는 순수 함수라 입력만으로 결과를 확인할 수 있다.

use std::collections::{HashMap, HashSet};

use super::model::{HomeRecommendations, RecommendationShelf, RecommendedPiece, TasteProfile};
use crate::comparison::model::ComparisonPiece;

const W_SOUND: f64 = 0.35;
const W_SIMILAR: f64 = 0.30;
const W_FAMILIAR: f64 = 0.25;
const W_NOVELTY: f64 = 0.10;
const PERIOD_BONUS: f64 = 0.05;
const SKIP_PENALTY: f64 = 0.05;
const TODAY_POOL: usize = 5;
const SHELF_SIZE: usize = 6;
const MAX_REASONS: usize = 2;
const EXPLORE_REASON: &str = "평소와 다른 소리";
const STARTER_REASON: &str = "처음 듣기 좋은 곡";

/// 점수를 매길 작품 한 곡
#[derive(Debug, Clone)]
pub struct Candidate {
    pub piece: ComparisonPiece,
    pub period: String,
    pub lead_sound: Option<String>,
    pub scale: Option<String>,
    pub familiarity: Option<String>,
    /// 처음 열 구간(공개 구간일 때만)
    pub start_sector: Option<(i32, String)>,
    /// 공개 연주의 주 연주자
    pub artists: Vec<(i32, String)>,
}

/// 들은 기록을 작품별로 모은 것
#[derive(Debug, Clone, Default)]
pub struct History {
    pub finished: HashMap<i32, u32>,
    pub skipped: HashMap<i32, u32>,
    /// 최근 7일 안에 연 작품
    pub recent: HashSet<i32>,
    pub not_interested: HashSet<i32>,
}

impl History {
    fn is_empty(&self) -> bool {
        self.finished.is_empty()
            && self.skipped.is_empty()
            && self.recent.is_empty()
            && self.not_interested.is_empty()
    }
}

#[derive(Debug, Clone, Default)]
pub struct Signals {
    pub taste: TasteProfile,
    pub favorite_composer_ids: HashSet<i32>,
    pub favorite_artist_ids: HashSet<i32>,
    pub favorite_piece_ids: HashSet<i32>,
    pub history: History,
}

impl Signals {
    fn personalized(&self) -> bool {
        let taste = &self.taste;
        taste.listening_level.is_some()
            || !taste.sounds.is_empty()
            || taste.instrument.is_some()
            || !taste.favorite_periods.is_empty()
            || !taste.seed_piece_ids.is_empty()
            || !self.favorite_composer_ids.is_empty()
            || !self.favorite_artist_ids.is_empty()
            || !self.favorite_piece_ids.is_empty()
            || !self.history.is_empty()
    }

    /// 고른 소리에 연주하는 악기를 더한 것
    fn sounds(&self) -> HashSet<&str> {
        let mut sounds: HashSet<&str> = self.taste.sounds.iter().map(String::as_str).collect();
        if let Some(instrument) = self.taste.instrument.as_deref() {
            if instrument != "other" {
                sounds.insert(instrument);
            }
        }
        sounds
    }
}

/// 고른 소리가 맞는 곡의 이유. 다른 이유("월광과 같은 베토벤", "처음 듣기 좋은 곡")처럼 명사로 끝낸다
fn sound_reason(sound: &str, played: bool) -> Option<String> {
    if played {
        return matches!(sound, "piano" | "strings" | "winds" | "voice")
            .then(|| "연주하는 악기의 곡".to_string());
    }
    let text = match sound {
        "piano" => "피아노 곡",
        "orchestra" => "관현악곡",
        "strings" => "바이올린·첼로 곡",
        "voice" => "성악곡",
        "ensemble" => "실내악곡",
        _ => return None,
    };
    Some(text.to_string())
}

/// 마지막 글자에 받침이 있는지. 한글과 숫자만 가리고 나머지는 받침 없음으로 본다
fn has_final_consonant(word: &str) -> bool {
    match word.trim().chars().last() {
        Some(ch @ '가'..='힣') => !(ch as u32 - '가' as u32).is_multiple_of(28),
        Some(ch) if ch.is_ascii_digit() => matches!(ch, '0' | '1' | '3' | '6' | '7' | '8'),
        _ => false,
    }
}

/// 이유 문구에 쓰는 짧은 곡 이름. 프론트 `shortPieceTitle` 과 같은 규칙이다.
/// 따옴표 별명 → 꺾쇠 제목(뒤에 붙은 말은 살린다: <타이스>의 명상곡 → 타이스의 명상곡)
/// → 괄호 앞 제목(끝의 조성은 뺀다) 순
pub fn short_title(title: &str) -> String {
    if let Some(end) = title.rfind('"') {
        if let Some(start) = title[..end].rfind('"') {
            let inner = title[start + 1..end].trim();
            if !inner.is_empty() {
                return inner.to_string();
            }
        }
    }
    let head = title.split(" (").next().unwrap_or(title).trim();
    if let Some(open) = head.find('<') {
        if let Some(close) = head[open + 1..].find('>').map(|offset| open + 1 + offset) {
            let inner = head[open + 1..close].trim();
            let after = &head[close + 1..];
            if !inner.is_empty() {
                return if after.trim().is_empty() || after.trim().starts_with('중') {
                    inner.to_string()
                } else {
                    format!("{inner}{after}").trim().to_string()
                };
            }
        }
    }
    match head.rsplit_once(' ') {
        Some((rest, key)) if key.ends_with("장조") || key.ends_with("단조") => {
            rest.trim().to_string()
        }
        _ => head.to_string(),
    }
}

fn same_as(reference: &str, composer: &str) -> String {
    let short = short_title(reference);
    let particle = if has_final_consonant(&short) {
        "과"
    } else {
        "와"
    };
    format!("{short}{particle} 같은 {composer}")
}

fn familiarity_score(level: Option<&str>, familiarity: Option<&str>) -> f64 {
    match (level, familiarity) {
        (_, None) => 0.5,
        (Some("new"), Some("everyone")) => 1.0,
        (Some("new"), Some("known")) => 0.5,
        (Some("new"), Some(_)) => 0.0,
        (Some("some"), Some("everyone")) => 0.7,
        (Some("some"), Some("known")) => 1.0,
        (Some("some"), Some(_)) => 0.4,
        (Some(_), Some("everyone")) => 0.3,
        (Some(_), Some("known")) => 0.7,
        (Some(_), Some(_)) => 1.0,
        (None, Some("everyone")) => 0.8,
        (None, Some("known")) => 0.6,
        (None, Some(_)) => 0.3,
    }
}

/// 날마다 바뀌는 순서. 같은 점수를 가를 때만 쓴다
fn daily_order(piece_id: i32, day: i64) -> u64 {
    let mut value = (piece_id as u64).wrapping_mul(0x9E37_79B9_7F4A_7C15) ^ (day as u64);
    value ^= value >> 31;
    value = value.wrapping_mul(0xBF58_476D_1CE4_E5B9);
    value ^ (value >> 29)
}

#[derive(Debug, Clone)]
struct Scored<'a> {
    candidate: &'a Candidate,
    score: f64,
    reasons: Vec<String>,
    sound_match: bool,
}

fn score<'a>(
    candidate: &'a Candidate,
    signals: &Signals,
    by_id: &HashMap<i32, &Candidate>,
) -> Scored<'a> {
    let taste = &signals.taste;
    let level = taste.listening_level.as_deref();
    let sounds = signals.sounds();
    let lead = candidate.lead_sound.as_deref();
    let piece_id = candidate.piece.piece_id;

    // 편성 맞음
    let mut sound_text = None;
    let (sound, sound_match) = if sounds.is_empty() {
        (0.5, false)
    } else if let Some(lead) = lead.filter(|lead| sounds.contains(lead)) {
        let played =
            taste.instrument.as_deref() == Some(lead) && !taste.sounds.iter().any(|s| s == lead);
        sound_text = sound_reason(lead, played);
        (1.0, true)
    } else {
        let scale = candidate.scale.as_deref();
        let partial = (scale == Some("large") && sounds.contains("orchestra"))
            || (scale == Some("chamber") && sounds.contains("ensemble"));
        (if partial { 0.4 } else { 0.0 }, false)
    };

    // 고른 곡과 닮음: 고른 곡·담아 둔 곡·끝까지 들은 곡 중 가장 닮은 곡
    let mut similar: f64 = 0.0;
    let mut similar_text = None;
    let references = taste
        .seed_piece_ids
        .iter()
        .chain(signals.favorite_piece_ids.iter())
        .chain(signals.history.finished.keys());
    for reference_id in references {
        if *reference_id == piece_id {
            continue;
        }
        let Some(reference) = by_id.get(reference_id) else {
            continue;
        };
        let same_composer = reference.piece.composer_id == candidate.piece.composer_id;
        let value = if same_composer { 0.6 } else { 0.0 }
            + if lead.is_some() && reference.lead_sound.as_deref() == lead {
                0.25
            } else {
                0.0
            }
            + if reference.period == candidate.period {
                0.15
            } else {
                0.0
            };
        if value > similar {
            similar = value;
            similar_text = same_composer
                .then(|| same_as(&reference.piece.piece_title, &candidate.piece.composer_name));
        }
    }
    if signals
        .favorite_composer_ids
        .contains(&candidate.piece.composer_id)
        && similar < 0.6
    {
        similar = 0.6;
        similar_text = Some(format!("담아 둔 {}", candidate.piece.composer_name));
    }
    let mut artist_text = None;
    if let Some((_, name)) = candidate
        .artists
        .iter()
        .find(|(id, _)| signals.favorite_artist_ids.contains(id))
    {
        similar = similar.max(0.7);
        artist_text = Some(format!("{name}의 연주"));
    }

    // 친숙도 맞춤
    let familiarity = candidate.familiarity.as_deref();
    let familiar = familiarity_score(level, familiarity);
    let familiar_text = match (level, familiarity) {
        (Some("new"), Some("everyone")) => Some(STARTER_REASON.to_string()),
        (Some("often" | "player"), Some("deep")) => Some("덜 알려진 곡".to_string()),
        _ => None,
    };

    // 새로움
    let history = &signals.history;
    let skips = history.skipped.get(&piece_id).copied().unwrap_or(0);
    let novelty: f64 = if skips > 0 {
        0.2
    } else if history.recent.contains(&piece_id) {
        0.3
    } else if history.finished.contains_key(&piece_id) {
        0.6
    } else {
        1.0
    };

    let period_match = taste.favorite_periods.contains(&candidate.period);
    let total = W_SOUND * sound
        + W_SIMILAR * similar
        + W_FAMILIAR * familiar
        + W_NOVELTY * novelty
        + if period_match { PERIOD_BONUS } else { 0.0 }
        - SKIP_PENALTY * f64::from(skips.min(2));

    let reasons: Vec<String> = [
        artist_text,
        similar_text,
        sound_text,
        familiar_text,
        period_match.then(|| format!("좋아하는 {}", candidate.period)),
    ]
    .into_iter()
    .flatten()
    .take(MAX_REASONS)
    .collect();

    Scored {
        candidate,
        score: total,
        reasons,
        sound_match,
    }
}

fn to_item(scored: &Scored<'_>) -> RecommendedPiece {
    let candidate = scored.candidate;
    RecommendedPiece {
        piece: candidate.piece.clone(),
        sector_id: candidate.start_sector.as_ref().map(|(id, _)| *id),
        sector_name: candidate
            .start_sector
            .as_ref()
            .map(|(_, name)| name.clone()),
        reasons: scored.reasons.clone(),
    }
}

/// 같은 작곡가는 셸프에 한 곡만. 고른 소리마다 한 칸 이상, 마지막 칸은 고르지 않은 소리.
/// 고른 소리 곡이 모자라면 남은 칸은 점수 순으로 채운다
fn taste_shelf<'a>(
    ranked: &[Scored<'a>],
    used: &HashSet<i32>,
    sounds: &HashSet<&str>,
    level: Option<&str>,
    taken_composers: &HashSet<i32>,
) -> Vec<Scored<'a>> {
    let main_size = if sounds.is_empty() {
        SHELF_SIZE
    } else {
        SHELF_SIZE - 1
    };
    let available: Vec<&Scored<'a>> = ranked
        .iter()
        .filter(|scored| !used.contains(&scored.candidate.piece.piece_id))
        .collect();
    let mut picked: Vec<Scored<'a>> = Vec::new();
    let mut composers: HashSet<i32> = taken_composers.clone();
    let fits = |scored: &Scored<'a>, picked: &[Scored<'a>], composers: &HashSet<i32>| {
        !composers.contains(&scored.candidate.piece.composer_id)
            && !picked
                .iter()
                .any(|item| item.candidate.piece.piece_id == scored.candidate.piece.piece_id)
    };

    // 고른 소리마다 가장 높은 곡 하나씩 먼저
    let mut sound_list: Vec<&str> = sounds.iter().copied().collect();
    sound_list.sort_unstable();
    for sound in sound_list {
        if picked.len() >= main_size {
            break;
        }
        if let Some(best) = available.iter().find(|scored| {
            scored.candidate.lead_sound.as_deref() == Some(sound)
                && fits(scored, &picked, &composers)
        }) {
            composers.insert(best.candidate.piece.composer_id);
            picked.push((*best).clone());
        }
    }
    // 고른 소리가 있으면 그 소리 곡으로만 채운다
    for scored in &available {
        if picked.len() >= main_size {
            break;
        }
        if (sounds.is_empty() || scored.sound_match) && fits(scored, &picked, &composers) {
            composers.insert(scored.candidate.piece.composer_id);
            picked.push((*scored).clone());
        }
    }
    picked.sort_by(|a, b| b.score.total_cmp(&a.score));

    let mut explore_item = None;
    if !sounds.is_empty() {
        let comfortable = |familiarity: Option<&str>| match level {
            Some("new") | None => familiarity == Some("everyone"),
            Some("some") => matches!(familiarity, Some("everyone" | "known")),
            _ => true,
        };
        if let Some(explore) = available.iter().find(|scored| {
            !scored.sound_match
                && scored.candidate.lead_sound.is_some()
                && comfortable(scored.candidate.familiarity.as_deref())
                && fits(scored, &picked, &composers)
        }) {
            let mut explore = (*explore).clone();
            explore.reasons = vec![EXPLORE_REASON.to_string()];
            composers.insert(explore.candidate.piece.composer_id);
            explore_item = Some(explore);
        }
    }

    // 모자란 칸은 점수 순으로
    let wanted = SHELF_SIZE - usize::from(explore_item.is_some());
    for scored in &available {
        if picked.len() >= wanted {
            break;
        }
        if fits(scored, &picked, &composers) {
            composers.insert(scored.candidate.piece.composer_id);
            picked.push((*scored).clone());
        }
    }
    picked.extend(explore_item);
    picked
}

/// 홈 추천을 만든다. `day` 는 한국 날짜의 일 번호(오늘의 비교를 날마다 돌린다)
pub fn recommend_home(
    candidates: &[Candidate],
    signals: &Signals,
    day: i64,
) -> HomeRecommendations {
    let by_id: HashMap<i32, &Candidate> = candidates
        .iter()
        .map(|candidate| (candidate.piece.piece_id, candidate))
        .collect();
    let excluded = &signals.history.not_interested;
    let seeds: HashSet<i32> = signals.taste.seed_piece_ids.iter().copied().collect();

    let mut ranked: Vec<Scored<'_>> = candidates
        .iter()
        .filter(|candidate| !excluded.contains(&candidate.piece.piece_id))
        .map(|candidate| score(candidate, signals, &by_id))
        .collect();
    ranked.sort_by(|a, b| {
        b.score.total_cmp(&a.score).then_with(|| {
            daily_order(a.candidate.piece.piece_id, day)
                .cmp(&daily_order(b.candidate.piece.piece_id, day))
        })
    });

    if !signals.personalized() {
        // 답이 없으면 누구나 아는 곡 전체를 날마다 돌린다
        let mut pool: Vec<&Scored<'_>> = ranked
            .iter()
            .filter(|scored| scored.candidate.familiarity.as_deref() == Some("everyone"))
            .collect();
        if pool.is_empty() {
            pool = ranked.iter().collect();
        }
        pool.sort_by_key(|scored| scored.candidate.piece.piece_id);
        let today = (!pool.is_empty()).then(|| {
            let mut item = to_item(pool[day.rem_euclid(pool.len() as i64) as usize]);
            item.reasons.clear();
            item
        });
        return HomeRecommendations {
            personalized: false,
            today,
            shelves: Vec::new(),
        };
    }

    let pool: Vec<&Scored<'_>> = ranked
        .iter()
        .filter(|scored| !seeds.contains(&scored.candidate.piece.piece_id))
        .take(TODAY_POOL)
        .collect();
    let today = (!pool.is_empty()).then(|| pool[day.rem_euclid(pool.len() as i64) as usize]);

    let mut used: HashSet<i32> = seeds.clone();
    if let Some(today) = today {
        used.insert(today.candidate.piece.piece_id);
    }
    let sounds = signals.sounds();
    let level = signals.taste.listening_level.as_deref();
    // 홈 전체에서 같은 작곡가가 겹치지 않게 오늘의 비교부터 차례로 넘긴다
    let mut taken_composers: HashSet<i32> = today
        .map(|today| today.candidate.piece.composer_id)
        .into_iter()
        .collect();
    let taste_items = taste_shelf(&ranked, &used, &sounds, level, &taken_composers);
    used.extend(taste_items.iter().map(|item| item.candidate.piece.piece_id));
    taken_composers.extend(
        taste_items
            .iter()
            .map(|item| item.candidate.piece.composer_id),
    );

    let mut shelves = Vec::new();
    if !taste_items.is_empty() {
        shelves.push(RecommendationShelf {
            key: "taste",
            items: taste_items.iter().map(to_item).collect(),
        });
    }

    let known: Vec<RecommendedPiece> = signals
        .taste
        .seed_piece_ids
        .iter()
        .filter(|id| !excluded.contains(id))
        .filter_map(|id| by_id.get(id))
        .map(|candidate| RecommendedPiece {
            piece: candidate.piece.clone(),
            sector_id: candidate.start_sector.as_ref().map(|(id, _)| *id),
            sector_name: candidate
                .start_sector
                .as_ref()
                .map(|(_, name)| name.clone()),
            reasons: Vec::new(),
        })
        .collect();
    if !known.is_empty() {
        shelves.push(RecommendationShelf {
            key: "known",
            items: known,
        });
    }

    if level == Some("new") {
        let mut composers = taken_composers;
        let starter: Vec<RecommendedPiece> = ranked
            .iter()
            .filter(|scored| {
                scored.candidate.familiarity.as_deref() == Some("everyone")
                    && !used.contains(&scored.candidate.piece.piece_id)
            })
            .filter(|scored| composers.insert(scored.candidate.piece.composer_id))
            .take(SHELF_SIZE)
            .map(|scored| {
                let mut item = to_item(scored);
                if !item.reasons.iter().any(|reason| reason == STARTER_REASON) {
                    item.reasons.truncate(MAX_REASONS - 1);
                    item.reasons.push(STARTER_REASON.to_string());
                }
                item
            })
            .collect();
        if !starter.is_empty() {
            shelves.push(RecommendationShelf {
                key: "starter",
                items: starter,
            });
        }
    }

    HomeRecommendations {
        personalized: true,
        today: today.map(to_item),
        shelves,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn candidate(
        id: i32,
        composer: (i32, &str),
        title: &str,
        period: &str,
        lead: &str,
        scale: &str,
        familiarity: &str,
    ) -> Candidate {
        Candidate {
            piece: ComparisonPiece {
                piece_id: id,
                piece_title: title.to_string(),
                opus_number: None,
                composer_id: composer.0,
                composer_name: composer.1.to_string(),
                composer_avatar_url: None,
                sector_count: 1,
                performer_count: 3,
                performers: Vec::new(),
            },
            period: period.to_string(),
            lead_sound: Some(lead.to_string()),
            scale: Some(scale.to_string()),
            familiarity: Some(familiarity.to_string()),
            start_sector: None,
            artists: vec![(id * 10, format!("연주자{id}"))],
        }
    }

    fn catalog() -> Vec<Candidate> {
        let beethoven = (15, "베토벤");
        let mozart = (14, "모차르트");
        let haydn = (16, "하이든");
        let chopin = (28, "쇼팽");
        let mahler = (60, "말러");
        let schubert = (26, "슈베르트");
        vec![
            candidate(
                78,
                beethoven,
                "피아노 소나타 14번 C#단조 \"월광\"",
                "고전주의",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                79,
                beethoven,
                "피아노 소나타 8번 C단조 \"비창\"",
                "고전주의",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                75,
                beethoven,
                "교향곡 5번 C단조 \"운명\"",
                "고전주의",
                "orchestra",
                "large",
                "everyone",
            ),
            candidate(
                73,
                mozart,
                "피아노 소나타 11번 A장조 \"터키 행진곡\"",
                "고전주의",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                66,
                mozart,
                "아이네 클라이네 나흐트무지크",
                "고전주의",
                "orchestra",
                "large",
                "everyone",
            ),
            candidate(
                83,
                haydn,
                "교향곡 94번 G장조 \"놀람\"",
                "고전주의",
                "orchestra",
                "large",
                "everyone",
            ),
            candidate(
                127,
                chopin,
                "연습곡 Op. 10, No. 12 \"혁명\"",
                "낭만주의",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                129,
                chopin,
                "발라드 1번 G단조",
                "낭만주의",
                "piano",
                "solo",
                "known",
            ),
            candidate(
                216,
                mahler,
                "교향곡 5번 C#단조",
                "낭만주의",
                "orchestra",
                "large",
                "known",
            ),
            candidate(
                215,
                mahler,
                "교향곡 2번 C단조 \"부활\"",
                "낭만주의",
                "orchestra",
                "large",
                "deep",
            ),
            candidate(
                117,
                schubert,
                "가곡 <마왕>",
                "낭만주의",
                "voice",
                "solo",
                "everyone",
            ),
            candidate(
                120,
                schubert,
                "현악 4중주 14번 D단조 \"죽음과 소녀\"",
                "낭만주의",
                "ensemble",
                "chamber",
                "known",
            ),
            candidate(
                220,
                (70, "드뷔시"),
                "달빛 (베르가마스크 모음곡 중)",
                "근현대",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                378,
                (71, "사티"),
                "짐노페디 1번",
                "근현대",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                139,
                (30, "리스트"),
                "사랑의 꿈 3번 A♭장조",
                "낭만주의",
                "piano",
                "solo",
                "everyone",
            ),
            candidate(
                185,
                (72, "요한 슈트라우스 2세"),
                "왈츠 <아름답고 푸른 도나우>",
                "낭만주의",
                "orchestra",
                "large",
                "everyone",
            ),
            candidate(
                162,
                (34, "차이콥스키"),
                "발레 <백조의 호수>",
                "낭만주의",
                "orchestra",
                "large",
                "everyone",
            ),
        ]
    }

    fn beginner_who_likes_moonlight() -> Signals {
        Signals {
            taste: TasteProfile {
                listening_level: Some("new".to_string()),
                sounds: vec!["piano".to_string()],
                seed_piece_ids: vec![78],
                ..TasteProfile::default()
            },
            ..Signals::default()
        }
    }

    #[test]
    fn titles_and_particles() {
        assert_eq!(short_title("피아노 소나타 14번 C#단조 \"월광\""), "월광");
        assert_eq!(
            short_title("오페라 <투란도트> 중 \"공주는 잠 못 이루고\""),
            "공주는 잠 못 이루고"
        );
        assert_eq!(short_title("가곡 <마왕>"), "마왕");
        assert_eq!(short_title("<타이스>의 명상곡"), "타이스의 명상곡");
        assert_eq!(short_title("<핑갈의 동굴> 서곡"), "핑갈의 동굴 서곡");
        assert_eq!(
            short_title("<전람회의 그림> (라벨 편곡 관현악 버전)"),
            "전람회의 그림"
        );
        assert_eq!(short_title("달빛 (베르가마스크 모음곡 중)"), "달빛");
        assert_eq!(short_title("교향곡 5번 C#단조"), "교향곡 5번");
        assert_eq!(short_title("피아노 협주곡 1번 E♭장조"), "피아노 협주곡 1번");
        assert_eq!(
            same_as("피아노 소나타 14번 C#단조 \"월광\"", "베토벤"),
            "월광과 같은 베토벤"
        );
        assert_eq!(
            same_as("교향곡 94번 G장조 \"놀람\"", "하이든"),
            "놀람과 같은 하이든"
        );
        assert_eq!(same_as("교향곡 2번", "말러"), "교향곡 2번과 같은 말러");
        assert_eq!(
            same_as("교향곡 5번 C#단조", "말러"),
            "교향곡 5번과 같은 말러"
        );
        assert_eq!(
            same_as("아이네 클라이네 나흐트무지크", "모차르트"),
            "아이네 클라이네 나흐트무지크와 같은 모차르트"
        );
    }

    #[test]
    fn no_answers_rotates_well_known_pieces() {
        let catalog = catalog();
        let first = recommend_home(&catalog, &Signals::default(), 20_000);
        assert!(!first.personalized);
        assert!(first.shelves.is_empty());
        let today = first.today.expect("오늘의 비교");
        let familiarity = catalog
            .iter()
            .find(|candidate| candidate.piece.piece_id == today.piece.piece_id)
            .and_then(|candidate| candidate.familiarity.clone());
        assert_eq!(familiarity.as_deref(), Some("everyone"));
        let next = recommend_home(&catalog, &Signals::default(), 20_001)
            .today
            .expect("다음 날");
        assert_ne!(today.piece.piece_id, next.piece.piece_id);
    }

    #[test]
    fn beginner_gets_piano_and_same_composer_first() {
        let result = recommend_home(&catalog(), &beginner_who_likes_moonlight(), 20_000);
        assert!(result.personalized);
        let today = result.today.as_ref().expect("오늘의 비교");
        assert_ne!(today.piece.piece_id, 78, "고른 곡은 오늘의 비교에서 뺀다");

        let taste = result
            .shelves
            .iter()
            .find(|shelf| shelf.key == "taste")
            .expect("취향 셸프");
        let ids: Vec<i32> = taste.items.iter().map(|item| item.piece.piece_id).collect();
        assert!(!ids.contains(&78));
        let mut composers: Vec<i32> = taste
            .items
            .iter()
            .map(|item| item.piece.composer_id)
            .collect();
        composers.sort_unstable();
        composers.dedup();
        assert_eq!(
            composers.len(),
            taste.items.len(),
            "작곡가는 셸프에 한 곡씩"
        );
        assert_eq!(
            taste.items.last().map(|item| item.reasons.clone()),
            Some(vec![EXPLORE_REASON.to_string()]),
            "마지막 칸은 다른 소리"
        );

        let all: Vec<&RecommendedPiece> = result.today.iter().chain(taste.items.iter()).collect();
        let pathetique = all.iter().find(|item| item.piece.piece_id == 79);
        if let Some(item) = pathetique {
            assert_eq!(
                item.reasons.first().map(String::as_str),
                Some("월광과 같은 베토벤")
            );
        }

        let known = result
            .shelves
            .iter()
            .find(|shelf| shelf.key == "known")
            .expect("아는 곡");
        assert_eq!(known.items[0].piece.piece_id, 78);
        assert!(result.shelves.iter().any(|shelf| shelf.key == "starter"));
    }

    #[test]
    fn composers_do_not_repeat_across_today_and_shelves() {
        let result = recommend_home(&catalog(), &beginner_who_likes_moonlight(), 20_000);
        let composers: Vec<i32> = result
            .today
            .iter()
            .chain(
                result
                    .shelves
                    .iter()
                    .filter(|shelf| shelf.key != "known")
                    .flat_map(|shelf| shelf.items.iter()),
            )
            .map(|item| item.piece.composer_id)
            .collect();
        let unique: HashSet<i32> = composers.iter().copied().collect();
        assert_eq!(unique.len(), composers.len());
    }

    #[test]
    fn every_chosen_sound_gets_a_slot() {
        let signals = Signals {
            taste: TasteProfile {
                listening_level: Some("often".to_string()),
                sounds: vec!["orchestra".to_string(), "voice".to_string()],
                ..TasteProfile::default()
            },
            ..Signals::default()
        };
        let result = recommend_home(&catalog(), &signals, 20_000);
        let taste = result
            .shelves
            .iter()
            .find(|shelf| shelf.key == "taste")
            .expect("취향 셸프");
        let leads: HashSet<i32> = taste.items.iter().map(|item| item.piece.piece_id).collect();
        assert!(
            leads.contains(&117) || result.today.as_ref().map(|t| t.piece.piece_id) == Some(117)
        );
        assert!(result.shelves.iter().all(|shelf| shelf.key != "starter"));
    }

    #[test]
    fn not_interested_is_hidden_and_favorite_artist_is_named() {
        let mut signals = beginner_who_likes_moonlight();
        signals.history.not_interested.insert(79);
        signals.favorite_artist_ids.insert(1270);
        let result = recommend_home(&catalog(), &signals, 20_000);
        let items: Vec<&RecommendedPiece> = result
            .today
            .iter()
            .chain(result.shelves.iter().flat_map(|shelf| shelf.items.iter()))
            .collect();
        assert!(items.iter().all(|item| item.piece.piece_id != 79));
        let revolutionary = items
            .iter()
            .find(|item| item.piece.piece_id == 127)
            .expect("혁명");
        assert_eq!(
            revolutionary.reasons.first().map(String::as_str),
            Some("연주자127의 연주")
        );
    }
}
