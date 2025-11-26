use super::client::KopisClient;
use crate::artist::repository::ArtistRepository;
use crate::boxoffice::BoxofficeRepository;
use crate::concert::repository::ConcertRepository;
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
    // 아티스트 매칭 헬퍼 함수
    // ============================================

    /// cast 문자열을 파싱하여 아티스트 ID 목록 반환
    /// 예: "손열음, 홍혜란, 김효나" -> [189, 234, ...]
    async fn parse_and_match_artists(pool: &MySqlPool, cast: Option<&str>) -> Vec<i32> {
        let mut artist_ids = Vec::new();

        if let Some(cast_str) = cast {
            // 쉼표나 띄어쓰기 등으로 분리
            let names: Vec<&str> = cast_str
                .split(&[',', '·', '/', '\n'][..])
                .map(|s| s.trim())
                .filter(|s| !s.is_empty() && s.len() > 1) // 너무 짧은 이름 제외
                .collect();

            for name in names {
                // " 등" 제거
                let clean_name = name.trim_end_matches(" 등").trim_end_matches("등").trim();

                // DB에서 아티스트 검색
                match ArtistRepository::find_by_name(pool, clean_name).await {
                    Ok(Some(artist)) => {
                        artist_ids.push(artist.id);
                        Logger::debug(
                            "KOPIS",
                            &format!("Matched artist: {} (ID: {})", clean_name, artist.id),
                        );
                    }
                    Ok(None) => {
                        Logger::debug(
                            "KOPIS",
                            &format!("Artist not found in DB: {}", clean_name),
                        );
                    }
                    Err(e) => {
                        Logger::warn(
                            "KOPIS",
                            &format!("Failed to search artist '{}': {}", clean_name, e),
                        );
                    }
                }
            }
        }

        artist_ids
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

        // 클래식 관련 장르 코드
        let genre_codes = vec![
            "CCCA", // 클래식
            "GGGA", // 뮤지컬
            "CCCC", // 오페라
        ];

        let mut added_count = 0;
        let mut updated_count = 0;
        let mut error_count = 0;

        // 조회 기간 설정 (오늘부터 1년 후까지)
        let today = Utc::now().date_naive();
        let start_date = today.format("%Y%m%d").to_string();
        let end_date = (today + Duration::days(365)).format("%Y%m%d").to_string();

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
                            // 공연 상세 정보 조회
                            match client
                                .fetch_concert_detail(&concert_item.performance_id)
                                .await
                            {
                                Ok(detail_response) => {
                                    let detail = detail_response.db;

                                    // venue_kopis_id로 venue_id 매칭
                                    match ConcertRepository::get_venue_id_by_kopis_id(
                                        pool,
                                        &detail.facility_id,
                                    )
                                    .await
                                    {
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
                                                detail.cast.as_deref(),
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
                                                                pool,
                                                                concert_id,
                                                                vendors,
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

                                                    // 아티스트 매칭 및 저장
                                                    let artist_ids = Self::parse_and_match_artists(pool, detail.cast.as_deref()).await;
                                                    if !artist_ids.is_empty() {
                                                        if let Err(e) = ConcertRepository::upsert_concert_artists(
                                                            pool,
                                                            concert_id,
                                                            artist_ids.clone(),
                                                        )
                                                        .await
                                                        {
                                                            Logger::warn(
                                                                "KOPIS",
                                                                &format!(
                                                                    "Failed to save concert artists for {}: {}",
                                                                    detail.performance_name, e
                                                                ),
                                                            );
                                                        } else {
                                                            Logger::success(
                                                                "KOPIS",
                                                                &format!(
                                                                    "Matched {} artists for concert: {}",
                                                                    artist_ids.len(),
                                                                    detail.performance_name
                                                                ),
                                                            );
                                                        }
                                                    }

                                                    // 기존 공연 여부 확인
                                                    if ConcertRepository::get_by_kopis_id(
                                                        pool,
                                                        &detail.performance_id,
                                                    )
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
                                                }
                                            }
                                        }
                                        Ok(None) => {
                                            Logger::warn("KOPIS", &format!(
                                                "Venue not found for concert {} (facility_id: {}), skipping",
                                                detail.performance_name, detail.facility_id
                                            ));
                                            error_count += 1;
                                        }
                                        Err(e) => {
                                            Logger::error(
                                                "KOPIS",
                                                &format!(
                                                    "Failed to get venue_id for {}: {}",
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
                                            "Failed to fetch detail for concert {}: {}",
                                            concert_item.performance_id, e
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
                                "Failed to fetch concerts for {} ({} ~ {}): {}",
                                genre_code, batch_start, batch_end, e
                            ),
                        );
                        error_count += 1;
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

        // 동기화 완료 기록
        let today = Utc::now().date_naive();
        Self::update_sync_status(
            pool,
            "concerts",
            "success",
            Some(today),
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
            for area_code in &area_codes {
                let area_display = area_code.unwrap_or("전체");

                Logger::info(
                    "KOPIS",
                    &format!(
                        "Fetching boxoffice rankings for genre: {}, area: {}",
                        genre_code, area_display
                    ),
                );

                match client
                    .fetch_boxoffice_rankings(&start_date, &end_date, Some(genre_code), *area_code)
                    .await
                {
                    Ok(response) => {
                        // 기존 순위 데이터 삭제
                        BoxofficeRepository::delete_rankings_for_period(
                            pool,
                            &start_date,
                            &end_date,
                            Some(genre_code),
                            *area_code,
                        )
                        .await
                        .ok();

                        // TOP 3만 저장
                        for item in response.boxof.iter().take(3) {
                            // performance_id로 concert_id 찾기
                            match ConcertRepository::get_by_kopis_id(pool, &item.performance_id)
                                .await
                            {
                                Ok(Some(concert)) => {
                                    match BoxofficeRepository::insert_ranking(
                                        pool,
                                        concert.id,
                                        Some(genre_code),
                                        Some(&item.category),
                                        *area_code,
                                        Some(&item.area),
                                        item.ranking,
                                        None,
                                        item.performance_count.unwrap_or(0),
                                        Some(&item.venue_name),
                                        item.seat_count,
                                        &start_date,
                                        &end_date,
                                    )
                                    .await
                                    {
                                        Ok(_) => {
                                            added_count += 1;
                                            Logger::success(
                                                "KOPIS",
                                                &format!(
                                                    "Added ranking #{} for concert: {}",
                                                    item.ranking, item.performance_name
                                                ),
                                            );
                                        }
                                        Err(e) => {
                                            Logger::error(
                                                "KOPIS",
                                                &format!(
                                                    "Failed to insert ranking for {}: {}",
                                                    item.performance_name, e
                                                ),
                                            );
                                            error_count += 1;
                                        }
                                    }
                                }
                                Ok(None) => {
                                    Logger::warn(
                                        "KOPIS",
                                        &format!(
                                            "Concert not found for ranking: {} (kopis_id: {})",
                                            item.performance_name, item.performance_id
                                        ),
                                    );
                                    error_count += 1;
                                }
                                Err(e) => {
                                    Logger::error(
                                        "KOPIS",
                                        &format!(
                                            "Failed to get concert by kopis_id {}: {}",
                                            item.performance_id, e
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

#[derive(Debug)]
pub struct SyncResult {
    pub added: i32,
    pub updated: i32,
    pub errors: i32,
}
