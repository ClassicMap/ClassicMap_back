//! 듣기 노트 적재기.
//!
//! `notes.jsonl` 의 구간 안내·추천 비교·연주 노트를 자연 키로 찾아 넣는다.
//! 구간은 `pieceId + sectorKey`, 연주는 그 구간 안의 `videoId` 다. DB id 는 쓰지 않으므로
//! 빈 DB 에 시드를 다시 넣은 뒤에도 같은 내용이 만들어진다.
//!
//! - 들을 곳은 클립 기준 `offsetMs` 로 적고, 넣을 때 원본 영상 시각(`atMs`)으로 바꾼다
//! - 상태(DRAFT/PUBLISHED/RETIRED)는 그대로 옮긴다. 구간 안내는 상태 열이 없어
//!   PUBLISHED 만 `performance_sectors.description` 에 넣고, 시드 행이면서 잠기지 않은
//!   구간만 바꾼다
//! - 첫 SQL 전에 모든 줄을 검증하고 한 트랜잭션으로 넣는다. 같은 입력을 다시 넣으면
//!   바뀌는 것이 없다
//! - 대상 구간이나 연주가 없으면 그 줄은 건너뛰고 보고서에 남긴다

use serde::{Deserialize, Serialize};
use serde_json::{json, Value};
use sqlx::{FromRow, MySql, Transaction};
use std::{collections::HashSet, fmt, fs, path::PathBuf};

use crate::db::DbPool;

const STATUSES: [&str; 3] = ["DRAFT", "PUBLISHED", "RETIRED"];
const MAX_TITLE_CHARS: usize = 40;

#[derive(Debug, Clone)]
pub struct ListeningNoteLoadOptions {
    pub input_path: PathBuf,
    pub dry_run: bool,
    pub limit: Option<usize>,
    pub run_id: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct NoteMoment {
    pub offset_ms: u32,
    pub label: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct PairMoment {
    pub video_id: String,
    pub offset_ms: u32,
    pub label: String,
}

#[derive(Debug, Clone, PartialEq, Deserialize)]
#[serde(tag = "kind", rename_all = "camelCase", deny_unknown_fields)]
pub enum NoteRecord {
    #[serde(rename_all = "camelCase")]
    Sector {
        piece_id: i32,
        sector_key: String,
        description: String,
        status: String,
    },
    #[serde(rename_all = "camelCase")]
    Pair {
        piece_id: i32,
        sector_key: String,
        a: String,
        b: String,
        title: String,
        note: String,
        #[serde(default)]
        moments: Vec<PairMoment>,
        /// 근거. 연주 노트와 같은 모양이고 API 는 내보내지 않는다
        #[serde(default)]
        evidence: Vec<Value>,
        status: String,
    },
    #[serde(rename_all = "camelCase")]
    Performance {
        piece_id: i32,
        sector_key: String,
        video_id: String,
        headline: String,
        note: String,
        #[serde(default)]
        moments: Vec<NoteMoment>,
        #[serde(default)]
        facts: Vec<String>,
        evidence: Vec<Value>,
        status: String,
    },
}

impl NoteRecord {
    fn status(&self) -> &str {
        match self {
            Self::Sector { status, .. }
            | Self::Pair { status, .. }
            | Self::Performance { status, .. } => status,
        }
    }

    /// 같은 대상을 두 번 적었는지 가리는 키
    fn target_key(&self) -> String {
        match self {
            Self::Sector {
                piece_id,
                sector_key,
                ..
            } => format!("sector:{piece_id}:{sector_key}"),
            Self::Pair {
                piece_id,
                sector_key,
                ..
            } => format!("pair:{piece_id}:{sector_key}"),
            Self::Performance {
                piece_id,
                sector_key,
                video_id,
                ..
            } => {
                format!("performance:{piece_id}:{sector_key}:{video_id}")
            }
        }
    }

    pub fn validate(&self) -> Result<(), String> {
        if !STATUSES.contains(&self.status()) {
            return Err(format!(
                "status 는 DRAFT·PUBLISHED·RETIRED 중 하나여야 함: {}",
                self.status()
            ));
        }
        let non_empty = |field: &str, value: &str| {
            if value.trim().is_empty() {
                Err(format!("{field} 가 비었음"))
            } else {
                Ok(())
            }
        };
        let short = |field: &str, value: &str| {
            if value.chars().count() > MAX_TITLE_CHARS {
                Err(format!("{field} 는 {MAX_TITLE_CHARS}자 안쪽이어야 함"))
            } else {
                Ok(())
            }
        };
        match self {
            Self::Sector {
                piece_id,
                sector_key,
                description,
                ..
            } => {
                valid_target(*piece_id, sector_key)?;
                non_empty("description", description)
            }
            Self::Pair {
                piece_id,
                sector_key,
                a,
                b,
                title,
                note,
                moments,
                ..
            } => {
                valid_target(*piece_id, sector_key)?;
                valid_video_id(a)?;
                valid_video_id(b)?;
                if a == b {
                    return Err("추천 비교의 a 와 b 가 같은 영상임".to_string());
                }
                non_empty("title", title)?;
                short("title", title)?;
                non_empty("note", note)?;
                for moment in moments {
                    if moment.video_id != *a && moment.video_id != *b {
                        return Err(format!("들을 곳 영상 {} 가 a·b 가 아님", moment.video_id));
                    }
                    non_empty("moments.label", &moment.label)?;
                }
                Ok(())
            }
            Self::Performance {
                piece_id,
                sector_key,
                video_id,
                headline,
                note,
                moments,
                facts,
                ..
            } => {
                valid_target(*piece_id, sector_key)?;
                valid_video_id(video_id)?;
                non_empty("headline", headline)?;
                short("headline", headline)?;
                non_empty("note", note)?;
                for moment in moments {
                    non_empty("moments.label", &moment.label)?;
                }
                for fact in facts {
                    non_empty("facts", fact)?;
                }
                Ok(())
            }
        }
    }
}

fn valid_target(piece_id: i32, sector_key: &str) -> Result<(), String> {
    if piece_id <= 0 {
        return Err("pieceId 는 양수여야 함".to_string());
    }
    if sector_key.trim().is_empty() || !sector_key.is_ascii() {
        return Err("sectorKey 는 비어 있지 않은 ASCII 여야 함".to_string());
    }
    Ok(())
}

fn valid_video_id(video_id: &str) -> Result<(), String> {
    if video_id.len() == 11
        && video_id
            .bytes()
            .all(|byte| byte.is_ascii_alphanumeric() || byte == b'-' || byte == b'_')
    {
        Ok(())
    } else {
        Err(format!("YouTube 영상 id 가 아님: {video_id}"))
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct NoteMutationCounts {
    pub sectors_updated: u64,
    pub pairs_inserted: u64,
    pub pairs_updated: u64,
    pub notes_inserted: u64,
    pub notes_updated: u64,
    pub total: u64,
}

impl NoteMutationCounts {
    fn finish(mut self) -> Self {
        self.total = self.sectors_updated
            + self.pairs_inserted
            + self.pairs_updated
            + self.notes_inserted
            + self.notes_updated;
        self
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SkippedNote {
    pub line: usize,
    pub target: String,
    pub reason: &'static str,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ListeningNoteLoadReport {
    pub status: &'static str,
    pub input_path: String,
    pub row_count: usize,
    pub dry_run: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    pub unchanged: usize,
    pub mutations: NoteMutationCounts,
    pub planned_mutations: NoteMutationCounts,
    pub skipped: Vec<SkippedNote>,
}

#[derive(Debug)]
pub enum ListeningNoteLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
}

impl ListeningNoteLoadError {
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

impl fmt::Display for ListeningNoteLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for ListeningNoteLoadError {}

impl From<sqlx::Error> for ListeningNoteLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// JSONL 을 읽어 검증한다. 같은 대상이 두 번 나오면 거부한다. 줄 번호와 함께 돌려준다
pub fn parse_records(
    text: &str,
    limit: Option<usize>,
) -> Result<Vec<(usize, NoteRecord)>, ListeningNoteLoadError> {
    let mut records = Vec::new();
    let mut seen = HashSet::new();
    for (index, line) in text.lines().enumerate() {
        let line_number = index + 1;
        if line.trim().is_empty() {
            continue;
        }
        let record: NoteRecord = serde_json::from_str(line).map_err(|error| {
            ListeningNoteLoadError::input("INVALID_JSON", error.to_string(), Some(line_number))
        })?;
        record.validate().map_err(|message| {
            ListeningNoteLoadError::input("INVALID_NOTE", message, Some(line_number))
        })?;
        if !seen.insert(record.target_key()) {
            return Err(ListeningNoteLoadError::input(
                "DUPLICATE_TARGET",
                format!("같은 대상이 두 번 나옴: {}", record.target_key()),
                Some(line_number),
            ));
        }
        records.push((line_number, record));
    }
    if let Some(limit) = limit {
        if records.len() > limit {
            return Err(ListeningNoteLoadError::input(
                "LIMIT_EXCEEDED",
                format!("입력 {}줄이 --limit {limit} 을 넘음", records.len()),
                None,
            ));
        }
    }
    Ok(records)
}

#[derive(Debug, FromRow)]
struct SectorRow {
    id: i32,
    origin: String,
    editor_locked: bool,
    description: Option<String>,
}

#[derive(Debug, Clone, Copy, FromRow)]
struct PerformanceRow {
    id: i32,
    start_ms: u32,
    end_ms: u32,
}

#[derive(Debug, FromRow)]
struct StoredNote {
    headline: String,
    note: String,
    moments: Option<String>,
    facts: Option<String>,
    evidence: String,
    editorial_status: String,
}

#[derive(Debug, FromRow)]
struct StoredPair {
    performance_a_id: i32,
    performance_b_id: i32,
    title: String,
    note: String,
    moments: Option<String>,
    evidence: Option<String>,
    editorial_status: String,
}

/// 클립 기준 오프셋을 원본 영상 시각으로. 클립 밖이면 None
fn source_time(performance: PerformanceRow, offset_ms: u32) -> Option<u32> {
    let length = performance.end_ms.checked_sub(performance.start_ms)?;
    (offset_ms <= length).then(|| performance.start_ms + offset_ms)
}

fn parse_json(raw: Option<&str>) -> Value {
    raw.and_then(|text| serde_json::from_str(text).ok())
        .unwrap_or(Value::Null)
}

/// 비어 있는 배열은 NULL 로 넣는다. 다시 읽을 때도 NULL 과 같게 본다
fn optional_array(values: Vec<Value>) -> Value {
    if values.is_empty() {
        Value::Null
    } else {
        Value::Array(values)
    }
}

/// 빈 배열과 NULL 을 같게 본다
fn empty_as_null(value: Value) -> Value {
    match value {
        Value::Array(items) if items.is_empty() => Value::Null,
        other => other,
    }
}

fn json_text(value: &Value) -> Option<String> {
    (!value.is_null()).then(|| value.to_string())
}

enum Outcome {
    Unchanged,
    Skipped(&'static str),
    SectorUpdated,
    PairInserted,
    PairUpdated,
    NoteInserted,
    NoteUpdated,
}

pub struct ListeningNoteLoader;

impl ListeningNoteLoader {
    pub async fn load(
        pool: &DbPool,
        options: &ListeningNoteLoadOptions,
    ) -> Result<ListeningNoteLoadReport, ListeningNoteLoadError> {
        let text = fs::read_to_string(&options.input_path).map_err(|error| {
            ListeningNoteLoadError::input(
                "INPUT_READ_ERROR",
                format!("입력을 읽을 수 없음: {error}"),
                None,
            )
        })?;
        let records = parse_records(&text, options.limit)?;

        let mut transaction = pool.begin().await?;
        let mut planned = NoteMutationCounts::default();
        let mut unchanged = 0;
        let mut skipped = Vec::new();

        for (line, record) in &records {
            let outcome = match record {
                NoteRecord::Sector { .. } => Self::apply_sector(&mut transaction, record).await?,
                NoteRecord::Pair { .. } => Self::apply_pair(&mut transaction, record).await?,
                NoteRecord::Performance { .. } => {
                    Self::apply_note(&mut transaction, record).await?
                }
            };
            match outcome {
                Outcome::Unchanged => unchanged += 1,
                Outcome::Skipped(reason) => skipped.push(SkippedNote {
                    line: *line,
                    target: record.target_key(),
                    reason,
                }),
                Outcome::SectorUpdated => planned.sectors_updated += 1,
                Outcome::PairInserted => planned.pairs_inserted += 1,
                Outcome::PairUpdated => planned.pairs_updated += 1,
                Outcome::NoteInserted => planned.notes_inserted += 1,
                Outcome::NoteUpdated => planned.notes_updated += 1,
            }
        }

        let planned = planned.finish();
        let mutations = if options.dry_run {
            transaction.rollback().await?;
            NoteMutationCounts::default()
        } else {
            transaction.commit().await?;
            planned.clone()
        };

        Ok(ListeningNoteLoadReport {
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

    async fn find_sector(
        transaction: &mut Transaction<'_, MySql>,
        piece_id: i32,
        sector_key: &str,
    ) -> Result<Option<SectorRow>, sqlx::Error> {
        sqlx::query_as::<_, SectorRow>(
            "SELECT id,
                    CAST(origin AS CHAR CHARACTER SET utf8mb4) AS origin,
                    editor_locked,
                    description
             FROM performance_sectors
             WHERE piece_id = ? AND sector_key = ?
             FOR UPDATE",
        )
        .bind(piece_id)
        .bind(sector_key)
        .fetch_optional(&mut **transaction)
        .await
    }

    /// 구간 안의 연주를 영상 id 로 찾는다. 없으면 None, 둘 이상이면 Err
    async fn find_performance(
        transaction: &mut Transaction<'_, MySql>,
        sector_id: i32,
        video_id: &str,
    ) -> Result<Result<Option<PerformanceRow>, &'static str>, sqlx::Error> {
        let rows = sqlx::query_as::<_, PerformanceRow>(
            "SELECT performance.id, performance.start_ms, performance.end_ms
             FROM performances performance
             JOIN performance_sources source ON source.id = performance.performance_source_id
             WHERE performance.sector_id = ?
               AND source.provider_video_id = ?
               AND performance.start_ms IS NOT NULL
               AND performance.end_ms IS NOT NULL",
        )
        .bind(sector_id)
        .bind(video_id)
        .fetch_all(&mut **transaction)
        .await?;
        Ok(match rows.as_slice() {
            [] => Ok(None),
            [row] => Ok(Some(*row)),
            _ => Err("PERFORMANCE_AMBIGUOUS"),
        })
    }

    async fn apply_sector(
        transaction: &mut Transaction<'_, MySql>,
        record: &NoteRecord,
    ) -> Result<Outcome, sqlx::Error> {
        let NoteRecord::Sector {
            piece_id,
            sector_key,
            description,
            status,
        } = record
        else {
            unreachable!("구간 안내만 온다");
        };
        let Some(sector) = Self::find_sector(transaction, *piece_id, sector_key).await? else {
            return Ok(Outcome::Skipped("SECTOR_NOT_FOUND"));
        };
        if sector.description.as_deref() == Some(description.as_str()) {
            return Ok(Outcome::Unchanged);
        }
        if status != "PUBLISHED" {
            return Ok(Outcome::Skipped("SECTOR_GUIDE_NOT_PUBLISHED"));
        }
        if sector.origin != "seed" || sector.editor_locked {
            return Ok(Outcome::Skipped("SECTOR_LOCKED"));
        }
        sqlx::query(
            "UPDATE performance_sectors SET description = ?
             WHERE id = ? AND origin = 'seed' AND editor_locked = FALSE",
        )
        .bind(description)
        .bind(sector.id)
        .execute(&mut **transaction)
        .await?;
        Ok(Outcome::SectorUpdated)
    }

    async fn apply_pair(
        transaction: &mut Transaction<'_, MySql>,
        record: &NoteRecord,
    ) -> Result<Outcome, sqlx::Error> {
        let NoteRecord::Pair {
            piece_id,
            sector_key,
            a,
            b,
            title,
            note,
            moments,
            evidence,
            status,
        } = record
        else {
            unreachable!("추천 비교만 온다");
        };
        let Some(sector) = Self::find_sector(transaction, *piece_id, sector_key).await? else {
            return Ok(Outcome::Skipped("SECTOR_NOT_FOUND"));
        };
        let performance_a = match Self::find_performance(transaction, sector.id, a).await? {
            Ok(Some(row)) => row,
            Ok(None) => return Ok(Outcome::Skipped("PERFORMANCE_NOT_FOUND")),
            Err(reason) => return Ok(Outcome::Skipped(reason)),
        };
        let performance_b = match Self::find_performance(transaction, sector.id, b).await? {
            Ok(Some(row)) => row,
            Ok(None) => return Ok(Outcome::Skipped("PERFORMANCE_NOT_FOUND")),
            Err(reason) => return Ok(Outcome::Skipped(reason)),
        };
        let mut stored_moments = Vec::new();
        for moment in moments {
            let performance = if moment.video_id == *a {
                performance_a
            } else {
                performance_b
            };
            let Some(at_ms) = source_time(performance, moment.offset_ms) else {
                return Ok(Outcome::Skipped("MOMENT_OUTSIDE_CLIP"));
            };
            stored_moments.push(json!({
                "performanceId": performance.id,
                "atMs": at_ms,
                "label": moment.label,
            }));
        }
        let moments_value = optional_array(stored_moments);
        let evidence_value = optional_array(evidence.clone());

        let existing = sqlx::query_as::<_, StoredPair>(
            "SELECT performance_a_id, performance_b_id, title, note,
                    CAST(moments AS CHAR CHARACTER SET utf8mb4) AS moments,
                    CAST(evidence AS CHAR CHARACTER SET utf8mb4) AS evidence,
                    CAST(editorial_status AS CHAR CHARACTER SET utf8mb4) AS editorial_status
             FROM sector_featured_pairs WHERE sector_id = ? FOR UPDATE",
        )
        .bind(sector.id)
        .fetch_optional(&mut **transaction)
        .await?;

        if let Some(existing) = &existing {
            if existing.performance_a_id == performance_a.id
                && existing.performance_b_id == performance_b.id
                && existing.title == *title
                && existing.note == *note
                && parse_json(existing.moments.as_deref()) == moments_value
                && empty_as_null(parse_json(existing.evidence.as_deref())) == evidence_value
                && existing.editorial_status == *status
            {
                return Ok(Outcome::Unchanged);
            }
        }

        sqlx::query(
            "INSERT INTO sector_featured_pairs
                 (sector_id, performance_a_id, performance_b_id, title, note, moments,
                  evidence, editorial_status, reviewed_at)
             VALUES (?, ?, ?, ?, ?, CAST(? AS JSON), CAST(? AS JSON), ?,
                     IF(? = 'PUBLISHED', CURRENT_TIMESTAMP(6), NULL))
             ON DUPLICATE KEY UPDATE
                 reviewed_at = IF(VALUES(editorial_status) = 'PUBLISHED'
                                  AND editorial_status <> 'PUBLISHED',
                                  CURRENT_TIMESTAMP(6), reviewed_at),
                 performance_a_id = VALUES(performance_a_id),
                 performance_b_id = VALUES(performance_b_id),
                 title = VALUES(title),
                 note = VALUES(note),
                 moments = VALUES(moments),
                 evidence = VALUES(evidence),
                 editorial_status = VALUES(editorial_status)",
        )
        .bind(sector.id)
        .bind(performance_a.id)
        .bind(performance_b.id)
        .bind(title)
        .bind(note)
        .bind(json_text(&moments_value))
        .bind(json_text(&evidence_value))
        .bind(status)
        .bind(status)
        .execute(&mut **transaction)
        .await?;
        Ok(if existing.is_some() {
            Outcome::PairUpdated
        } else {
            Outcome::PairInserted
        })
    }

    async fn apply_note(
        transaction: &mut Transaction<'_, MySql>,
        record: &NoteRecord,
    ) -> Result<Outcome, sqlx::Error> {
        let NoteRecord::Performance {
            piece_id,
            sector_key,
            video_id,
            headline,
            note,
            moments,
            facts,
            evidence,
            status,
        } = record
        else {
            unreachable!("연주 노트만 온다");
        };
        let Some(sector) = Self::find_sector(transaction, *piece_id, sector_key).await? else {
            return Ok(Outcome::Skipped("SECTOR_NOT_FOUND"));
        };
        let performance = match Self::find_performance(transaction, sector.id, video_id).await? {
            Ok(Some(row)) => row,
            Ok(None) => return Ok(Outcome::Skipped("PERFORMANCE_NOT_FOUND")),
            Err(reason) => return Ok(Outcome::Skipped(reason)),
        };
        let mut stored_moments = Vec::new();
        for moment in moments {
            let Some(at_ms) = source_time(performance, moment.offset_ms) else {
                return Ok(Outcome::Skipped("MOMENT_OUTSIDE_CLIP"));
            };
            stored_moments.push(json!({ "atMs": at_ms, "label": moment.label }));
        }
        let moments_value = optional_array(stored_moments);
        let facts_value = Value::Array(facts.iter().cloned().map(Value::String).collect());
        let evidence_value = Value::Array(evidence.clone());

        let existing = sqlx::query_as::<_, StoredNote>(
            "SELECT headline, note,
                    CAST(moments AS CHAR CHARACTER SET utf8mb4) AS moments,
                    CAST(facts AS CHAR CHARACTER SET utf8mb4) AS facts,
                    CAST(evidence AS CHAR CHARACTER SET utf8mb4) AS evidence,
                    CAST(editorial_status AS CHAR CHARACTER SET utf8mb4) AS editorial_status
             FROM performance_listening_notes WHERE performance_id = ? FOR UPDATE",
        )
        .bind(performance.id)
        .fetch_optional(&mut **transaction)
        .await?;

        if let Some(existing) = &existing {
            let stored_facts = match parse_json(existing.facts.as_deref()) {
                Value::Null => Value::Array(Vec::new()),
                value => value,
            };
            if existing.headline == *headline
                && existing.note == *note
                && parse_json(existing.moments.as_deref()) == moments_value
                && stored_facts == facts_value
                && parse_json(Some(&existing.evidence)) == evidence_value
                && existing.editorial_status == *status
            {
                return Ok(Outcome::Unchanged);
            }
        }

        sqlx::query(
            "INSERT INTO performance_listening_notes
                 (performance_id, headline, note, moments, facts, evidence,
                  editorial_status, reviewed_at)
             VALUES (?, ?, ?, CAST(? AS JSON), CAST(? AS JSON), CAST(? AS JSON), ?,
                     IF(? = 'PUBLISHED', CURRENT_TIMESTAMP(6), NULL))
             ON DUPLICATE KEY UPDATE
                 reviewed_at = IF(VALUES(editorial_status) = 'PUBLISHED'
                                  AND editorial_status <> 'PUBLISHED',
                                  CURRENT_TIMESTAMP(6), reviewed_at),
                 headline = VALUES(headline),
                 note = VALUES(note),
                 moments = VALUES(moments),
                 facts = VALUES(facts),
                 evidence = VALUES(evidence),
                 editorial_status = VALUES(editorial_status)",
        )
        .bind(performance.id)
        .bind(headline)
        .bind(note)
        .bind(json_text(&moments_value))
        .bind(facts_value.to_string())
        .bind(evidence_value.to_string())
        .bind(status)
        .bind(status)
        .execute(&mut **transaction)
        .await?;
        Ok(if existing.is_some() {
            Outcome::NoteUpdated
        } else {
            Outcome::NoteInserted
        })
    }
}

#[cfg(test)]
mod tests {
    use super::{parse_records, source_time, NoteRecord, PerformanceRow};

    const PERFORMANCE: &str = r#"{"kind":"performance","pieceId":140,"sectorKey":"coda","videoId":"0FbQZCsYXVg","headline":"처음부터 천둥처럼","note":"두세 문장.","moments":[{"offsetMs":2600,"label":"벌써 거의 최대"}],"evidence":[{"kind":"listening","status":"done"}],"status":"PUBLISHED"}"#;
    const PAIR: &str = r#"{"kind":"pair","pieceId":140,"sectorKey":"coda","a":"0FbQZCsYXVg","b":"cIxGUAnj46U","title":"쏟아내기 vs 쌓아 올리기","note":"노트.","moments":[{"videoId":"cIxGUAnj46U","offsetMs":19000,"label":"랑랑의 정점"}],"status":"DRAFT"}"#;
    const SECTOR: &str = r#"{"kind":"sector","pieceId":140,"sectorKey":"coda","description":"안내.","status":"PUBLISHED"}"#;

    #[test]
    fn three_kinds_are_parsed() {
        let records =
            parse_records(&format!("{SECTOR}\n{PAIR}\n\n{PERFORMANCE}"), None).expect("노트");
        assert_eq!(records.len(), 3);
        assert_eq!(records[2].0, 4, "빈 줄을 건너뛰어도 줄 번호는 파일 기준");
        assert!(matches!(records[1].1, NoteRecord::Pair { .. }));
    }

    #[test]
    fn bad_records_are_rejected() {
        let bad = [
            PERFORMANCE.replace("PUBLISHED", "LIVE"),
            PERFORMANCE.replace("0FbQZCsYXVg", "short"),
            PERFORMANCE.replace("처음부터 천둥처럼", &"가".repeat(41)),
            PAIR.replace("\"b\":\"cIxGUAnj46U\"", "\"b\":\"0FbQZCsYXVg\""),
            PAIR.replace("\"videoId\":\"cIxGUAnj46U\"", "\"videoId\":\"kkq_3CrvFUM\""),
            PERFORMANCE.replacen('{', r#"{"extra":1,"#, 1),
            PERFORMANCE.replace(
                ",\"evidence\":[{\"kind\":\"listening\",\"status\":\"done\"}]",
                "",
            ),
        ];
        for line in bad {
            assert!(parse_records(&line, None).is_err(), "{line}");
        }
    }

    #[test]
    fn duplicate_target_and_limit_are_rejected() {
        assert!(parse_records(&format!("{PERFORMANCE}\n{PERFORMANCE}"), None).is_err());
        assert!(parse_records(PERFORMANCE, Some(0)).is_err());
        assert!(parse_records(PERFORMANCE, Some(1)).is_ok());
    }

    #[test]
    fn offsets_become_source_time_inside_clip() {
        let performance = PerformanceRow {
            id: 93,
            start_ms: 236_000,
            end_ms: 259_000,
        };
        assert_eq!(source_time(performance, 2_600), Some(238_600));
        assert_eq!(source_time(performance, 23_000), Some(259_000));
        assert_eq!(source_time(performance, 23_001), None);
    }
}
