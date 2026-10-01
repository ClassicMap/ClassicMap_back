//! 클립 음량 곡선 적재기.
//!
//! `scripts/measure_loudness.py` 가 낸 JSONL 을 `clip_loudness_profiles` 에 넣는다.
//! 첫 SQL 전에 모든 줄을 검증하고, 한 트랜잭션에서 넣는다. 같은 입력을 다시 넣으면
//! 바뀌는 것이 없다(두 번째 dry-run 의 계획 변경 수는 0 이다).
//! 잰 파일의 해시가 지금 클립과 다르거나 클립이 없으면 그 줄은 건너뛰고 보고서에 남긴다.

use serde::{Deserialize, Serialize};
use sqlx::{FromRow, MySql, Transaction};
use std::{collections::HashSet, fmt, fs, path::PathBuf};

use crate::db::DbPool;

/// 기술적 최대 구간 600초를 0.5초 간격으로 잰 점 수
pub const MAX_CURVE_POINTS: usize = 1_201;
/// 상대 곡선의 바닥. 측정 스크립트와 같다
pub const FLOOR_REL_DB: f64 = -60.0;

#[derive(Debug, Clone)]
pub struct LoudnessLoadOptions {
    pub input_path: PathBuf,
    pub dry_run: bool,
    /// 입력이 이 줄 수를 넘으면 적재하지 않는다
    pub limit: Option<usize>,
    pub run_id: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct LoudnessProfileRecord {
    pub clip_asset_id: u64,
    pub analyzer_version: String,
    pub clip_sha256: String,
    pub step_ms: u16,
    pub duration_ms: u32,
    pub curve_rel_db: Vec<f64>,
    pub start_rel_db: f64,
    pub peak_ms: u32,
    pub peak_ratio: f64,
    pub range_db: f64,
}

impl LoudnessProfileRecord {
    pub fn validate(&self) -> Result<(), String> {
        let version = self.analyzer_version.trim();
        if version.is_empty() || version.len() > 32 {
            return Err("analyzerVersion 은 1~32자여야 함".to_string());
        }
        if self.clip_sha256.len() != 64
            || !self
                .clip_sha256
                .bytes()
                .all(|byte| byte.is_ascii_digit() || (b'a'..=b'f').contains(&byte))
        {
            return Err("clipSha256 은 소문자 16진수 64자여야 함".to_string());
        }
        if self.step_ms == 0 {
            return Err("stepMs 는 0보다 커야 함".to_string());
        }
        if self.duration_ms == 0 || self.duration_ms > 600_000 {
            return Err("durationMs 는 1~600000 이어야 함".to_string());
        }
        let points = self.curve_rel_db.len();
        if points == 0 || points > MAX_CURVE_POINTS {
            return Err(format!("curveRelDb 점 수가 범위 밖임: {points}"));
        }
        let expected = (self.duration_ms / u32::from(self.step_ms)) as usize + 1;
        if points.abs_diff(expected) > 2 {
            return Err(format!(
                "curveRelDb 점 수({points})가 길이로 셈한 값({expected})과 맞지 않음"
            ));
        }
        if self
            .curve_rel_db
            .iter()
            .any(|value| !value.is_finite() || *value > 0.0 || *value < FLOOR_REL_DB)
        {
            return Err("curveRelDb 는 -60~0 사이 값이어야 함".to_string());
        }
        if !self.curve_rel_db.contains(&0.0) {
            return Err("curveRelDb 에 가장 센 곳(0)이 없음".to_string());
        }
        if !(FLOOR_REL_DB..=0.0).contains(&self.start_rel_db) {
            return Err("startRelDb 는 -60~0 사이여야 함".to_string());
        }
        if self.peak_ms > self.duration_ms {
            return Err("peakMs 가 클립 길이를 넘음".to_string());
        }
        if !(0.0..=1.0).contains(&self.peak_ratio) {
            return Err("peakRatio 는 0~1 이어야 함".to_string());
        }
        if !(0.0..=-FLOOR_REL_DB).contains(&self.range_db) {
            return Err("rangeDb 는 0~60 이어야 함".to_string());
        }
        Ok(())
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LoudnessMutationCounts {
    pub inserted: u64,
    pub updated: u64,
    pub total: u64,
}

impl LoudnessMutationCounts {
    fn finish(mut self) -> Self {
        self.total = self.inserted + self.updated;
        self
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SkippedProfile {
    pub clip_asset_id: u64,
    pub reason: &'static str,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LoudnessLoadReport {
    pub status: &'static str,
    pub input_path: String,
    pub row_count: usize,
    pub dry_run: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    pub unchanged: usize,
    pub mutations: LoudnessMutationCounts,
    pub planned_mutations: LoudnessMutationCounts,
    pub skipped: Vec<SkippedProfile>,
}

#[derive(Debug)]
pub enum LoudnessLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
}

impl LoudnessLoadError {
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

impl fmt::Display for LoudnessLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for LoudnessLoadError {}

impl From<sqlx::Error> for LoudnessLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// JSONL 을 읽어 검증한다. 빈 줄은 건너뛴다. 같은 클립이 두 번 나오면 거부한다
pub fn parse_records(
    text: &str,
    limit: Option<usize>,
) -> Result<Vec<LoudnessProfileRecord>, LoudnessLoadError> {
    let mut records = Vec::new();
    let mut seen = HashSet::new();
    for (index, line) in text.lines().enumerate() {
        let line_number = index + 1;
        if line.trim().is_empty() {
            continue;
        }
        let record: LoudnessProfileRecord = serde_json::from_str(line).map_err(|error| {
            LoudnessLoadError::input("INVALID_JSON", error.to_string(), Some(line_number))
        })?;
        record.validate().map_err(|message| {
            LoudnessLoadError::input("INVALID_PROFILE", message, Some(line_number))
        })?;
        if !seen.insert(record.clip_asset_id) {
            return Err(LoudnessLoadError::input(
                "DUPLICATE_CLIP",
                format!("clipAssetId {} 가 두 번 나옴", record.clip_asset_id),
                Some(line_number),
            ));
        }
        records.push(record);
    }
    if let Some(limit) = limit {
        if records.len() > limit {
            return Err(LoudnessLoadError::input(
                "LIMIT_EXCEEDED",
                format!("입력 {}줄이 --limit {limit} 을 넘음", records.len()),
                None,
            ));
        }
    }
    Ok(records)
}

#[derive(Debug, FromRow)]
struct StoredProfile {
    analyzer_version: String,
    clip_sha256: String,
    step_ms: u16,
    duration_ms: u32,
    curve_rel_db: String,
    start_rel_db: f64,
    peak_ms: u32,
    peak_ratio: f64,
    range_db: f64,
}

/// DB 에 든 값이 이 기록과 같은지. 소수 자리는 열의 정밀도까지만 견준다
fn same_as_stored(record: &LoudnessProfileRecord, stored: &StoredProfile) -> bool {
    let close = |left: f64, right: f64, tolerance: f64| (left - right).abs() <= tolerance;
    let curve: Vec<f64> = match serde_json::from_str(&stored.curve_rel_db) {
        Ok(curve) => curve,
        Err(_) => return false,
    };
    stored.analyzer_version == record.analyzer_version
        && stored.clip_sha256 == record.clip_sha256
        && stored.step_ms == record.step_ms
        && stored.duration_ms == record.duration_ms
        && stored.peak_ms == record.peak_ms
        && close(stored.start_rel_db, record.start_rel_db, 0.05)
        && close(stored.peak_ratio, record.peak_ratio, 0.0005)
        && close(stored.range_db, record.range_db, 0.05)
        && curve.len() == record.curve_rel_db.len()
        && curve
            .iter()
            .zip(&record.curve_rel_db)
            .all(|(left, right)| close(*left, *right, 1e-6))
}

enum Plan {
    Insert,
    Update,
    Unchanged,
    Skip(&'static str),
}

pub struct LoudnessProfileLoader;

impl LoudnessProfileLoader {
    pub async fn load(
        pool: &DbPool,
        options: &LoudnessLoadOptions,
    ) -> Result<LoudnessLoadReport, LoudnessLoadError> {
        let text = fs::read_to_string(&options.input_path).map_err(|error| {
            LoudnessLoadError::input(
                "INPUT_READ_ERROR",
                format!("입력을 읽을 수 없음: {error}"),
                None,
            )
        })?;
        let records = parse_records(&text, options.limit)?;

        let mut transaction = pool.begin().await?;
        let mut planned = LoudnessMutationCounts::default();
        let mut unchanged = 0;
        let mut skipped = Vec::new();

        for record in &records {
            match Self::plan(&mut transaction, record).await? {
                Plan::Skip(reason) => skipped.push(SkippedProfile {
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
            LoudnessMutationCounts::default()
        } else {
            transaction.commit().await?;
            planned.clone()
        };

        Ok(LoudnessLoadReport {
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
        record: &LoudnessProfileRecord,
    ) -> Result<Plan, sqlx::Error> {
        let clip_sha = sqlx::query_scalar::<_, Option<String>>(
            "SELECT CAST(sha256 AS CHAR CHARACTER SET utf8mb4)
             FROM clip_assets WHERE id = ? FOR UPDATE",
        )
        .bind(record.clip_asset_id)
        .fetch_optional(&mut **transaction)
        .await?;
        match clip_sha {
            None => return Ok(Plan::Skip("CLIP_NOT_FOUND")),
            Some(sha) if sha.as_deref() != Some(record.clip_sha256.as_str()) => {
                return Ok(Plan::Skip("CLIP_CHANGED"));
            }
            Some(_) => {}
        }

        let stored = sqlx::query_as::<_, StoredProfile>(
            "SELECT analyzer_version,
                    CAST(clip_sha256 AS CHAR CHARACTER SET utf8mb4) AS clip_sha256,
                    step_ms,
                    duration_ms,
                    CAST(curve_rel_db AS CHAR CHARACTER SET utf8mb4) AS curve_rel_db,
                    CAST(start_rel_db AS DOUBLE) AS start_rel_db,
                    peak_ms,
                    CAST(peak_ratio AS DOUBLE) AS peak_ratio,
                    CAST(range_db AS DOUBLE) AS range_db
             FROM clip_loudness_profiles
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
        record: &LoudnessProfileRecord,
    ) -> Result<(), sqlx::Error> {
        let curve = serde_json::to_string(&record.curve_rel_db)
            .map_err(|error| sqlx::Error::Protocol(format!("곡선 직렬화 실패: {error}")))?;
        sqlx::query(
            "INSERT INTO clip_loudness_profiles
                 (clip_asset_id, analyzer_version, clip_sha256, step_ms, duration_ms,
                  curve_rel_db, start_rel_db, peak_ms, peak_ratio, range_db)
             VALUES (?, ?, ?, ?, ?, CAST(? AS JSON), ?, ?, ?, ?)
             ON DUPLICATE KEY UPDATE
                 analyzer_version = VALUES(analyzer_version),
                 clip_sha256 = VALUES(clip_sha256),
                 step_ms = VALUES(step_ms),
                 duration_ms = VALUES(duration_ms),
                 curve_rel_db = VALUES(curve_rel_db),
                 start_rel_db = VALUES(start_rel_db),
                 peak_ms = VALUES(peak_ms),
                 peak_ratio = VALUES(peak_ratio),
                 range_db = VALUES(range_db)",
        )
        .bind(record.clip_asset_id)
        .bind(&record.analyzer_version)
        .bind(&record.clip_sha256)
        .bind(record.step_ms)
        .bind(record.duration_ms)
        .bind(curve)
        .bind(record.start_rel_db)
        .bind(record.peak_ms)
        .bind(record.peak_ratio)
        .bind(record.range_db)
        .execute(&mut **transaction)
        .await?;
        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use super::{parse_records, LoudnessProfileRecord};

    fn record_json(curve: &str) -> String {
        format!(
            r#"{{"clipAssetId":32,"analyzerVersion":"ebur128-short-v1","clipSha256":"{}","stepMs":500,"durationMs":1000,"curveRelDb":{curve},"startRelDb":-0.5,"peakMs":500,"peakRatio":0.5,"rangeDb":1.0}}"#,
            "a".repeat(64)
        )
    }

    #[test]
    fn valid_profile_is_parsed() {
        let records = parse_records(&record_json("[-1.0,0.0,-0.5]"), None).expect("적재 입력");
        assert_eq!(records.len(), 1);
        assert_eq!(records[0].clip_asset_id, 32);
    }

    #[test]
    fn curve_without_peak_or_out_of_range_is_rejected() {
        assert!(parse_records(&record_json("[-1.0,-0.2,-0.5]"), None).is_err());
        assert!(parse_records(&record_json("[-1.0,0.0,0.4]"), None).is_err());
        assert!(parse_records(&record_json("[-61.0,0.0,-0.5]"), None).is_err());
    }

    #[test]
    fn curve_length_must_match_duration() {
        assert!(parse_records(&record_json("[0.0,-1,-1,-1,-1,-1,-1]"), None).is_err());
    }

    #[test]
    fn duplicates_unknown_fields_and_limit_are_rejected() {
        let line = record_json("[-1.0,0.0,-0.5]");
        assert!(parse_records(&format!("{line}\n{line}"), None).is_err());
        let extra = line.replacen('{', r#"{"extra":1,"#, 1);
        assert!(parse_records(&extra, None).is_err());
        assert!(parse_records(&line, Some(0)).is_err());
        assert!(parse_records(&line, Some(1)).is_ok());
    }

    #[test]
    fn bad_sha_is_rejected() {
        let record = LoudnessProfileRecord {
            clip_asset_id: 1,
            analyzer_version: "v".to_string(),
            clip_sha256: "XYZ".to_string(),
            step_ms: 500,
            duration_ms: 1000,
            curve_rel_db: vec![0.0, -1.0, -1.0],
            start_rel_db: -0.5,
            peak_ms: 0,
            peak_ratio: 0.0,
            range_db: 1.0,
        };
        assert!(record.validate().is_err());
    }
}
