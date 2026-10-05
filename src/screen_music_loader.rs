//! 영화 속 클래식 적재기.
//!
//! `titles.jsonl` 의 한 줄은 영상 작품 하나와 그 안의 큐(장면 하나에 쓰인 곡 하나)들이다.
//! 작품은 `slug`, 큐는 `(작품, key)` 로 찾아 넣거나 고친다. 비교 구간은 `pieceId + sectorKey` 로 찾는다.
//! 첫 SQL 전에 모든 줄을 검증하고 한 트랜잭션으로 넣는다. 같은 입력을 다시 넣으면 바뀌는 것이 없다
//! (두 번째 dry-run 의 계획 변경 수는 0 이다).
//! 포스터·스틸 경로(`refresh_screen_images`)와 관리자가 고른 장면 스틸(`still_path`)은 건드리지 않는다.
//! 입력에서 빠진 큐는 지우지 않고 보고서의 `orphanCues` 에만 남긴다.

use serde::{Deserialize, Serialize};
use serde_json::Value;
use sqlx::{FromRow, MySql, Transaction};
use std::{
    collections::{BTreeMap, HashSet},
    fmt, fs,
    path::PathBuf,
};

use crate::db::DbPool;

pub const KINDS: [&str; 3] = ["MOVIE", "SERIES", "ANIME"];
pub const USAGES: [&str; 4] = ["SCORE", "SOURCE", "PERFORMED", "TITLES"];
pub const STATUSES: [&str; 2] = ["DRAFT", "PUBLISHED"];
pub const NAMESPACES: [&str; 7] = [
    "wikidata",
    "imdb",
    "tmdb_movie",
    "tmdb_tv",
    "kmdb",
    "anilist",
    "musicbrainz_release_group",
];
const EVIDENCE_GRADES: [&str; 2] = ["1", "2"];
const MAX_SCENE_NOTE_CHARS: usize = 200;
const MAX_KEY_LEN: usize = 100;
const MAX_CUES_PER_TITLE: usize = 12;

#[derive(Debug, Clone)]
pub struct ScreenMusicLoadOptions {
    pub input_path: PathBuf,
    pub dry_run: bool,
    /// 입력이 이 줄 수를 넘으면 적재하지 않는다
    pub limit: Option<usize>,
    pub run_id: Option<String>,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct OfficialClip {
    pub video_id: String,
    pub start_sec: u32,
    pub channel: String,
    pub title: String,
    /// 이 영상에 있는 가장 높은 jpg 썸네일 화질. 그 아래 화질은 다 있다.
    /// 없는 화질을 앱이 요청하면 YouTube 가 404 를 1~2초 늦게 줘서, 미리 재어 둔다
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub thumb_jpg: Option<String>,
    /// webp 썸네일이 있으면 가장 높은 화질. webp 가 없는 영상은 비운다
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub thumb_webp: Option<String>,
}

/// YouTube 썸네일 화질. 높은 것부터
pub const THUMB_QUALITIES: [&str; 4] = ["maxresdefault", "sddefault", "hqdefault", "mqdefault"];

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct Evidence {
    pub grade: String,
    pub kind: String,
    pub url: String,
    pub note: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct CueRecord {
    pub key: String,
    pub order: u16,
    #[serde(default)]
    pub episode: Option<String>,
    #[serde(default)]
    pub composer_id: Option<i32>,
    pub composer_name: String,
    #[serde(default)]
    pub piece_id: Option<i32>,
    pub work_title: String,
    #[serde(default)]
    pub part: Option<String>,
    #[serde(default)]
    pub sector_key: Option<String>,
    pub usage: String,
    pub arranged: bool,
    #[serde(default)]
    pub approx_at_sec: Option<u32>,
    pub scene_note: String,
    pub spoiler: bool,
    #[serde(default)]
    pub official_clip: Option<OfficialClip>,
    pub evidence: Vec<Evidence>,
    pub status: String,
}

#[derive(Debug, Clone, PartialEq, Eq, Deserialize)]
#[serde(rename_all = "camelCase", deny_unknown_fields)]
pub struct TitleRecord {
    pub slug: String,
    pub kind: String,
    pub title_ko: String,
    #[serde(default)]
    pub title_original: Option<String>,
    #[serde(default)]
    pub release_year: Option<u16>,
    #[serde(default)]
    pub country_code: Option<String>,
    #[serde(default)]
    pub credit_line: Option<String>,
    /// 작품 대표 그림으로 쓸 권리자 공식 YouTube 예고편·클립
    #[serde(default)]
    pub cover_clip: Option<OfficialClip>,
    pub display_order: i32,
    pub status: String,
    #[serde(default)]
    pub identifiers: BTreeMap<String, String>,
    pub cues: Vec<CueRecord>,
}

fn is_key(value: &str) -> bool {
    !value.is_empty()
        && value.len() <= MAX_KEY_LEN
        && value
            .bytes()
            .all(|byte| byte.is_ascii_lowercase() || byte.is_ascii_digit() || byte == b'-')
}

fn one_of(field: &str, value: &str, allowed: &[&str]) -> Result<(), String> {
    if allowed.contains(&value) {
        Ok(())
    } else {
        Err(format!(
            "{field} 는 {} 중 하나여야 함: {value}",
            allowed.join("·")
        ))
    }
}

fn not_blank(field: &str, value: &str, max_chars: usize) -> Result<(), String> {
    let count = value.trim().chars().count();
    if count == 0 || count > max_chars || value.trim() != value {
        return Err(format!("{field} 는 앞뒤 공백 없이 1~{max_chars}자여야 함"));
    }
    Ok(())
}

fn optional_text(field: &str, value: &Option<String>, max_chars: usize) -> Result<(), String> {
    match value {
        Some(value) => not_blank(field, value, max_chars),
        None => Ok(()),
    }
}

/// 근거 링크는 웹 주소만 받는다. 오래된 보도자료처럼 http 로만 열리는 곳도 있다
fn is_web_url(url: &str) -> bool {
    !url.contains(char::is_whitespace)
        && url::Url::parse(url).is_ok_and(|parsed| {
            matches!(parsed.scheme(), "https" | "http") && parsed.host_str().is_some()
        })
}

/// 공개 기준: 1차 근거 하나, 또는 서로 다른 곳의 2차 근거 둘
fn meets_publication_rule(evidence: &[Evidence]) -> bool {
    if evidence.iter().any(|item| item.grade == "1") {
        return true;
    }
    let hosts = evidence
        .iter()
        .filter(|item| item.grade == "2")
        .filter_map(|item| url::Url::parse(&item.url).ok())
        .filter_map(|url| {
            url.host_str()
                .map(|host| host.trim_start_matches("www.").to_string())
        })
        .collect::<HashSet<_>>();
    hosts.len() >= 2
}

impl OfficialClip {
    fn validate(&self) -> Result<(), String> {
        let id_ok = self.video_id.len() == 11
            && self
                .video_id
                .bytes()
                .all(|byte| byte.is_ascii_alphanumeric() || byte == b'-' || byte == b'_');
        if !id_ok {
            return Err(format!(
                "officialClip.videoId 가 YouTube id 꼴이 아님: {}",
                self.video_id
            ));
        }
        not_blank("officialClip.channel", &self.channel, 100)?;
        not_blank("officialClip.title", &self.title, 200)?;
        for (field, value) in [
            ("thumbJpg", &self.thumb_jpg),
            ("thumbWebp", &self.thumb_webp),
        ] {
            if let Some(value) = value {
                if !THUMB_QUALITIES.contains(&value.as_str()) {
                    return Err(format!(
                        "officialClip.{field} 가 썸네일 화질이 아님: {value}"
                    ));
                }
            }
        }
        if self.thumb_webp.is_some() && self.thumb_jpg.is_none() {
            return Err("officialClip.thumbWebp 는 thumbJpg 와 같이 적어야 함".to_string());
        }
        Ok(())
    }
}

impl CueRecord {
    pub fn validate(&self) -> Result<(), String> {
        if !is_key(&self.key) {
            return Err(format!(
                "cue key 는 영어 소문자·숫자·하이픈이어야 함: {}",
                self.key
            ));
        }
        if self.order == 0 {
            return Err(format!("{}: order 는 1 이상이어야 함", self.key));
        }
        let context = |message: String| format!("{}: {message}", self.key);
        optional_text("episode", &self.episode, 32).map_err(context)?;
        not_blank("composerName", &self.composer_name, 100).map_err(context)?;
        not_blank("workTitle", &self.work_title, 200).map_err(context)?;
        optional_text("part", &self.part, 200).map_err(context)?;
        not_blank("sceneNote", &self.scene_note, MAX_SCENE_NOTE_CHARS).map_err(context)?;
        one_of("usage", &self.usage, &USAGES).map_err(context)?;
        one_of("status", &self.status, &STATUSES).map_err(context)?;
        for id in [self.composer_id, self.piece_id].into_iter().flatten() {
            if id <= 0 {
                return Err(context("composerId·pieceId 는 양수여야 함".to_string()));
            }
        }
        if let Some(key) = &self.sector_key {
            if self.piece_id.is_none() {
                return Err(context(
                    "sectorKey 는 pieceId 가 있을 때만 쓸 수 있음".to_string(),
                ));
            }
            if key.is_empty() || key.len() > 150 || !key.is_ascii() {
                return Err(context("sectorKey 는 1~150자 ASCII 여야 함".to_string()));
            }
        }
        if let Some(clip) = &self.official_clip {
            clip.validate().map_err(context)?;
        }
        if self.evidence.is_empty() {
            return Err(context("evidence 가 하나 이상 있어야 함".to_string()));
        }
        for item in &self.evidence {
            one_of("evidence.grade", &item.grade, &EVIDENCE_GRADES).map_err(context)?;
            not_blank("evidence.kind", &item.kind, 32).map_err(context)?;
            not_blank("evidence.note", &item.note, 300).map_err(context)?;
            if !is_web_url(&item.url) {
                return Err(context(format!(
                    "evidence.url 은 웹 주소여야 함: {}",
                    item.url
                )));
            }
        }
        if !meets_publication_rule(&self.evidence) {
            return Err(context(
                "근거가 공개 기준(1차 하나 또는 서로 다른 2차 둘)에 못 미침".to_string(),
            ));
        }
        Ok(())
    }
}

impl TitleRecord {
    pub fn validate(&self) -> Result<(), String> {
        if !is_key(&self.slug) {
            return Err(format!(
                "slug 는 영어 소문자·숫자·하이픈이어야 함: {}",
                self.slug
            ));
        }
        let context = |message: String| format!("{}: {message}", self.slug);
        one_of("kind", &self.kind, &KINDS).map_err(context)?;
        one_of("status", &self.status, &STATUSES).map_err(context)?;
        not_blank("titleKo", &self.title_ko, 200).map_err(context)?;
        optional_text("titleOriginal", &self.title_original, 200).map_err(context)?;
        optional_text("creditLine", &self.credit_line, 200).map_err(context)?;
        if let Some(clip) = &self.cover_clip {
            clip.validate().map_err(context)?;
        }
        if let Some(year) = self.release_year {
            if !(1888..=2100).contains(&year) {
                return Err(context(format!("releaseYear 가 이상함: {year}")));
            }
        }
        if let Some(code) = &self.country_code {
            if code.len() != 2 || !code.bytes().all(|byte| byte.is_ascii_uppercase()) {
                return Err(context(format!(
                    "countryCode 는 대문자 두 글자여야 함: {code}"
                )));
            }
        }
        if self.display_order <= 0 {
            return Err(context("displayOrder 는 1 이상이어야 함".to_string()));
        }
        for (namespace, value) in &self.identifiers {
            one_of("identifiers 이름", namespace, &NAMESPACES).map_err(context)?;
            not_blank("identifiers 값", value, 100).map_err(context)?;
        }
        if self.cues.is_empty() || self.cues.len() > MAX_CUES_PER_TITLE {
            return Err(context(format!("큐는 1~{MAX_CUES_PER_TITLE}개여야 함")));
        }
        let mut keys = HashSet::new();
        let mut orders = HashSet::new();
        for cue in &self.cues {
            cue.validate().map_err(context)?;
            if !keys.insert(cue.key.as_str()) {
                return Err(context(format!("cue key {} 가 두 번 나옴", cue.key)));
            }
            if !orders.insert(cue.order) {
                return Err(context(format!("cue order {} 가 두 번 나옴", cue.order)));
            }
        }
        if self.status == "PUBLISHED" && !self.cues.iter().any(|cue| cue.status == "PUBLISHED") {
            return Err(context(
                "공개 작품에는 공개 큐가 하나 이상 있어야 함".to_string(),
            ));
        }
        Ok(())
    }
}

#[derive(Debug, Clone, Default, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenMusicMutationCounts {
    pub titles_inserted: u64,
    pub titles_updated: u64,
    pub identifiers_written: u64,
    pub cues_inserted: u64,
    pub cues_updated: u64,
    pub total: u64,
}

impl ScreenMusicMutationCounts {
    fn finish(mut self) -> Self {
        self.total = self.titles_inserted
            + self.titles_updated
            + self.identifiers_written
            + self.cues_inserted
            + self.cues_updated;
        self
    }
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SkippedCue {
    pub slug: String,
    pub key: String,
    pub reason: &'static str,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct OrphanCue {
    pub slug: String,
    pub key: String,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenMusicLoadReport {
    pub status: &'static str,
    pub input_path: String,
    pub title_count: usize,
    pub cue_count: usize,
    pub dry_run: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    pub unchanged_titles: usize,
    pub unchanged_cues: usize,
    pub mutations: ScreenMusicMutationCounts,
    pub planned_mutations: ScreenMusicMutationCounts,
    pub skipped: Vec<SkippedCue>,
    pub orphan_cues: Vec<OrphanCue>,
}

#[derive(Debug)]
pub enum ScreenMusicLoadError {
    Input {
        code: &'static str,
        message: String,
        line: Option<usize>,
    },
    Database(sqlx::Error),
}

impl ScreenMusicLoadError {
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

impl fmt::Display for ScreenMusicLoadError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Input { message, .. } => formatter.write_str(message),
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for ScreenMusicLoadError {}

impl From<sqlx::Error> for ScreenMusicLoadError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// JSONL 을 읽어 검증한다. 빈 줄은 건너뛴다. 같은 slug·같은 바깥 ID 가 두 번 나오면 거부한다
pub fn parse_records(
    text: &str,
    limit: Option<usize>,
) -> Result<Vec<TitleRecord>, ScreenMusicLoadError> {
    let mut records = Vec::new();
    let mut slugs = HashSet::new();
    let mut identifiers = HashSet::new();
    for (index, line) in text.lines().enumerate() {
        let line_number = index + 1;
        if line.trim().is_empty() {
            continue;
        }
        let record: TitleRecord = serde_json::from_str(line).map_err(|error| {
            ScreenMusicLoadError::input("INVALID_JSON", error.to_string(), Some(line_number))
        })?;
        record.validate().map_err(|message| {
            ScreenMusicLoadError::input("INVALID_TITLE", message, Some(line_number))
        })?;
        if !slugs.insert(record.slug.clone()) {
            return Err(ScreenMusicLoadError::input(
                "DUPLICATE_TITLE",
                format!("slug {} 가 두 번 나옴", record.slug),
                Some(line_number),
            ));
        }
        for (namespace, value) in &record.identifiers {
            if !identifiers.insert((namespace.clone(), value.clone())) {
                return Err(ScreenMusicLoadError::input(
                    "DUPLICATE_IDENTIFIER",
                    format!("{namespace}:{value} 가 두 작품에 붙음"),
                    Some(line_number),
                ));
            }
        }
        records.push(record);
    }
    if let Some(limit) = limit {
        if records.len() > limit {
            return Err(ScreenMusicLoadError::input(
                "LIMIT_EXCEEDED",
                format!("입력 {}줄이 --limit {limit} 을 넘음", records.len()),
                None,
            ));
        }
    }
    Ok(records)
}

#[derive(Debug, FromRow, PartialEq, Eq)]
struct StoredTitle {
    id: i32,
    kind: String,
    title_ko: String,
    title_original: Option<String>,
    release_year: Option<u16>,
    country_code: Option<String>,
    credit_line: Option<String>,
    cover_clip: Option<String>,
    display_order: i32,
    editorial_status: String,
}

impl StoredTitle {
    fn matches(&self, record: &TitleRecord) -> bool {
        self.kind == record.kind
            && self.title_ko == record.title_ko
            && self.title_original == record.title_original
            && self.release_year == record.release_year
            && self.country_code == record.country_code
            && self.credit_line == record.credit_line
            && parse_json(self.cover_clip.as_deref()) == title_clip_json(record)
            && self.display_order == record.display_order
            && self.editorial_status == record.status
    }
}

#[derive(Debug, FromRow)]
struct StoredCue {
    cue_key: String,
    display_order: u16,
    episode_label: Option<String>,
    composer_id: Option<i32>,
    composer_name: String,
    piece_id: Option<i32>,
    work_title: String,
    part_label: Option<String>,
    sector_id: Option<i32>,
    usage_kind: String,
    arranged: bool,
    approx_at_sec: Option<u32>,
    scene_note: String,
    spoiler: bool,
    official_clip: Option<String>,
    evidence: String,
    editorial_status: String,
}

struct WantedCue<'a> {
    record: &'a CueRecord,
    sector_id: Option<i32>,
    official_clip: Option<Value>,
    evidence: Value,
}

impl StoredCue {
    fn matches(&self, wanted: &WantedCue<'_>) -> bool {
        let record = wanted.record;
        self.display_order == record.order
            && self.episode_label == record.episode
            && self.composer_id == record.composer_id
            && self.composer_name == record.composer_name
            && self.piece_id == record.piece_id
            && self.work_title == record.work_title
            && self.part_label == record.part
            && self.sector_id == wanted.sector_id
            && self.usage_kind == record.usage
            && self.arranged == record.arranged
            && self.approx_at_sec == record.approx_at_sec
            && self.scene_note == record.scene_note
            && self.spoiler == record.spoiler
            && parse_json(self.official_clip.as_deref()) == wanted.official_clip
            && parse_json(Some(&self.evidence)) == Some(wanted.evidence.clone())
            && self.editorial_status == record.status
    }
}

enum CuePlan {
    Write {
        insert: bool,
        sector_id: Option<i32>,
    },
    Unchanged,
    Skip(&'static str),
}

pub struct ScreenMusicLoader;

impl ScreenMusicLoader {
    pub async fn load(
        pool: &DbPool,
        options: &ScreenMusicLoadOptions,
    ) -> Result<ScreenMusicLoadReport, ScreenMusicLoadError> {
        let text = fs::read_to_string(&options.input_path).map_err(|error| {
            ScreenMusicLoadError::input(
                "INPUT_READ_ERROR",
                format!("입력을 읽을 수 없음: {error}"),
                None,
            )
        })?;
        let records = parse_records(&text, options.limit)?;

        let mut transaction = pool.begin().await?;
        let mut planned = ScreenMusicMutationCounts::default();
        let mut unchanged_titles = 0;
        let mut unchanged_cues = 0;
        let mut skipped = Vec::new();
        let mut orphan_cues = Vec::new();

        for record in &records {
            let title_id = match Self::upsert_title(&mut transaction, record).await? {
                (id, None) => {
                    unchanged_titles += 1;
                    id
                }
                (id, Some(true)) => {
                    planned.titles_inserted += 1;
                    id
                }
                (id, Some(false)) => {
                    planned.titles_updated += 1;
                    id
                }
            };
            planned.identifiers_written +=
                Self::write_identifiers(&mut transaction, title_id, record).await?;

            for cue in &record.cues {
                match Self::plan_cue(&mut transaction, title_id, cue).await? {
                    CuePlan::Skip(reason) => skipped.push(SkippedCue {
                        slug: record.slug.clone(),
                        key: cue.key.clone(),
                        reason,
                    }),
                    CuePlan::Unchanged => unchanged_cues += 1,
                    CuePlan::Write { insert, sector_id } => {
                        Self::write_cue(&mut transaction, title_id, cue, sector_id).await?;
                        if insert {
                            planned.cues_inserted += 1;
                        } else {
                            planned.cues_updated += 1;
                        }
                    }
                }
            }

            let stored_keys = sqlx::query_scalar::<_, String>(
                "SELECT CAST(cue_key AS CHAR CHARACTER SET utf8mb4) FROM screen_music_cues
                 WHERE screen_title_id = ? ORDER BY cue_key",
            )
            .bind(title_id)
            .fetch_all(&mut *transaction)
            .await?;
            let wanted_keys = record
                .cues
                .iter()
                .map(|cue| cue.key.as_str())
                .collect::<HashSet<_>>();
            orphan_cues.extend(
                stored_keys
                    .into_iter()
                    .filter(|key| !wanted_keys.contains(key.as_str()))
                    .map(|key| OrphanCue {
                        slug: record.slug.clone(),
                        key,
                    }),
            );
        }

        let planned = planned.finish();
        let mutations = if options.dry_run {
            transaction.rollback().await?;
            ScreenMusicMutationCounts::default()
        } else {
            transaction.commit().await?;
            planned.clone()
        };

        Ok(ScreenMusicLoadReport {
            status: "succeeded",
            input_path: options.input_path.to_string_lossy().into_owned(),
            title_count: records.len(),
            cue_count: records.iter().map(|record| record.cues.len()).sum(),
            dry_run: options.dry_run,
            run_id: options.run_id.clone(),
            unchanged_titles,
            unchanged_cues,
            mutations,
            planned_mutations: planned,
            skipped,
            orphan_cues,
        })
    }

    /// 작품을 넣거나 고친다. 두 번째 값은 넣었으면 Some(true), 고쳤으면 Some(false), 그대로면 None
    async fn upsert_title(
        transaction: &mut Transaction<'_, MySql>,
        record: &TitleRecord,
    ) -> Result<(i32, Option<bool>), sqlx::Error> {
        let stored = sqlx::query_as::<_, StoredTitle>(
            "SELECT id, kind, title_ko, title_original, release_year, country_code,
                    credit_line, CAST(cover_clip AS CHAR CHARACTER SET utf8mb4) AS cover_clip,
                    display_order, editorial_status
             FROM screen_titles
             WHERE slug = ?
             FOR UPDATE",
        )
        .bind(&record.slug)
        .fetch_optional(&mut **transaction)
        .await?;

        match stored {
            Some(stored) if stored.matches(record) => Ok((stored.id, None)),
            Some(stored) => {
                sqlx::query(
                    "UPDATE screen_titles
                     SET kind = ?, title_ko = ?, title_original = ?, release_year = ?,
                         country_code = ?, credit_line = ?, cover_clip = CAST(? AS JSON),
                         display_order = ?, editorial_status = ?
                     WHERE id = ?",
                )
                .bind(&record.kind)
                .bind(&record.title_ko)
                .bind(&record.title_original)
                .bind(record.release_year)
                .bind(&record.country_code)
                .bind(&record.credit_line)
                .bind(title_clip_json(record).as_ref().map(Value::to_string))
                .bind(record.display_order)
                .bind(&record.status)
                .bind(stored.id)
                .execute(&mut **transaction)
                .await?;
                Ok((stored.id, Some(false)))
            }
            None => {
                let result = sqlx::query(
                    "INSERT INTO screen_titles
                         (slug, kind, title_ko, title_original, release_year, country_code,
                          credit_line, cover_clip, display_order, editorial_status)
                     VALUES (?, ?, ?, ?, ?, ?, ?, CAST(? AS JSON), ?, ?)",
                )
                .bind(&record.slug)
                .bind(&record.kind)
                .bind(&record.title_ko)
                .bind(&record.title_original)
                .bind(record.release_year)
                .bind(&record.country_code)
                .bind(&record.credit_line)
                .bind(title_clip_json(record).as_ref().map(Value::to_string))
                .bind(record.display_order)
                .bind(&record.status)
                .execute(&mut **transaction)
                .await?;
                Ok((result.last_insert_id() as i32, Some(true)))
            }
        }
    }

    /// 바깥 ID 를 맞춘다. 입력에 없는 이름은 지우고, 값이 다르면 고친다. 바꾼 줄 수를 준다
    async fn write_identifiers(
        transaction: &mut Transaction<'_, MySql>,
        title_id: i32,
        record: &TitleRecord,
    ) -> Result<u64, ScreenMusicLoadError> {
        let stored = sqlx::query_as::<_, (String, String)>(
            "SELECT CAST(namespace AS CHAR CHARACTER SET utf8mb4),
                    CAST(external_id AS CHAR CHARACTER SET utf8mb4)
             FROM screen_title_identifiers
             WHERE screen_title_id = ?
             FOR UPDATE",
        )
        .bind(title_id)
        .fetch_all(&mut **transaction)
        .await?
        .into_iter()
        .collect::<BTreeMap<_, _>>();

        let mut written = 0;
        for namespace in stored.keys() {
            if !record.identifiers.contains_key(namespace) {
                sqlx::query(
                    "DELETE FROM screen_title_identifiers
                     WHERE screen_title_id = ? AND namespace = ?",
                )
                .bind(title_id)
                .bind(namespace)
                .execute(&mut **transaction)
                .await?;
                written += 1;
            }
        }
        for (namespace, value) in &record.identifiers {
            if stored.get(namespace) == Some(value) {
                continue;
            }
            let owner = sqlx::query_scalar::<_, i32>(
                "SELECT screen_title_id FROM screen_title_identifiers
                 WHERE namespace = ? AND external_id = ?",
            )
            .bind(namespace)
            .bind(value)
            .fetch_optional(&mut **transaction)
            .await?;
            if owner.is_some_and(|owner| owner != title_id) {
                return Err(ScreenMusicLoadError::input(
                    "IDENTIFIER_CONFLICT",
                    format!(
                        "{}: {namespace}:{value} 가 이미 다른 작품에 붙어 있음",
                        record.slug
                    ),
                    None,
                ));
            }
            sqlx::query(
                "INSERT INTO screen_title_identifiers (screen_title_id, namespace, external_id)
                 VALUES (?, ?, ?)
                 ON DUPLICATE KEY UPDATE external_id = VALUES(external_id)",
            )
            .bind(title_id)
            .bind(namespace)
            .bind(value)
            .execute(&mut **transaction)
            .await?;
            written += 1;
        }
        Ok(written)
    }

    async fn plan_cue(
        transaction: &mut Transaction<'_, MySql>,
        title_id: i32,
        cue: &CueRecord,
    ) -> Result<CuePlan, ScreenMusicLoadError> {
        if let Some(composer_id) = cue.composer_id {
            let found = sqlx::query_scalar::<_, i32>("SELECT id FROM composers WHERE id = ?")
                .bind(composer_id)
                .fetch_optional(&mut **transaction)
                .await?;
            if found.is_none() {
                return Ok(CuePlan::Skip("COMPOSER_NOT_FOUND"));
            }
        }
        if let Some(piece_id) = cue.piece_id {
            let composer = sqlx::query_scalar::<_, i32>(
                "SELECT composer_id FROM pieces WHERE id = ? FOR UPDATE",
            )
            .bind(piece_id)
            .fetch_optional(&mut **transaction)
            .await?;
            match composer {
                None => return Ok(CuePlan::Skip("PIECE_NOT_FOUND")),
                // 작품을 잘못 짚으면 작곡가가 어긋난다. 이름이 같은 다른 곡에 붙는 것을 막는다
                Some(composer) if cue.composer_id != Some(composer) => {
                    return Ok(CuePlan::Skip("PIECE_COMPOSER_MISMATCH"))
                }
                Some(_) => {}
            }
        }
        let sector_id = match (&cue.sector_key, cue.piece_id) {
            (Some(key), Some(piece_id)) => {
                let found = sqlx::query_scalar::<_, i32>(
                    "SELECT id FROM performance_sectors WHERE piece_id = ? AND sector_key = ?",
                )
                .bind(piece_id)
                .bind(key)
                .fetch_optional(&mut **transaction)
                .await?;
                match found {
                    Some(id) => Some(id),
                    None => return Ok(CuePlan::Skip("SECTOR_NOT_FOUND")),
                }
            }
            _ => None,
        };

        let stored = sqlx::query_as::<_, StoredCue>(
            "SELECT CAST(cue_key AS CHAR CHARACTER SET utf8mb4) AS cue_key, display_order,
                    episode_label, composer_id, composer_name, piece_id,
                    work_title, part_label, sector_id, usage_kind, arranged, approx_at_sec,
                    scene_note, spoiler,
                    CAST(official_clip AS CHAR CHARACTER SET utf8mb4) AS official_clip,
                    CAST(evidence AS CHAR CHARACTER SET utf8mb4) AS evidence,
                    editorial_status
             FROM screen_music_cues
             WHERE screen_title_id = ? AND cue_key = ?
             FOR UPDATE",
        )
        .bind(title_id)
        .bind(&cue.key)
        .fetch_optional(&mut **transaction)
        .await?;

        let wanted = WantedCue {
            record: cue,
            sector_id,
            official_clip: clip_json(cue)?,
            evidence: evidence_json(cue)?,
        };
        Ok(match stored {
            None => CuePlan::Write {
                insert: true,
                sector_id,
            },
            Some(stored) if stored.cue_key == cue.key && stored.matches(&wanted) => {
                CuePlan::Unchanged
            }
            Some(_) => CuePlan::Write {
                insert: false,
                sector_id,
            },
        })
    }

    async fn write_cue(
        transaction: &mut Transaction<'_, MySql>,
        title_id: i32,
        cue: &CueRecord,
        sector_id: Option<i32>,
    ) -> Result<(), ScreenMusicLoadError> {
        let clip = clip_json(cue)?;
        let evidence = evidence_json(cue)?;
        sqlx::query(
            "INSERT INTO screen_music_cues
                 (screen_title_id, cue_key, display_order, episode_label, composer_id,
                  composer_name, piece_id, work_title, part_label, sector_id, usage_kind,
                  arranged, approx_at_sec, scene_note, spoiler, official_clip, evidence,
                  editorial_status)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CAST(? AS JSON), CAST(? AS JSON), ?)
             ON DUPLICATE KEY UPDATE
                 display_order = VALUES(display_order),
                 episode_label = VALUES(episode_label),
                 composer_id = VALUES(composer_id),
                 composer_name = VALUES(composer_name),
                 piece_id = VALUES(piece_id),
                 work_title = VALUES(work_title),
                 part_label = VALUES(part_label),
                 sector_id = VALUES(sector_id),
                 usage_kind = VALUES(usage_kind),
                 arranged = VALUES(arranged),
                 approx_at_sec = VALUES(approx_at_sec),
                 scene_note = VALUES(scene_note),
                 spoiler = VALUES(spoiler),
                 official_clip = VALUES(official_clip),
                 evidence = VALUES(evidence),
                 editorial_status = VALUES(editorial_status)",
        )
        .bind(title_id)
        .bind(&cue.key)
        .bind(cue.order)
        .bind(&cue.episode)
        .bind(cue.composer_id)
        .bind(&cue.composer_name)
        .bind(cue.piece_id)
        .bind(&cue.work_title)
        .bind(&cue.part)
        .bind(sector_id)
        .bind(&cue.usage)
        .bind(cue.arranged)
        .bind(cue.approx_at_sec)
        .bind(&cue.scene_note)
        .bind(cue.spoiler)
        .bind(clip.as_ref().map(Value::to_string))
        .bind(evidence.to_string())
        .bind(&cue.status)
        .execute(&mut **transaction)
        .await?;
        Ok(())
    }
}

fn parse_json(text: Option<&str>) -> Option<Value> {
    text.and_then(|text| serde_json::from_str(text).ok())
}

fn title_clip_json(record: &TitleRecord) -> Option<Value> {
    record
        .cover_clip
        .as_ref()
        .and_then(|clip| serde_json::to_value(clip).ok())
}

fn clip_json(cue: &CueRecord) -> Result<Option<Value>, ScreenMusicLoadError> {
    cue.official_clip
        .as_ref()
        .map(serde_json::to_value)
        .transpose()
        .map_err(|error| {
            ScreenMusicLoadError::input("SERIALIZATION_ERROR", error.to_string(), None)
        })
}

fn evidence_json(cue: &CueRecord) -> Result<Value, ScreenMusicLoadError> {
    serde_json::to_value(&cue.evidence).map_err(|error| {
        ScreenMusicLoadError::input("SERIALIZATION_ERROR", error.to_string(), None)
    })
}

#[cfg(test)]
mod tests {
    use super::parse_records;

    const LINE: &str = r#"{"slug":"squid-game","kind":"SERIES","titleKo":"오징어 게임","titleOriginal":"오징어 게임","releaseYear":2021,"countryCode":"KR","creditLine":"황동혁 연출 · 넷플릭스","displayOrder":1,"status":"DRAFT","identifiers":{"wikidata":"Q107421239","tmdb_tv":"93405"},"cues":[{"key":"haydn-trumpet-mv3","order":1,"episode":"여러 회","composerId":16,"composerName":"하이든","pieceId":88,"workTitle":"트럼펫 협주곡 E♭장조","part":"3악장 Finale. Allegro","sectorKey":"mv3-finale","usage":"SOURCE","arranged":false,"sceneNote":"참가자들이 자는 숙소에 아침마다 기상 음악으로 틀어요.","spoiler":false,"evidence":[{"grade":"1","kind":"ost","url":"https://example.com/ost","note":"OST 트랙"}],"status":"DRAFT"}]}"#;

    #[test]
    fn valid_title_is_parsed() {
        let records = parse_records(LINE, None).expect("적재 입력");
        assert_eq!(records.len(), 1);
        assert_eq!(records[0].cues[0].sector_key.as_deref(), Some("mv3-finale"));
    }

    #[test]
    fn unknown_values_are_rejected() {
        assert!(parse_records(&LINE.replace("\"SERIES\"", "\"SHORT\""), None).is_err());
        assert!(parse_records(&LINE.replace("\"SOURCE\"", "\"DIEGETIC\""), None).is_err());
        assert!(parse_records(&LINE.replace("\"tmdb_tv\"", "\"tvdb\""), None).is_err());
        assert!(parse_records(&LINE.replace("squid-game", "Squid Game"), None).is_err());
        let extra = LINE.replacen('{', r#"{"extra":1,"#, 1);
        assert!(parse_records(&extra, None).is_err());
    }

    #[test]
    fn evidence_must_meet_publication_rule() {
        let one_secondary = LINE.replace("\"grade\":\"1\"", "\"grade\":\"2\"");
        assert!(parse_records(&one_secondary, None).is_err());
        let two_secondary_same_host = one_secondary.replace(
            r#"}],"status":"DRAFT"}]}"#,
            r#"},{"grade":"2","kind":"article","url":"https://www.example.com/b","note":"기사"}],"status":"DRAFT"}]}"#,
        );
        assert!(parse_records(&two_secondary_same_host, None).is_err());
        let two_secondary = one_secondary.replace(
            r#"}],"status":"DRAFT"}]}"#,
            r#"},{"grade":"2","kind":"article","url":"https://news.example.org/b","note":"기사"}],"status":"DRAFT"}]}"#,
        );
        assert!(parse_records(&two_secondary, None).is_ok());
        let reference_only = LINE.replace("\"grade\":\"1\"", "\"grade\":\"ref\"");
        assert!(parse_records(&reference_only, None).is_err());
    }

    #[test]
    fn sector_needs_piece_and_published_title_needs_published_cue() {
        let no_piece = LINE.replace("\"pieceId\":88,", "");
        assert!(parse_records(&no_piece, None).is_err());
        let published_title = LINE.replacen("\"status\":\"DRAFT\"", "\"status\":\"PUBLISHED\"", 1);
        assert!(parse_records(&published_title, None).is_err());
        let both_published = LINE.replace("\"status\":\"DRAFT\"", "\"status\":\"PUBLISHED\"");
        assert!(parse_records(&both_published, None).is_ok());
    }

    #[test]
    fn duplicates_and_limit_are_rejected() {
        assert!(parse_records(&format!("{LINE}\n{LINE}"), None).is_err());
        let other_slug_same_id = LINE.replace("squid-game", "squid-game-2");
        assert!(parse_records(&format!("{LINE}\n{other_slug_same_id}"), None).is_err());
        assert!(parse_records(LINE, Some(0)).is_err());
        assert!(parse_records(LINE, Some(1)).is_ok());
    }

    #[test]
    fn clip_needs_youtube_id() {
        let clip = LINE.replace(
            "\"spoiler\":false,",
            r#""spoiler":false,"officialClip":{"videoId":"abc","startSec":0,"channel":"Netflix Korea","title":"장면"},"#,
        );
        assert!(parse_records(&clip, None).is_err());
        let good = clip.replace("\"abc\"", "\"dQw4w9WgXcQ\"");
        assert!(parse_records(&good, None).is_ok());
    }

    #[test]
    fn clip_thumb_quality_is_checked() {
        let clip = LINE.replace(
            "\"spoiler\":false,",
            r#""spoiler":false,"officialClip":{"videoId":"dQw4w9WgXcQ","startSec":0,"channel":"Netflix Korea","title":"장면","thumbJpg":"sddefault","thumbWebp":"sddefault"},"#,
        );
        assert!(parse_records(&clip, None).is_ok());
        assert!(parse_records(
            &clip.replace("\"thumbWebp\":\"sddefault\"", "\"thumbWebp\":\"huge\""),
            None
        )
        .is_err());
        assert!(parse_records(&clip.replace("\"thumbJpg\":\"sddefault\",", ""), None).is_err());
        assert!(parse_records(&clip.replace(",\"thumbWebp\":\"sddefault\"", ""), None).is_ok());
    }
}
