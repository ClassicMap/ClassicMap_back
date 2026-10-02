//! 정렬 지도 적재기.
//!
//! `scripts/build_alignment_maps.py` 가 낸 JSONL 을 `clip_alignments` 에 넣는다.
//! 첫 SQL 전에 모든 줄을 검증하고, 한 트랜잭션에서 넣는다. 같은 입력을 다시 넣으면
//! 바뀌는 것이 없다(두 번째 dry-run 의 계획 변경 수는 0 이다).
//! 이 클립이나 기준 클립의 해시가 지금 클립과 다르거나 클립이 없으면 그 줄은 건너뛰고 보고서에 남긴다.

use serde::{Deserialize, Serialize};
use sqlx::{FromRow, MySql, Transaction};
use std::{collections::HashSet, fmt, fs, path::PathBuf};

use crate::db::DbPool;

/// 기술적 최대 구간 600초를 0.5초 간격으로 둔 점 수
pub const MAX_POSITIONS: usize = 1_201;

#[derive(Debug, Clone)]
pub struct AlignmentLoadOptions {
    pub input_path: PathBuf,
    pub dry_run: bool,
    /// 입력이 이 줄 수를 넘으면 적재하지 않는다
    pub limit: Option<usize>,
    pub run_id: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct ClipAlignmentRecord {
    pub clip_asset_id: u64,
    pub reference_clip_asset_id: u64,
    pub analyzer_version: String,
    pub clip_sha256: String,
    pub reference_clip_sha256: String,
    pub step_ms: u16,
    pub duration_ms: u32,
    pub reference_duration_ms: u32,
    pub positions_ms: Vec<u32>,
    pub cost: f64,
}

fn is_sha256(value: &str) -> bool {
    value.len() == 64
        && value
            .bytes()
            .all(|byte| byte.is_ascii_digit() || (b'a'..=b'f').contains(&byte))
}

impl ClipAlignmentRecord {
    pub fn validate(&self) -> Result<(), String> {
        let version = self.analyzer_version.trim();
        if version.is_empty() || version.len() > 32 {
            return Err("analyzerVersion 은 1~32자여야 함".to_string());
        }
        if !is_sha256(&self.clip_sha256) || !is_sha256(&self.reference_clip_sha256) {
            return Err("clipSha256·referenceClipSha256 은 소문자 16진수 64자여야 함".to_string());
        }
        if self.step_ms == 0 {
            return Err("stepMs 는 0보다 커야 함".to_string());
        }
        for (field, value) in [
            ("durationMs", self.duration_ms),
            ("referenceDurationMs", self.reference_duration_ms),
        ] {
            if value == 0 || value > 600_000 {
                return Err(format!("{field} 는 1~600000 이어야 함"));
            }
        }
        if self.clip_asset_id == self.reference_clip_asset_id
            && (self.clip_sha256 != self.reference_clip_sha256
                || self.duration_ms != self.reference_duration_ms)
        {
            return Err("기준 클립 자신의 줄은 해시와 길이가 같아야 함".to_string());
        }
        let points = self.positions_ms.len();
        if points == 0 || points > MAX_POSITIONS {
            return Err(format!("positionsMs 점 수가 범위 밖임: {points}"));
        }
        let expected = (self.reference_duration_ms / u32::from(self.step_ms)) as usize + 1;
        if points.abs_diff(expected) > 2 {
            return Err(format!(
                "positionsMs 점 수({points})가 기준 길이로 셈한 값({expected})과 맞지 않음"
            ));
        }
        if self.positions_ms.windows(2).any(|pair| pair[1] < pair[0]) {
            return Err("positionsMs 는 줄어들면 안 됨".to_string());
        }
        if self
            .positions_ms
            .iter()
            .any(|value| *value > self.duration_ms)
        {
            return Err("positionsMs 가 클립 길이를 넘음".to_string());
        }
        if !self.cost.is_finite() || !(0.0..10.0).contains(&self.cost) {
            return Err("cost 는 0 이상 10 미만이어야 함".to_string());
        }
        Ok(())
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct AlignmentMutationCounts {
    pub inserted: u64,
    pub updated: u64,
    pub total: u64,
}

impl AlignmentMutationCounts {
    fn finish(mut self) -> Self {
        self.total = self.inserted + self.updated;
        self
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SkippedAlignment {
    pub clip_asset_id: u64,
    pub reason: &'static str,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct AlignmentLoadReport {
    pub status: &'static str,
    pub input_path: String,
    pub row_count: usize,
    pub dry_run: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    pub unchanged: usize,
    pub mutations: AlignmentMutationCounts,
    pub planned_mutations: AlignmentMutationCounts,
    pub skipped: Vec<SkippedAlignment>,
}

#[derive(Debug)]
pub enum AlignmentLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
}

impl AlignmentLoadError {
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

impl fmt::Display for AlignmentLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for AlignmentLoadError {}

impl From<sqlx::Error> for AlignmentLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// JSONL 을 읽어 검증한다. 빈 줄은 건너뛴다. 같은 클립이 두 번 나오면 거부한다
pub fn parse_records(
    text: &str,
    limit: Option<usize>,
) -> Result<Vec<ClipAlignmentRecord>, AlignmentLoadError> {
    let mut records = Vec::new();
    let mut seen = HashSet::new();
    for (index, line) in text.lines().enumerate() {
        let line_number = index + 1;
        if line.trim().is_empty() {
            continue;
        }
        let record: ClipAlignmentRecord = serde_json::from_str(line).map_err(|error| {
            AlignmentLoadError::input("INVALID_JSON", error.to_string(), Some(line_number))
        })?;
        record.validate().map_err(|message| {
            AlignmentLoadError::input("INVALID_ALIGNMENT", message, Some(line_number))
        })?;
        if !seen.insert(record.clip_asset_id) {
            return Err(AlignmentLoadError::input(
                "DUPLICATE_CLIP",
                format!("clipAssetId {} 가 두 번 나옴", record.clip_asset_id),
                Some(line_number),
            ));
        }
        records.push(record);
    }
    if let Some(limit) = limit {
        if records.len() > limit {
            return Err(AlignmentLoadError::input(
                "LIMIT_EXCEEDED",
                format!("입력 {}줄이 --limit {limit} 을 넘음", records.len()),
                None,
            ));
        }
    }
    Ok(records)
}

#[derive(Debug, FromRow)]
struct StoredAlignment {
    reference_clip_asset_id: u64,
    analyzer_version: String,
    clip_sha256: String,
    reference_clip_sha256: String,
    step_ms: u16,
    duration_ms: u32,
    reference_duration_ms: u32,
    positions_ms: String,
    cost: f64,
}

/// DB 에 든 값이 이 기록과 같은지. 비용은 열의 정밀도까지만 견준다
fn same_as_stored(record: &ClipAlignmentRecord, stored: &StoredAlignment) -> bool {
    let positions: Vec<u32> = match serde_json::from_str(&stored.positions_ms) {
        Ok(positions) => positions,
        Err(_) => return false,
    };
    stored.reference_clip_asset_id == record.reference_clip_asset_id
        && stored.analyzer_version == record.analyzer_version
        && stored.clip_sha256 == record.clip_sha256
        && stored.reference_clip_sha256 == record.reference_clip_sha256
        && stored.step_ms == record.step_ms
        && stored.duration_ms == record.duration_ms
        && stored.reference_duration_ms == record.reference_duration_ms
        && (stored.cost - record.cost).abs() <= 0.000_05
        && positions == record.positions_ms
}

enum Plan {
    Insert,
    Update,
    Unchanged,
    Skip(&'static str),
}

pub struct ClipAlignmentLoader;

impl ClipAlignmentLoader {
    pub async fn load(
        pool: &DbPool,
        options: &AlignmentLoadOptions,
    ) -> Result<AlignmentLoadReport, AlignmentLoadError> {
        let text = fs::read_to_string(&options.input_path).map_err(|error| {
            AlignmentLoadError::input(
                "INPUT_READ_ERROR",
                format!("입력을 읽을 수 없음: {error}"),
                None,
            )
        })?;
        let records = parse_records(&text, options.limit)?;

        let mut transaction = pool.begin().await?;
        let mut planned = AlignmentMutationCounts::default();
        let mut unchanged = 0;
        let mut skipped = Vec::new();

        for record in &records {
            match Self::plan(&mut transaction, record).await? {
                Plan::Skip(reason) => skipped.push(SkippedAlignment {
                    clip_asset_id: record.clip_asset_id,
                    reason,
                }),
                Plan::Unchanged => unchanged += 1,
                Plan::Insert => {
                    Self::write(&mut transaction, record).await?;
                    planned.inserted += 1;
                }
                Plan::Update => {
                    Self::write(&mut transaction, record).await?;
                    planned.updated += 1;
                }
            }
        }

        let planned = planned.finish();
        let mutations = if options.dry_run {
            transaction.rollback().await?;
            AlignmentMutationCounts::default()
        } else {
            transaction.commit().await?;
            planned.clone()
        };

        Ok(AlignmentLoadReport {
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

    async fn clip_sha(
        transaction: &mut Transaction<'_, MySql>,
        clip_asset_id: u64,
    ) -> Result<Option<Option<String>>, sqlx::Error> {
        sqlx::query_scalar::<_, Option<String>>(
            "SELECT CAST(sha256 AS CHAR CHARACTER SET utf8mb4)
             FROM clip_assets WHERE id = ? FOR UPDATE",
        )
        .bind(clip_asset_id)
        .fetch_optional(&mut **transaction)
        .await
    }

    async fn plan(
        transaction: &mut Transaction<'_, MySql>,
        record: &ClipAlignmentRecord,
    ) -> Result<Plan, sqlx::Error> {
        match Self::clip_sha(transaction, record.clip_asset_id).await? {
            None => return Ok(Plan::Skip("CLIP_NOT_FOUND")),
            Some(sha) if sha.as_deref() != Some(record.clip_sha256.as_str()) => {
                return Ok(Plan::Skip("CLIP_CHANGED"));
            }
            Some(_) => {}
        }
        match Self::clip_sha(transaction, record.reference_clip_asset_id).await? {
            None => return Ok(Plan::Skip("REFERENCE_NOT_FOUND")),
            Some(sha) if sha.as_deref() != Some(record.reference_clip_sha256.as_str()) => {
                return Ok(Plan::Skip("REFERENCE_CHANGED"));
            }
            Some(_) => {}
        }

        let stored = sqlx::query_as::<_, StoredAlignment>(
            "SELECT reference_clip_asset_id,
                    analyzer_version,
                    CAST(clip_sha256 AS CHAR CHARACTER SET utf8mb4) AS clip_sha256,
                    CAST(reference_clip_sha256 AS CHAR CHARACTER SET utf8mb4) AS reference_clip_sha256,
                    step_ms,
                    duration_ms,
                    reference_duration_ms,
                    CAST(positions_ms AS CHAR CHARACTER SET utf8mb4) AS positions_ms,
                    CAST(cost AS DOUBLE) AS cost
             FROM clip_alignments
             WHERE clip_asset_id = ?
             FOR UPDATE",
        )
        .bind(record.clip_asset_id)
        .fetch_optional(&mut **transaction)
        .await?;

        Ok(match stored {
            None => Plan::Insert,
            Some(stored) if same_as_stored(record, &stored) => Plan::Unchanged,
            Some(_) => Plan::Update,
        })
    }

    async fn write(
        transaction: &mut Transaction<'_, MySql>,
        record: &ClipAlignmentRecord,
    ) -> Result<(), sqlx::Error> {
        let positions = serde_json::to_string(&record.positions_ms)
            .map_err(|error| sqlx::Error::Protocol(format!("지도 직렬화 실패: {error}")))?;
        sqlx::query(
            "INSERT INTO clip_alignments
                 (clip_asset_id, reference_clip_asset_id, analyzer_version, clip_sha256,
                  reference_clip_sha256, step_ms, duration_ms, reference_duration_ms,
                  positions_ms, cost)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, CAST(? AS JSON), ?)
             ON DUPLICATE KEY UPDATE
                 reference_clip_asset_id = VALUES(reference_clip_asset_id),
                 analyzer_version = VALUES(analyzer_version),
                 clip_sha256 = VALUES(clip_sha256),
                 reference_clip_sha256 = VALUES(reference_clip_sha256),
                 step_ms = VALUES(step_ms),
                 duration_ms = VALUES(duration_ms),
                 reference_duration_ms = VALUES(reference_duration_ms),
                 positions_ms = VALUES(positions_ms),
                 cost = VALUES(cost)",
        )
        .bind(record.clip_asset_id)
        .bind(record.reference_clip_asset_id)
        .bind(&record.analyzer_version)
        .bind(&record.clip_sha256)
        .bind(&record.reference_clip_sha256)
        .bind(record.step_ms)
        .bind(record.duration_ms)
        .bind(record.reference_duration_ms)
        .bind(positions)
        .bind(record.cost)
        .execute(&mut **transaction)
        .await?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::parse_records;

    fn record_json(positions: &str) -> String {
        format!(
            r#"{{"clipAssetId":32,"referenceClipAssetId":33,"analyzerVersion":"chroma-dtw-v1","clipSha256":"{}","referenceClipSha256":"{}","stepMs":500,"durationMs":1200,"referenceDurationMs":1000,"positionsMs":{positions},"cost":0.05}}"#,
            "a".repeat(64),
            "b".repeat(64)
        )
    }

    #[test]
    fn valid_alignment_is_parsed() {
        let records = parse_records(&record_json("[0,700,1200]"), None).expect("적재 입력");
        assert_eq!(records.len(), 1);
        assert_eq!(records[0].reference_clip_asset_id, 33);
    }

    #[test]
    fn decreasing_or_overlong_positions_are_rejected() {
        assert!(parse_records(&record_json("[0,800,700]"), None).is_err());
        assert!(parse_records(&record_json("[0,700,1300]"), None).is_err());
    }

    #[test]
    fn positions_must_match_reference_length() {
        assert!(parse_records(&record_json("[0,100,200,300,400,500,600,700]"), None).is_err());
    }

    #[test]
    fn duplicates_unknown_fields_and_limit_are_rejected() {
        let line = record_json("[0,700,1200]");
        assert!(parse_records(&format!("{line}\n{line}"), None).is_err());
        let extra = line.replacen('{', r#"{"extra":1,"#, 1);
        assert!(parse_records(&extra, None).is_err());
        assert!(parse_records(&line, Some(0)).is_err());
        assert!(parse_records(&line, Some(1)).is_ok());
    }
}
