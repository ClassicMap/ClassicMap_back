use serde::{Deserialize, Serialize};

use crate::comparison::model::ComparisonPiece;

/// 클래식을 얼마나 듣는지. 온보딩 첫 질문
pub const LISTENING_LEVELS: [&str; 4] = ["new", "some", "often", "player"];
/// 온보딩 '어떤 소리에 끌려요' 답. `piece_reco_features.lead_sound` 와 같은 값이다
pub const SOUNDS: [&str; 5] = ["piano", "orchestra", "strings", "voice", "ensemble"];
/// 직접 연주하는 악기
pub const INSTRUMENTS: [&str; 5] = ["piano", "strings", "winds", "voice", "other"];
pub const PERIODS: [&str; 4] = ["바로크", "고전주의", "낭만주의", "근현대"];
pub const ONBOARDING_STATUSES: [&str; 2] = ["completed", "skipped"];
pub const EVENT_KINDS: [&str; 4] = ["open", "finish", "skip", "not_interested"];
/// 온보딩 '아는 곡'은 카드 수만큼만 고를 수 있다
pub const MAX_SEED_PIECES: usize = 24;
pub const MAX_IDS: usize = 200;
pub const MAX_EVENTS_PER_REQUEST: usize = 50;

#[derive(Debug, Clone, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct OnboardingState {
    /// completed / skipped. 비어 있으면 아직 안 봤다
    pub status: Option<String>,
    pub version: Option<u16>,
}

#[derive(Debug, Clone, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct TasteProfile {
    pub listening_level: Option<String>,
    pub sounds: Vec<String>,
    pub instrument: Option<String>,
    pub favorite_periods: Vec<String>,
    pub seed_piece_ids: Vec<i32>,
    pub onboarding: OnboardingState,
    pub history_enabled: bool,
}

impl Default for TasteProfile {
    fn default() -> Self {
        Self {
            listening_level: None,
            sounds: Vec::new(),
            instrument: None,
            favorite_periods: Vec::new(),
            seed_piece_ids: Vec::new(),
            onboarding: OnboardingState {
                status: None,
                version: None,
            },
            history_enabled: true,
        }
    }
}

#[derive(Debug, Clone, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct OnboardingInput {
    pub status: String,
    pub version: u16,
}

/// 취향 저장 요청. 답 전체를 보낸다(빠진 목록은 비운다)
#[derive(Debug, Clone, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct TasteInput {
    #[serde(default)]
    pub listening_level: Option<String>,
    #[serde(default)]
    pub sounds: Vec<String>,
    #[serde(default)]
    pub instrument: Option<String>,
    #[serde(default)]
    pub favorite_periods: Vec<String>,
    #[serde(default)]
    pub seed_piece_ids: Vec<i32>,
    /// 주면 온보딩 상태를 바꾼다. 안 주면 그대로 둔다
    #[serde(default)]
    pub onboarding: Option<OnboardingInput>,
    /// 주면 들은 기록 설정을 바꾼다. 안 주면 그대로 둔다
    #[serde(default)]
    pub history_enabled: Option<bool>,
}

fn check_one_of(field: &str, value: &str, allowed: &[&str]) -> Result<(), String> {
    if allowed.contains(&value) {
        Ok(())
    } else {
        Err(format!("{field} 값이 올바르지 않음: {value}"))
    }
}

fn check_list(field: &str, values: &[String], allowed: &[&str]) -> Result<(), String> {
    for value in values {
        check_one_of(field, value, allowed)?;
    }
    let mut unique = values.to_vec();
    unique.sort();
    unique.dedup();
    if unique.len() != values.len() {
        return Err(format!("{field} 에 같은 값이 두 번 있음"));
    }
    Ok(())
}

impl TasteInput {
    pub fn validate(&self) -> Result<(), String> {
        if let Some(level) = &self.listening_level {
            check_one_of("listeningLevel", level, &LISTENING_LEVELS)?;
        }
        check_list("sounds", &self.sounds, &SOUNDS)?;
        if let Some(instrument) = &self.instrument {
            check_one_of("instrument", instrument, &INSTRUMENTS)?;
            if self.listening_level.as_deref() != Some("player") {
                return Err("instrument 는 listeningLevel 이 player 일 때만 줄 수 있음".to_string());
            }
        }
        check_list("favoritePeriods", &self.favorite_periods, &PERIODS)?;
        if self.seed_piece_ids.len() > MAX_SEED_PIECES {
            return Err(format!("seedPieceIds 는 {MAX_SEED_PIECES}개까지임"));
        }
        if self.seed_piece_ids.iter().any(|id| *id <= 0) {
            return Err("seedPieceIds 는 양수여야 함".to_string());
        }
        if let Some(onboarding) = &self.onboarding {
            check_one_of(
                "onboarding.status",
                &onboarding.status,
                &ONBOARDING_STATUSES,
            )?;
            if onboarding.version == 0 {
                return Err("onboarding.version 은 1 이상이어야 함".to_string());
            }
        }
        Ok(())
    }
}

/// 온보딩 '아는 곡' 카드
#[derive(Debug, Clone, Serialize, sqlx::FromRow)]
#[serde(rename_all = "camelCase")]
pub struct OnboardingPiece {
    pub piece_id: i32,
    pub piece_title: String,
    pub composer_id: i32,
    pub composer_name: String,
    pub composer_avatar_url: Option<String>,
    pub lead_sound: String,
}

#[derive(Debug, Clone, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct ListeningEventInput {
    pub piece_id: i32,
    #[serde(default)]
    pub sector_id: Option<i32>,
    #[serde(default)]
    pub performance_id: Option<i32>,
    pub kind: String,
}

#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct ListeningEventBatch {
    pub events: Vec<ListeningEventInput>,
}

impl ListeningEventBatch {
    pub fn validate(&self) -> Result<(), String> {
        if self.events.len() > MAX_EVENTS_PER_REQUEST {
            return Err(format!(
                "events 는 한 번에 {MAX_EVENTS_PER_REQUEST}개까지임"
            ));
        }
        for event in &self.events {
            check_one_of("kind", &event.kind, &EVENT_KINDS)?;
            if event.piece_id <= 0
                || event.sector_id.is_some_and(|id| id <= 0)
                || event.performance_id.is_some_and(|id| id <= 0)
            {
                return Err("id 는 양수여야 함".to_string());
            }
        }
        Ok(())
    }
}

#[derive(Debug, Clone, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct ListeningEventResult {
    pub accepted: usize,
    pub ignored: usize,
}

/// 로그인하지 않은 사람의 추천 요청. 기기에 둔 답과 기록을 실어 보내고 서버는 저장하지 않는다
#[derive(Debug, Clone, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct GuestRecommendationRequest {
    pub taste: TasteInput,
    #[serde(default)]
    pub favorite_composer_ids: Vec<i32>,
    #[serde(default)]
    pub favorite_artist_ids: Vec<i32>,
    #[serde(default)]
    pub recent_piece_ids: Vec<i32>,
    #[serde(default)]
    pub not_interested_piece_ids: Vec<i32>,
}

impl GuestRecommendationRequest {
    pub fn validate(&self) -> Result<(), String> {
        self.taste.validate()?;
        for (field, ids) in [
            ("favoriteComposerIds", &self.favorite_composer_ids),
            ("favoriteArtistIds", &self.favorite_artist_ids),
            ("recentPieceIds", &self.recent_piece_ids),
            ("notInterestedPieceIds", &self.not_interested_piece_ids),
        ] {
            if ids.len() > MAX_IDS {
                return Err(format!("{field} 는 {MAX_IDS}개까지임"));
            }
        }
        Ok(())
    }
}

/// 추천 작품 한 장. 비교 카탈로그 카드와 같은 모양에 첫 구간과 이유를 더했다
#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RecommendedPiece {
    #[serde(flatten)]
    pub piece: ComparisonPiece,
    /// 처음 열 구간. 비어 있으면 화면의 기본 구간을 쓴다
    pub sector_id: Option<i32>,
    pub sector_name: Option<String>,
    /// 화면에 보이는 추천 이유. 두 개까지
    pub reasons: Vec<String>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RecommendationShelf {
    /// taste(취향에 맞춘 비교) / known(아는 곡, 다르게 듣기) / starter(처음 듣기 좋은 비교)
    pub key: &'static str,
    pub items: Vec<RecommendedPiece>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct HomeRecommendations {
    /// 답·담아 둔 것·기록 중 하나라도 있으면 true
    pub personalized: bool,
    pub today: Option<RecommendedPiece>,
    pub shelves: Vec<RecommendationShelf>,
}

#[cfg(test)]
mod tests {
    use super::*;

    fn input() -> TasteInput {
        TasteInput {
            listening_level: Some("new".to_string()),
            sounds: vec!["piano".to_string()],
            instrument: None,
            favorite_periods: vec![],
            seed_piece_ids: vec![78],
            onboarding: Some(OnboardingInput {
                status: "completed".to_string(),
                version: 1,
            }),
            history_enabled: None,
        }
    }

    #[test]
    fn valid_taste_passes() {
        assert!(input().validate().is_ok());
    }

    #[test]
    fn unknown_or_duplicate_values_fail() {
        let mut taste = input();
        taste.sounds = vec!["harp".to_string()];
        assert!(taste.validate().is_err());
        let mut taste = input();
        taste.sounds = vec!["piano".to_string(), "piano".to_string()];
        assert!(taste.validate().is_err());
        let mut taste = input();
        taste.favorite_periods = vec!["중세".to_string()];
        assert!(taste.validate().is_err());
    }

    #[test]
    fn instrument_needs_player_level() {
        let mut taste = input();
        taste.instrument = Some("piano".to_string());
        assert!(taste.validate().is_err());
        taste.listening_level = Some("player".to_string());
        assert!(taste.validate().is_ok());
    }

    #[test]
    fn event_batch_is_checked() {
        let event = ListeningEventInput {
            piece_id: 78,
            sector_id: Some(63),
            performance_id: None,
            kind: "finish".to_string(),
        };
        assert!(ListeningEventBatch {
            events: vec![event.clone()]
        }
        .validate()
        .is_ok());
        let mut wrong = event.clone();
        wrong.kind = "like".to_string();
        assert!(ListeningEventBatch {
            events: vec![wrong]
        }
        .validate()
        .is_err());
        assert!(ListeningEventBatch {
            events: vec![event; MAX_EVENTS_PER_REQUEST + 1]
        }
        .validate()
        .is_err());
    }
}
