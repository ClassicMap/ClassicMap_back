use super::client::KopisClient;
use super::models::BoxofficeItem;
use crate::boxoffice::repository::RankingSlot;
use crate::boxoffice::BoxofficeRepository;
use crate::concert::model::Concert;
use crate::concert::repository::{ArtistNameIndex, ConcertRepository};
use crate::concert::service::ConcertService;
use crate::hall::{CreateHall, HallRepository};
use crate::logger::Logger;
use crate::venue::{CreateVenue, VenueRepository};
use chrono::{Duration, NaiveDate, Utc};
use sqlx::MySqlPool;

pub struct KopisService;

impl KopisService {
    /// KOPIS API에서 공연장 데이터를 동기화
    pub async fn sync_venues(pool: &MySqlPool) -> Result<SyncResult, String> {
        Logger::info("KOPIS", "Starting venue synchronization");

        // 동기화 시작 기록
        Self::update_sync_status(pool, "venues", "in_progress", None, None, None)
            .await
            .map_err(|e| format!("Failed to update sync status: {}", e))?;

        // 마지막 동기화 날짜 조회
        let last_sync_date = Self::get_last_sync_date(pool, "venues").await?;
        let after_date = last_sync_date.format("%Y%m%d").to_string();

        Logger::info(
            "KOPIS",
            &format!("Fetching venues after date: {}", after_date),
        );

        // KOPIS 클라이언트 생성
        let client = KopisClient::from_env()?;

        // 공연장 목록 조회 (증분 업데이트)
        let venues = client.fetch_all_venues(Some(&after_date)).await?;

        Logger::info(
            "KOPIS",
            &format!("Fetched {} venues from KOPIS API", venues.len()),
        );

        let mut added_count = 0;
        let mut updated_count = 0;
        let mut error_count = 0;

        for venue_item in venues {
            // 공연장 상세 정보 조회
            match client.fetch_venue_detail(&venue_item.facility_id).await {
                Ok(detail_response) => {
                    let detail = detail_response.db;

                    // Venue 저장/업데이트
                    let venue_data = CreateVenue {
                        kopis_id: Some(detail.facility_id.clone()),
                        name: detail.facility_name.clone(),
                        address: detail.address.clone(),
                        city: venue_item.city.clone(),
                        province: venue_item.province.clone(),
                        country: Some("대한민국".to_string()),
                        seats: detail.parse_seats(),
                        hall_count: detail.hall_count,
                        opening_year: detail.parse_opening_year(),
                        is_active: Some(true),
                        data_source: Some("KOPIS".to_string()),
                    };

                    match VenueRepository::get_by_kopis_id(pool, &detail.facility_id).await {
                        Ok(existing) => {
                            match VenueRepository::upsert(pool, venue_data).await {
                                Ok(venue_id) => {
                                    if existing.is_some() {
                                        updated_count += 1;
                                        Logger::debug(
                                            "KOPIS",
                                            &format!(
                                                "Updated venue: {} (ID: {})",
                                                detail.facility_name, venue_id
                                            ),
                                        );
                                    } else {
                                        added_count += 1;
                                        Logger::success(
                                            "KOPIS",
                                            &format!(
                                                "Added new venue: {} (ID: {})",
                                                detail.facility_name, venue_id
                                            ),
                                        );
                                    }

                                    // Halls 저장/업데이트
                                    if let Some(halls_wrapper) = detail.halls {
                                        for hall_detail in halls_wrapper.halls {
                                            let hall_data = CreateHall {
                                                venue_id,
                                                kopis_id: Some(hall_detail.hall_id.clone()),
                                                name: hall_detail.hall_name.clone(),
                                                seats: hall_detail.parse_seats(),
                                                is_active: Some(true),
                                            };

                                            if let Err(e) =
                                                HallRepository::upsert(pool, hall_data).await
                                            {
                                                Logger::warn(
                                                    "KOPIS",
                                                    &format!(
                                                        "Failed to upsert hall {}: {}",
                                                        hall_detail.hall_name, e
                                                    ),
                                                );
                                                error_count += 1;
                                            }
                                        }
                                    }
                                }
                                Err(e) => {
                                    Logger::error(
                                        "KOPIS",
                                        &format!(
                                            "Failed to upsert venue {}: {}",
                                            detail.facility_name, e
                                        ),
                                    );
                                    error_count += 1;
                                }
                            }
                        }
                        Err(e) => {
                            Logger::error(
                                "KOPIS",
                                &format!(
                                    "Failed to check existing venue {}: {}",
                                    detail.facility_id, e
                                ),
                            );
                            error_count += 1;
                        }
                    }
                }
                Err(e) => {
                    Logger::warn(
                        "KOPIS",
                        &format!(
                            "Failed to fetch detail for venue {}: {}",
                            venue_item.facility_id, e
                        ),
                    );
                    error_count += 1;
                }
            }
        }

        let result = SyncResult {
            added: added_count,
            updated: updated_count,
            errors: error_count,
        };

        // 동기화 완료 기록
        let today = Utc::now().date_naive();
        Self::update_sync_status(
            pool,
            "venues",
            "success",
            Some(today),
            Some(added_count),
            Some(updated_count),
        )
        .await?;

        Logger::success(
            "KOPIS",
            &format!(
                "Venue sync completed: {} added, {} updated, {} errors",
                added_count, updated_count, error_count
            ),
        );

        Ok(result)
    }

    /// 마지막 동기화 날짜 조회
    async fn get_last_sync_date(pool: &MySqlPool, sync_type: &str) -> Result<NaiveDate, String> {
        let row: Option<(NaiveDate,)> =
            sqlx::query_as("SELECT last_sync_date FROM sync_metadata WHERE sync_type = ?")
                .bind(sync_type)
                .fetch_optional(pool)
                .await
                .map_err(|e| format!("Failed to fetch last sync date: {}", e))?;

        Ok(row.map(|r| r.0).unwrap_or_else(|| {
            // 기본값: 2020-01-01
            NaiveDate::from_ymd_opt(2020, 1, 1).unwrap()
        }))
    }

    /// 지난 공연 동기화가 상세를 받지 못해 남겨 둔 공연 ID
    async fn get_retry_ids(pool: &MySqlPool) -> Result<Vec<String>, String> {
        let row: Option<(Option<String>,)> =
            sqlx::query_as("SELECT error_message FROM sync_metadata WHERE sync_type = 'concerts'")
                .fetch_optional(pool)
                .await
                .map_err(|e| format!("Failed to read the retry list: {}", e))?;

        Ok(row
            .and_then(|(message,)| message)
            .map(|message| parse_retry_ids(&message))
            .unwrap_or_default())
    }

    /// 다음 공연 동기화가 먼저 다시 받을 공연 ID 를 남긴다(없으면 비운다)
    async fn set_retry_ids(pool: &MySqlPool, ids: &[String]) -> Result<(), String> {
        let message = if ids.is_empty() {
            None
        } else {
            Some(format!("{}{}", RETRY_PREFIX, ids.join(",")))
        };
        sqlx::query("UPDATE sync_metadata SET error_message = ? WHERE sync_type = 'concerts'")
            .bind(message)
            .execute(pool)
            .await
            .map_err(|e| format!("Failed to save the retry list: {}", e))?;

        Ok(())
    }

    /// 동기화 상태 업데이트
    async fn update_sync_status(
        pool: &MySqlPool,
        sync_type: &str,
        status: &str,
        last_sync_date: Option<NaiveDate>,
        items_added: Option<i32>,
        items_updated: Option<i32>,
    ) -> Result<(), String> {
        // 기존 레코드가 있는지 확인
        let exists: Option<(i32,)> =
            sqlx::query_as("SELECT id FROM sync_metadata WHERE sync_type = ?")
                .bind(sync_type)
                .fetch_optional(pool)
                .await
                .map_err(|e| format!("Failed to check sync_metadata: {}", e))?;

        if exists.is_some() {
            // 업데이트
            let mut query = String::from("UPDATE sync_metadata SET status = ?");
            let mut bindings: Vec<String> = vec![status.to_string()];

            if let Some(date) = last_sync_date {
                query.push_str(", last_sync_date = ?");
                bindings.push(date.format("%Y-%m-%d").to_string());
            }

            if let Some(added) = items_added {
                query.push_str(", items_added = ?");
                bindings.push(added.to_string());
            }

            if let Some(updated) = items_updated {
                query.push_str(", items_updated = ?");
                bindings.push(updated.to_string());
            }

            query.push_str(", last_sync_timestamp = CURRENT_TIMESTAMP WHERE sync_type = ?");
            bindings.push(sync_type.to_string());

            let mut q = sqlx::query(&query);
            for binding in bindings {
                q = q.bind(binding);
            }

            q.execute(pool)
                .await
                .map_err(|e| format!("Failed to update sync_metadata: {}", e))?;
        } else {
            // 삽입
            sqlx::query(
                "INSERT INTO sync_metadata (sync_type, status, last_sync_date, items_added, items_updated)
                 VALUES (?, ?, ?, ?, ?)"
            )
            .bind(sync_type)
            .bind(status)
            .bind(last_sync_date.unwrap_or_else(|| NaiveDate::from_ymd_opt(2020, 1, 1).unwrap()))
            .bind(items_added.unwrap_or(0))
            .bind(items_updated.unwrap_or(0))
            .execute(pool)
            .await
            .map_err(|e| format!("Failed to insert sync_metadata: {}", e))?;
        }

        Ok(())
    }

    // ============================================
    // 공연 동기화
    // ============================================

    /// KOPIS API에서 공연 데이터를 동기화
    /// 클래식/뮤지컬/오페라 장르만 필터링
    pub async fn sync_concerts(pool: &MySqlPool) -> Result<SyncResult, String> {
        Logger::info("KOPIS", "Starting concert synchronization");

        // 동기화 시작 기록
        Self::update_sync_status(pool, "concerts", "in_progress", None, None, None)
            .await
            .map_err(|e| format!("Failed to update sync status: {}", e))?;

        // 마지막 동기화 날짜 조회
        let last_sync_date = Self::get_last_sync_date(pool, "concerts").await?;
        let after_date = last_sync_date.format("%Y%m%d").to_string();

        Logger::info(
            "KOPIS",
            &format!("Fetching concerts after date: {}", after_date),
        );

        // KOPIS 클라이언트 생성
        let client = KopisClient::from_env()?;

        // 출연진 이름 → 아티스트. 동기화 한 번 동안 같은 색인을 쓴다
        let artist_index = ArtistNameIndex::load(pool)
            .await
            .map_err(|e| format!("Failed to load artist names: {}", e))?;

        // 클래식 관련 장르 코드
        let genre_codes = vec![
            "CCCA", // 클래식
            "GGGA", // 뮤지컬
            "CCCC", // 오페라
        ];

        let mut added_count = 0;
        let mut updated_count = 0;
        let mut error_count = 0;
        // 목록을 못 받은 구간이 있으면 다음 동기화가 같은 날짜부터 다시 받게 마지막 동기화 날짜를 올리지 않는다
        let mut retry_needed = false;
        // 상세를 받다 막힌 공연은 날짜를 붙잡지 않고 이름만 남겨 다음 동기화가 먼저 다시 받는다
        let mut failed_ids: Vec<String> = Vec::new();

        let carried = Self::get_retry_ids(pool).await?;
        if !carried.is_empty() {
            Logger::info(
                "KOPIS",
                &format!(
                    "Retrying {} concerts the last sync could not fetch",
                    carried.len()
                ),
            );
        }
        for performance_id in &carried {
            let outcome = import_concert(pool, &client, &artist_index, performance_id).await;
            added_count += outcome.added;
            updated_count += outcome.updated;
            error_count += outcome.errors;
            if outcome.retry {
                failed_ids.push(performance_id.clone());
            }
        }

        // 조회 기간 설정 (오늘부터 1년 후까지)
        let today = Utc::now().date_naive();

        for genre_code in &genre_codes {
            Logger::info("KOPIS", &format!("Syncing genre: {}", genre_code));

            // 31일 단위로 분할하여 조회 (KOPIS API 제한)
            let mut current_start = today;
            let end_limit = today + Duration::days(365);

            while current_start < end_limit {
                let current_end = (current_start + Duration::days(30)).min(end_limit);

                let batch_start = current_start.format("%Y%m%d").to_string();
                let batch_end = current_end.format("%Y%m%d").to_string();

                match client
                    .fetch_all_concerts(
                        &batch_start,
                        &batch_end,
                        Some(genre_code),
                        Some(&after_date),
                    )
                    .await
                {
                    Ok(concerts) => {
                        Logger::info(
                            "KOPIS",
                            &format!(
                                "Fetched {} concerts for {} ({} ~ {})",
                                concerts.len(),
                                genre_code,
                                batch_start,
                                batch_end
                            ),
                        );

                        for concert_item in concerts {
                            let outcome = import_concert(
                                pool,
                                &client,
                                &artist_index,
                                &concert_item.performance_id,
                            )
                            .await;
                            added_count += outcome.added;
                            updated_count += outcome.updated;
                            error_count += outcome.errors;
                            if outcome.retry {
                                failed_ids.push(concert_item.performance_id.clone());
                            }
                        }
                    }
                    Err(e) => {
                        Logger::error(
                            "KOPIS",
                            &format!(
                                "Failed to fetch concerts for {} ({} ~ {}): {}",
                                genre_code, batch_start, batch_end, e
                            ),
                        );
                        error_count += 1;
                        retry_needed = true;
                    }
                }

                current_start = current_end + Duration::days(1);
            }
        }

        let result = SyncResult {
            added: added_count,
            updated: updated_count,
            errors: error_count,
        };

        // 동기화 완료 기록. 목록을 못 받은 구간이 있거나 실패한 공연이 너무 많으면 날짜를 그대로 둬
        // 다음 동기화가 이어 받고, 몇 개뿐이면 그 공연만 남겨 둔다
        failed_ids.sort();
        failed_ids.dedup();
        if failed_ids.len() > RETRY_LIST_LIMIT {
            retry_needed = true;
        }
        Self::set_retry_ids(pool, &failed_ids).await?;
        if !failed_ids.is_empty() {
            Logger::warn(
                "KOPIS",
                &format!(
                    "{} concerts will be fetched again on the next sync",
                    failed_ids.len()
                ),
            );
        }
        let today = Utc::now().date_naive();
        let (status, next_after_date) = if retry_needed {
            Logger::warn(
                "KOPIS",
                "Concert sync had fetch or save failures; keeping the last sync date so the next run retries",
            );
            ("failed", None)
        } else {
            ("success", Some(today))
        };
        Self::update_sync_status(
            pool,
            "concerts",
            status,
            next_after_date,
            Some(added_count),
            Some(updated_count),
        )
        .await?;

        Logger::success(
            "KOPIS",
            &format!(
                "Concert sync completed: {} added, {} updated, {} errors",
                added_count, updated_count, error_count
            ),
        );

        Ok(result)
    }

    /// KOPIS API에서 예매상황판 순위 동기화
    /// 클래식 장르의 TOP 3만 저장
    pub async fn sync_boxoffice_rankings(pool: &MySqlPool) -> Result<SyncResult, String> {
        Logger::info("KOPIS", "Starting boxoffice rankings synchronization");

        // 동기화 시작 기록
        Self::update_sync_status(pool, "boxoffice", "in_progress", None, None, None)
            .await
            .map_err(|e| format!("Failed to update sync status: {}", e))?;

        // KOPIS 클라이언트 생성
        let client = KopisClient::from_env()?;

        // 조회 기간: 최근 30일
        let today = Utc::now().date_naive();
        let today_kst = kst_today();
        let start_date = (today - Duration::days(30)).format("%Y%m%d").to_string();
        let end_date = today.format("%Y%m%d").to_string();

        let mut added_count = 0;
        let mut error_count = 0;

        // 클래식 장르만
        let genre_codes = vec!["CCCA"]; // 클래식

        // 전국 17개 시도 + 전체
        let area_codes = vec![
            Some("11"), // 서울
            Some("26"), // 부산
            Some("27"), // 대구
            Some("28"), // 인천
            Some("29"), // 광주
            Some("30"), // 대전
            Some("31"), // 울산
            Some("36"), // 세종
            Some("41"), // 경기
            Some("42"), // 강원
            Some("43"), // 충북
            Some("44"), // 충남
            Some("45"), // 전북
            Some("46"), // 전남
            Some("47"), // 경북
            Some("48"), // 경남
            Some("50"), // 제주
            None,       // 전체
        ];

        for genre_code in &genre_codes {
            // 행정구역이 합쳐져 KOPIS 가 지역 순위를 비워 주는 지역은 전국 순위에서 골라 쓴다
            let national = client
                .fetch_boxoffice_rankings(&start_date, &end_date, Some(genre_code), None)
                .await
                .map(|response| response.boxof)
                .unwrap_or_default();
            for area_code in &area_codes {
                let area_display = area_code.unwrap_or("전체");

                Logger::info(
                    "KOPIS",
                    &format!(
                        "Fetching boxoffice rankings for genre: {}, area: {}",
                        genre_code, area_display
                    ),
                );

                let area_key = area_code.unwrap_or("00");
                match client
                    .fetch_boxoffice_rankings(&start_date, &end_date, Some(genre_code), *area_code)
                    .await
                {
                    Ok(response) => {
                        let items = if response.boxof.is_empty() {
                            merged_area_rankings(area_key, &national)
                        } else {
                            response.boxof
                        };
                        // 순위 위에서부터, 우리 DB 에 있고 아직 끝나지 않은 공연 3개를 고른다.
                        // 앞 순위 공연이 없거나 끝났으면 다음 순위로 채운다
                        let mut slots: Vec<RankingSlot> = Vec::new();
                        let mut lookup_failed = false;
                        for item in items.iter() {
                            if slots.len() >= 3 {
                                break;
                            }
                            match ConcertRepository::get_by_kopis_id(pool, &item.performance_id)
                                .await
                            {
                                Ok(Some(concert)) => {
                                    if concert_has_ended(&concert, today_kst) {
                                        continue;
                                    }
                                    slots.push(RankingSlot {
                                        concert_id: concert.id,
                                        ranking: item.ranking,
                                        genre_name: item.category.clone(),
                                        area_name: item.area.clone(),
                                        performance_count: item.performance_count.unwrap_or(0),
                                        venue_name: item.venue_name.clone(),
                                        seat_count: item.seat_count,
                                    });
                                }
                                Ok(None) => {
                                    Logger::warn(
                                        "KOPIS",
                                        &format!(
                                            "Concert not found for ranking #{}: {} (kopis_id: {})",
                                            item.ranking,
                                            item.performance_name,
                                            item.performance_id
                                        ),
                                    );
                                }
                                Err(e) => {
                                    Logger::error(
                                        "KOPIS",
                                        &format!(
                                            "Failed to get concert by kopis_id {}: {}",
                                            item.performance_id, e
                                        ),
                                    );
                                    lookup_failed = true;
                                    break;
                                }
                            }
                        }
                        if lookup_failed {
                            // 조회가 깨졌을 때는 있던 순위를 그대로 둔다
                            error_count += 1;
                            continue;
                        }
                        match BoxofficeRepository::replace_area_rankings(
                            pool,
                            genre_code,
                            area_key,
                            &slots,
                            &start_date,
                            &end_date,
                        )
                        .await
                        {
                            Ok(()) => {
                                added_count += slots.len() as i32;
                                Logger::success(
                                    "KOPIS",
                                    &format!(
                                        "Boxoffice {} {}: {} rankings saved",
                                        genre_code,
                                        area_display,
                                        slots.len()
                                    ),
                                );
                            }
                            Err(e) => {
                                Logger::error(
                                    "KOPIS",
                                    &format!(
                                        "Failed to save boxoffice rankings for {}, {}: {}",
                                        genre_code, area_display, e
                                    ),
                                );
                                error_count += 1;
                            }
                        }
                    }
                    Err(e) => {
                        // 받지 못한 지역은 있던 순위를 그대로 둔다
                        Logger::error(
                            "KOPIS",
                            &format!(
                                "Failed to fetch boxoffice rankings for {}, {}: {}",
                                genre_code, area_display, e
                            ),
                        );
                        error_count += 1;
                    }
                }
            }
        }

        let result = SyncResult {
            added: added_count,
            updated: 0,
            errors: error_count,
        };

        // 동기화 완료 기록
        let today = Utc::now().date_naive();
        Self::update_sync_status(
            pool,
            "boxoffice",
            "success",
            Some(today),
            Some(added_count),
            Some(0),
        )
        .await?;

        Logger::success(
            "KOPIS",
            &format!(
                "Boxoffice sync completed: {} rankings added, {} errors",
                added_count, error_count
            ),
        );

        Ok(result)
    }
}

/// 공연장 ID. 우리 DB 에 없으면 KOPIS 에서 공연장(과 홀)을 받아 넣는다.
/// 공연장 동기화는 바뀐 공연장만 받아, 예전에 빠진 공연장의 공연이 계속 건너뛰어졌다
async fn resolve_venue_id(
    pool: &MySqlPool,
    client: &KopisClient,
    facility_id: &str,
) -> Result<Option<i32>, String> {
    if let Some(venue_id) = ConcertRepository::get_venue_id_by_kopis_id(pool, facility_id)
        .await
        .map_err(|e| format!("Failed to look up venue {}: {}", facility_id, e))?
    {
        return Ok(Some(venue_id));
    }
    let detail = client.fetch_venue_detail(facility_id).await?.db;
    let (province, city) = province_and_city(detail.address.as_deref());
    let venue_id = VenueRepository::upsert(
        pool,
        CreateVenue {
            kopis_id: Some(detail.facility_id.clone()),
            name: detail.facility_name.clone(),
            address: detail.address.clone(),
            city,
            province,
            country: Some("대한민국".to_string()),
            seats: detail.parse_seats(),
            hall_count: detail.hall_count,
            opening_year: detail.parse_opening_year(),
            is_active: Some(true),
            data_source: Some("KOPIS".to_string()),
        },
    )
    .await
    .map_err(|e| format!("Failed to save venue {}: {}", facility_id, e))?;
    if let Some(halls) = detail.halls {
        for hall in halls.halls {
            let hall_data = CreateHall {
                venue_id,
                kopis_id: Some(hall.hall_id.clone()),
                name: hall.hall_name.clone(),
                seats: hall.parse_seats(),
                is_active: Some(true),
            };
            if let Err(e) = HallRepository::upsert(pool, hall_data).await {
                Logger::warn(
                    "KOPIS",
                    &format!("Failed to upsert hall {}: {}", hall.hall_name, e),
                );
            }
        }
    }
    Logger::success(
        "KOPIS",
        &format!(
            "Added missing venue: {} ({})",
            detail.facility_name, facility_id
        ),
    );

    Ok(Some(venue_id))
}

/// 주소 "서울특별시 양천구 목동동로 …" 에서 시도와 구군
fn province_and_city(address: Option<&str>) -> (Option<String>, Option<String>) {
    let mut parts = address.unwrap_or_default().split_whitespace();
    let province = parts.next().map(str::to_string);
    let city = parts.next().map(str::to_string);

    (province, city)
}

/// 광주·전남은 KOPIS 에서 '전남광주(통합특별시)' 로 합쳐져 지역 코드 29·46 의 예매 순위가 비어 온다.
/// 그 지역 코드에 넣을 전국 순위의 지역 이름
const MERGED_AREAS: [(&str, &[&str]); 2] =
    [("29", &["광주", "전남광주"]), ("46", &["전남", "전남광주"])];

/// 전국 순위에서 합쳐진 지역의 공연만 골라 그 지역 안에서 1위부터 다시 매긴다
fn merged_area_rankings(area_code: &str, national: &[BoxofficeItem]) -> Vec<BoxofficeItem> {
    let Some((_, names)) = MERGED_AREAS.iter().find(|(code, _)| *code == area_code) else {
        return Vec::new();
    };
    national
        .iter()
        .filter(|item| names.contains(&item.area.trim()))
        .enumerate()
        .map(|(index, item)| BoxofficeItem {
            ranking: index as i32 + 1,
            ..item.clone()
        })
        .collect()
}

/// sync_metadata.error_message 에 다시 받을 공연 ID 를 적을 때의 머리말
const RETRY_PREFIX: &str = "retry:";
/// 실패한 공연이 이보다 많으면 목록 대신 날짜를 붙잡는다(KOPIS 가 오래 막힌 날)
const RETRY_LIST_LIMIT: usize = 200;

/// "retry:PF1,PF2" 에서 공연 ID 만 꺼낸다. 다른 오류 문구면 비어 있다
fn parse_retry_ids(message: &str) -> Vec<String> {
    message
        .strip_prefix(RETRY_PREFIX)
        .map(|list| {
            list.split(',')
                .map(str::trim)
                .filter(|id| !id.is_empty() && id.chars().all(|c| c.is_ascii_alphanumeric()))
                .map(str::to_string)
                .collect()
        })
        .unwrap_or_default()
}

/// 한 공연 상세를 받아 저장한 결과. 바깥 동기화가 셈을 더한다
#[derive(Debug, Default)]
struct ImportOutcome {
    added: i32,
    updated: i32,
    errors: i32,
    /// 호출·연결 실패라 다음 동기화가 이 공연만 다시 받아야 한다
    retry: bool,
}

/// KOPIS 공연 하나의 상세를 받아 공연장에 맞춰 저장한다(예매처·소개 그림·출연진 연결 포함)
async fn import_concert(
    pool: &MySqlPool,
    client: &KopisClient,
    artist_index: &ArtistNameIndex,
    performance_id: &str,
) -> ImportOutcome {
    let mut added_count = 0;
    let mut updated_count = 0;
    let mut error_count = 0;
    let mut retry_needed = false;

    // 공연 상세 정보 조회
    match client.fetch_concert_detail(performance_id).await {
        Ok(detail_response) => {
            let detail = detail_response.db;

            // venue_kopis_id로 venue_id 매칭
            match resolve_venue_id(pool, client, &detail.facility_id).await {
                Ok(Some(venue_id)) => {
                    // 공연 데이터 upsert
                    let start_date_str = detail
                        .parse_start_date()
                        .map(|d| d.format("%Y-%m-%d").to_string())
                        .unwrap_or(detail.start_date.clone());

                    let end_date_str = detail
                        .parse_end_date()
                        .map(|d| d.format("%Y-%m-%d").to_string());

                    match ConcertRepository::upsert_kopis_concert(
                        pool,
                        &detail.performance_id,
                        &detail.performance_name,
                        // KOPIS 상세에는 작곡가·곡목 필드가 없다. 예전엔 출연진을 여기 넣어 복사본이 쌓였다
                        None,
                        venue_id,
                        &start_date_str,
                        end_date_str.as_deref(),
                        detail.performance_schedule.as_deref(), // concert_time (KOPIS dtguidance)
                        detail.poster.as_deref(),
                        detail.synopsis.as_deref(),
                        detail.price_info.as_deref(),
                        &detail.parse_status(),
                        // KOPIS 추가 필드들
                        &detail.facility_id,
                        detail.update_date.as_deref(),
                        Some(&detail.genre_name),
                        detail.area.as_deref(),
                        Some(&detail.facility_name),
                        detail.is_open_run(),
                        detail.cast.as_deref(),
                        detail.crew.as_deref(),
                        detail.runtime.as_deref(),
                        detail.age_restriction.as_deref(),
                        detail.synopsis.as_deref(),
                        detail.performance_schedule.as_deref(),
                        detail.production_company.as_deref(),
                        detail.production_company_plan.as_deref(),
                        detail.production_company_agency.as_deref(),
                        detail.production_company_host.as_deref(),
                        detail.production_company_sponsor.as_deref(),
                        detail.is_visit(),
                        detail.is_child(),
                        detail.is_daehakro(),
                        detail.is_festival(),
                    )
                    .await
                    {
                        Ok(concert_id) => {
                            // Ticket Vendors 저장
                            if let Some(vendor_list) = &detail.ticket_vendors {
                                let vendors: Vec<(Option<String>, String)> = vendor_list
                                    .vendors
                                    .iter()
                                    .map(|v| (v.vendor_name.clone(), v.vendor_url.clone()))
                                    .collect();

                                if !vendors.is_empty() {
                                    if let Err(e) = ConcertRepository::upsert_ticket_vendors(
                                        pool, concert_id, vendors,
                                    )
                                    .await
                                    {
                                        Logger::warn(
                                            "KOPIS",
                                            &format!(
                                                "Failed to save ticket vendors for concert {}: {}",
                                                detail.performance_name, e
                                            ),
                                        );
                                    }
                                }
                            }

                            // Concert Images 저장 (소개 이미지)
                            if let Some(intro_images) = &detail.intro_images {
                                if !intro_images.images.is_empty() {
                                    if let Err(e) = ConcertRepository::upsert_concert_images(
                                        pool,
                                        concert_id,
                                        intro_images.images.clone(),
                                        "introduction",
                                    )
                                    .await
                                    {
                                        Logger::warn(
                                            "KOPIS",
                                            &format!(
                                                "Failed to save intro images for concert {}: {}",
                                                detail.performance_name, e
                                            ),
                                        );
                                    }
                                }
                            }

                            // 출연진 → 아티스트 연결, 편성 분류
                            match ConcertService::enrich_concert(
                                pool,
                                artist_index,
                                concert_id,
                                &detail.performance_name,
                                detail.cast.as_deref(),
                                true,
                            )
                            .await
                            {
                                Ok(0) => {}
                                Ok(added) => Logger::success(
                                    "KOPIS",
                                    &format!(
                                        "Matched {} artists for concert: {}",
                                        added, detail.performance_name
                                    ),
                                ),
                                Err(e) => Logger::warn(
                                    "KOPIS",
                                    &format!(
                                        "Failed to enrich concert {}: {}",
                                        detail.performance_name, e
                                    ),
                                ),
                            }

                            // 기존 공연 여부 확인
                            if ConcertRepository::get_by_kopis_id(pool, &detail.performance_id)
                                .await
                                .ok()
                                .flatten()
                                .is_some()
                            {
                                updated_count += 1;
                                Logger::debug(
                                    "KOPIS",
                                    &format!(
                                        "Updated concert: {} (ID: {})",
                                        detail.performance_name, concert_id
                                    ),
                                );
                            } else {
                                added_count += 1;
                                Logger::success(
                                    "KOPIS",
                                    &format!(
                                        "Added new concert: {} (ID: {})",
                                        detail.performance_name, concert_id
                                    ),
                                );
                            }
                        }
                        Err(e) => {
                            Logger::error(
                                "KOPIS",
                                &format!(
                                    "Failed to upsert concert {}: {}",
                                    detail.performance_name, e
                                ),
                            );
                            error_count += 1;
                            // 값이 칸에 안 맞는 오류는 다시 해도 같다. 연결 오류만 다시 받는다
                            if !is_data_error(&e) {
                                retry_needed = true;
                            }
                        }
                    }
                }
                Ok(None) => {
                    Logger::warn(
                        "KOPIS",
                        &format!(
                            "Venue not found for concert {} (facility_id: {}), skipping",
                            detail.performance_name, detail.facility_id
                        ),
                    );
                    error_count += 1;
                }
                Err(e) => {
                    Logger::error(
                        "KOPIS",
                        &format!("Failed to get venue_id for {}: {}", detail.facility_id, e),
                    );
                    error_count += 1;
                    retry_needed = true;
                }
            }
        }
        Err(e) => {
            Logger::warn(
                "KOPIS",
                &format!(
                    "Failed to fetch detail for concert {}: {}",
                    performance_id, e
                ),
            );
            error_count += 1;
            retry_needed = true;
        }
    }

    ImportOutcome {
        added: added_count,
        updated: updated_count,
        errors: error_count,
        retry: retry_needed,
    }
}

/// 값 자체가 잘못돼 다시 해도 같은 결과인 DB 오류(SQLSTATE 22: 데이터 오류, 23: 제약 위반)
fn is_data_error(error: &sqlx::Error) -> bool {
    error
        .as_database_error()
        .and_then(|db| db.code())
        .map(|code| code.starts_with("22") || code.starts_with("23"))
        .unwrap_or(false)
}

/// KOPIS 공연 날짜는 한국 날짜다
fn kst_today() -> NaiveDate {
    (Utc::now() + Duration::hours(9)).date_naive()
}

/// 끝난 공연인지. 끝 날짜가 없으면 시작 날짜로 본다
fn concert_has_ended(concert: &Concert, today: NaiveDate) -> bool {
    let last_day = concert.end_date.as_deref().unwrap_or(&concert.start_date);
    NaiveDate::parse_from_str(last_day, "%Y-%m-%d")
        .map(|day| day < today)
        .unwrap_or(false)
}

#[derive(Debug)]
pub struct SyncResult {
    pub added: i32,
    pub updated: i32,
    pub errors: i32,
}

#[cfg(test)]
mod retry_list_tests {
    use super::*;

    #[test]
    fn reads_only_ids_from_a_retry_list() {
        assert_eq!(
            parse_retry_ids("retry:PF303587, PF302999,,PF30 1"),
            vec!["PF303587".to_string(), "PF302999".to_string()]
        );
        assert!(parse_retry_ids("KOPIS API returned error: 500").is_empty());
        assert!(parse_retry_ids("retry:").is_empty());
    }
}

#[cfg(test)]
mod merged_area_tests {
    use super::*;

    fn item(ranking: i32, area: &str, id: &str) -> BoxofficeItem {
        BoxofficeItem {
            venue_name: String::new(),
            seat_count: None,
            ranking,
            poster: None,
            performance_period: String::new(),
            performance_id: id.to_string(),
            performance_name: id.to_string(),
            category: "서양음악(클래식)".to_string(),
            performance_count: None,
            area: area.to_string(),
        }
    }

    #[test]
    fn gwangju_and_jeonnam_take_the_merged_region_from_the_national_list() {
        let national = vec![
            item(1, "서울", "PF1"),
            item(6, "전남광주", "PF6"),
            item(9, "부산", "PF9"),
            item(12, "전남광주", "PF12"),
        ];
        let gwangju = merged_area_rankings("29", &national);
        assert_eq!(
            gwangju
                .iter()
                .map(|i| (i.ranking, i.performance_id.as_str()))
                .collect::<Vec<_>>(),
            vec![(1, "PF6"), (2, "PF12")]
        );
        assert_eq!(merged_area_rankings("46", &national).len(), 2);
        assert!(merged_area_rankings("11", &national).is_empty());
    }
}
