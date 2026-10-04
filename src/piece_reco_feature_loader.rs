//! 추천 작품 속성 적재기.
//!
//! `features.jsonl` 의 작품별 주인공 소리·편성 규모·친숙도·첫 구간·온보딩 순서를
//! `piece_reco_features` 에 넣는다. 첫 구간은 `pieceId + startSectorKey` 로 찾는다.
//! 첫 SQL 전에 모든 줄을 검증하고 한 트랜잭션으로 넣는다. 같은 입력을 다시 넣으면
//! 바뀌는 것이 없다(두 번째 dry-run 의 계획 변경 수는 0 이다).
//! 작품이나 첫 구간이 없으면 그 줄은 건너뛰고 보고서에 남긴다.

use serde::{Deserialize, Serialize};
use sqlx::{FromRow, MySql, Transaction};
use std::{collections::HashSet, fmt, fs, path::PathBuf};

use crate::db::DbPool;

pub const LEAD_SOUNDS: [&str; 6] = [
    "piano",
    "orchestra",
    "strings",
    "winds",
    "voice",
    "ensemble",
];
pub const SCALES: [&str; 3] = ["solo", "chamber", "large"];
pub const FAMILIARITIES: [&str; 3] = ["everyone", "known", "deep"];
const REVIEW_STATUSES: [&str; 2] = ["DRAFT", "CONFIRMED"];
const MAX_SECTOR_KEY_LEN: usize = 150;
/// 온보딩 카드는 한 화면에 들어갈 만큼만 둔다
pub const MAX_ONBOARDING_ORDER: u16 = 24;

#[derive(Debug, Clone)]
pub struct RecoFeatureLoadOptions {
    pub input_path: PathBuf,
    pub dry_run: bool,
    /// 입력이 이 줄 수를 넘으면 적재하지 않는다
    pub limit: Option<usize>,
    pub run_id: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct RecoFeatureRecord {
    pub piece_id: i32,
    pub lead_sound: String,
    pub scale: String,
    pub familiarity: String,
    #[serde(default)]
    pub start_sector_key: Option<String>,
    #[serde(default)]
    pub onboarding_order: Option<u16>,
    pub review_status: String,
}

impl RecoFeatureRecord {
    pub fn validate(&self) -> Result<(), String> {
        if self.piece_id <= 0 {
            return Err("pieceId 는 양수여야 함".to_string());
        }
        for (field, value, allowed) in [
            ("leadSound", &self.lead_sound, &LEAD_SOUNDS[..]),
            ("scale", &self.scale, &SCALES[..]),
            ("familiarity", &self.familiarity, &FAMILIARITIES[..]),
            ("reviewStatus", &self.review_status, &REVIEW_STATUSES[..]),
        ] {
            if !allowed.contains(&value.as_str()) {
                return Err(format!(
                    "{field} 는 {} 중 하나여야 함: {value}",
                    allowed.join("·")
                ));
            }
        }
        if let Some(key) = &self.start_sector_key {
            if key.is_empty() || key.len() > MAX_SECTOR_KEY_LEN || !key.is_ascii() {
                return Err("startSectorKey 는 1~150자 ASCII 여야 함".to_string());
            }
        }
        if let Some(order) = self.onboarding_order {
            if order == 0 || order > MAX_ONBOARDING_ORDER {
                return Err(format!(
                    "onboardingOrder 는 1~{MAX_ONBOARDING_ORDER} 이어야 함"
                ));
            }
        }
        Ok(())
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RecoFeatureMutationCounts {
    pub inserted: u64,
    pub updated: u64,
    pub total: u64,
}

impl RecoFeatureMutationCounts {
    fn finish(mut self) -> Self {
        self.total = self.inserted + self.updated;
        self
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SkippedRecoFeature {
    pub piece_id: i32,
    pub reason: &'static str,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RecoFeatureLoadReport {
    pub status: &'static str,
    pub input_path: String,
    pub row_count: usize,
    pub dry_run: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    pub unchanged: usize,
    pub mutations: RecoFeatureMutationCounts,
    pub planned_mutations: RecoFeatureMutationCounts,
    pub skipped: Vec<SkippedRecoFeature>,
}

#[derive(Debug)]
pub enum RecoFeatureLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
}

impl RecoFeatureLoadError {
    pub const fn code(&self) -> &'static str {
        match self {
            Self::Input { code, .. } => code,
            Self::Database(_) => "DATABASE_ERROR",
        }
    }

    pub const fn line(&self) -> Option<usize> {
        match self {
            Self::Input { line, .. } => *line,
            Self::Database(_) => None,
        }
    }

    pub const fn exit_code(&self) -> i32 {
        match self {
            Self::Input { .. } => 2,
            Self::Database(_) => 3,
        }
    }

    fn input(code: &'static str, message: impl Into<String>, line: Option<usize>) -> Self {
        Self::Input {
            code,
            message: message.into(),
            line,
        }
    }
}

impl fmt::Display for RecoFeatureLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for RecoFeatureLoadError {}

impl From<sqlx::Error> for RecoFeatureLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// JSONL 을 읽어 검증한다. 빈 줄은 건너뛴다. 같은 작품이나 같은 온보딩 순서가 두 번 나오면 거부한다
pub fn parse_records(
    text: &str,
    limit: Option<usize>,
) -> Result<Vec<RecoFeatureRecord>, RecoFeatureLoadError> {
    let mut records = Vec::new();
    let mut pieces = HashSet::new();
    let mut orders = HashSet::new();
    for (index, line) in text.lines().enumerate() {
        let line_number = index + 1;
        if line.trim().is_empty() {
            continue;
        }
        let record: RecoFeatureRecord = serde_json::from_str(line).map_err(|error| {
            RecoFeatureLoadError::input("INVALID_JSON", error.to_string(), Some(line_number))
        })?;
        record.validate().map_err(|message| {
            RecoFeatureLoadError::input("INVALID_FEATURE", message, Some(line_number))
        })?;
        if !pieces.insert(record.piece_id) {
            return Err(RecoFeatureLoadError::input(
                "DUPLICATE_PIECE",
                format!("pieceId {} 가 두 번 나옴", record.piece_id),
                Some(line_number),
            ));
        }
        if let Some(order) = record.onboarding_order {
            if !orders.insert(order) {
                return Err(RecoFeatureLoadError::input(
                    "DUPLICATE_ONBOARDING_ORDER",
                    format!("onboardingOrder {order} 가 두 번 나옴"),
                    Some(line_number),
                ));
            }
        }
        records.push(record);
    }
    if let Some(limit) = limit {
        if records.len() > limit {
            return Err(RecoFeatureLoadError::input(
                "LIMIT_EXCEEDED",
                format!("입력 {}줄이 --limit {limit} 을 넘음", records.len()),
                None,
            ));
        }
    }
    Ok(records)
}

#[derive(Debug, FromRow, PartialEq, Eq)]
struct StoredFeature {
    lead_sound: String,
    ensemble_scale: String,
    familiarity: String,
    start_sector_id: Option<i32>,
    onboarding_order: Option<u16>,
    review_status: String,
}

enum Plan {
    Insert(Option<i32>),
    Update(Option<i32>),
    Unchanged,
    Skip(&'static str),
}

pub struct PieceRecoFeatureLoader;

impl PieceRecoFeatureLoader {
    pub async fn load(
        pool: &DbPool,
        options: &RecoFeatureLoadOptions,
    ) -> Result<RecoFeatureLoadReport, RecoFeatureLoadError> {
        let text = fs::read_to_string(&options.input_path).map_err(|error| {
            RecoFeatureLoadError::input(
                "INPUT_READ_ERROR",
                format!("입력을 읽을 수 없음: {error}"),
                None,
            )
        })?;
        let records = parse_records(&text, options.limit)?;

        let mut transaction = pool.begin().await?;
        let mut planned = RecoFeatureMutationCounts::default();
        let mut unchanged = 0;
        let mut skipped = Vec::new();

        for record in &records {
            match Self::plan(&mut transaction, record).await? {
                Plan::Skip(reason) => skipped.push(SkippedRecoFeature {
                    piece_id: record.piece_id,
                    reason,
                }),
                Plan::Unchanged => unchanged += 1,
                Plan::Insert(sector) => {
                    Self::write(&mut transaction, record, sector).await?;
                    planned.inserted += 1;
                }
                Plan::Update(sector) => {
                    Self::write(&mut transaction, record, sector).await?;
                    planned.updated += 1;
                }
            }
        }

        let planned = planned.finish();
        let mutations = if options.dry_run {
            transaction.rollback().await?;
            RecoFeatureMutationCounts::default()
        } else {
            transaction.commit().await?;
            planned.clone()
        };

        Ok(RecoFeatureLoadReport {
            status: "succeeded",
            input_path: options.input_path.to_string_lossy().into_owned(),
            row_count: records.len(),
            dry_run: options.dry_run,
            run_id: options.run_id.clone(),
            unchanged,
            mutations,
            planned_mutations: planned,
            skipped,
        })
    }

    async fn plan(
        transaction: &mut Transaction<'_, MySql>,
        record: &RecoFeatureRecord,
    ) -> Result<Plan, sqlx::Error> {
        let piece = sqlx::query_scalar::<_, i32>("SELECT id FROM pieces WHERE id = ? FOR UPDATE")
            .bind(record.piece_id)
            .fetch_optional(&mut **transaction)
            .await?;
        if piece.is_none() {
            return Ok(Plan::Skip("PIECE_NOT_FOUND"));
        }

        let sector = match &record.start_sector_key {
            None => None,
            Some(key) => {
                let found = sqlx::query_scalar::<_, i32>(
                    "SELECT id FROM performance_sectors WHERE piece_id = ? AND sector_key = ?",
                )
                .bind(record.piece_id)
                .bind(key)
                .fetch_optional(&mut **transaction)
                .await?;
                match found {
                    Some(id) => Some(id),
                    None => return Ok(Plan::Skip("START_SECTOR_NOT_FOUND")),
                }
            }
        };

        let stored = sqlx::query_as::<_, StoredFeature>(
            "SELECT lead_sound, ensemble_scale, familiarity, start_sector_id,
                    onboarding_order, review_status
             FROM piece_reco_features
             WHERE piece_id = ?
             FOR UPDATE",
        )
        .bind(record.piece_id)
        .fetch_optional(&mut **transaction)
        .await?;

        let wanted = StoredFeature {
            lead_sound: record.lead_sound.clone(),
            ensemble_scale: record.scale.clone(),
            familiarity: record.familiarity.clone(),
            start_sector_id: sector,
            onboarding_order: record.onboarding_order,
            review_status: record.review_status.clone(),
        };
        Ok(match stored {
            None => Plan::Insert(sector),
            Some(stored) if stored == wanted => Plan::Unchanged,
            Some(_) => Plan::Update(sector),
        })
    }

    async fn write(
        transaction: &mut Transaction<'_, MySql>,
        record: &RecoFeatureRecord,
        start_sector_id: Option<i32>,
    ) -> Result<(), sqlx::Error> {
        sqlx::query(
            "INSERT INTO piece_reco_features
                 (piece_id, lead_sound, ensemble_scale, familiarity, start_sector_id,
                  onboarding_order, review_status)
             VALUES (?, ?, ?, ?, ?, ?, ?)
             ON DUPLICATE KEY UPDATE
                 lead_sound = VALUES(lead_sound),
                 ensemble_scale = VALUES(ensemble_scale),
                 familiarity = VALUES(familiarity),
                 start_sector_id = VALUES(start_sector_id),
                 onboarding_order = VALUES(onboarding_order),
                 review_status = VALUES(review_status)",
        )
        .bind(record.piece_id)
        .bind(&record.lead_sound)
        .bind(&record.scale)
        .bind(&record.familiarity)
        .bind(start_sector_id)
        .bind(record.onboarding_order)
        .bind(&record.review_status)
        .execute(&mut **transaction)
        .await?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::parse_records;

    const LINE: &str = r#"{"pieceId":78,"leadSound":"piano","scale":"solo","familiarity":"everyone","startSectorKey":"mv1-adagio","onboardingOrder":1,"reviewStatus":"DRAFT"}"#;

    #[test]
    fn valid_feature_is_parsed() {
        let records = parse_records(LINE, None).expect("적재 입력");
        assert_eq!(records.len(), 1);
        assert_eq!(records[0].start_sector_key.as_deref(), Some("mv1-adagio"));
    }

    #[test]
    fn optional_fields_can_be_left_out() {
        let line = r#"{"pieceId":62,"leadSound":"orchestra","scale":"large","familiarity":"known","reviewStatus":"CONFIRMED"}"#;
        let records = parse_records(line, None).expect("적재 입력");
        assert_eq!(records[0].onboarding_order, None);
    }

    #[test]
    fn unknown_values_are_rejected() {
        assert!(parse_records(&LINE.replace("\"piano\"", "\"harp\""), None).is_err());
        assert!(parse_records(&LINE.replace("\"solo\"", "\"duo\""), None).is_err());
        assert!(parse_records(&LINE.replace("\"everyone\"", "\"famous\""), None).is_err());
        assert!(parse_records(&LINE.replace("\"DRAFT\"", "\"PUBLISHED\""), None).is_err());
        assert!(parse_records(
            &LINE.replace("\"onboardingOrder\":1", "\"onboardingOrder\":0"),
            None
        )
        .is_err());
    }

    #[test]
    fn duplicates_unknown_fields_and_limit_are_rejected() {
        assert!(parse_records(&format!("{LINE}\n{LINE}"), None).is_err());
        let other_piece_same_order = LINE.replace("\"pieceId\":78", "\"pieceId\":79");
        assert!(parse_records(&format!("{LINE}\n{other_piece_same_order}"), None).is_err());
        let extra = LINE.replacen('{', r#"{"extra":1,"#, 1);
        assert!(parse_records(&extra, None).is_err());
        assert!(parse_records(LINE, Some(0)).is_err());
        assert!(parse_records(LINE, Some(1)).is_ok());
    }
}
