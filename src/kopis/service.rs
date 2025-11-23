use sqlx::MySqlPool;
use chrono::{NaiveDate, Utc};
use super::client::KopisClient;
use crate::venue::{CreateVenue, VenueRepository};
use crate::hall::{CreateHall, HallRepository};
use crate::logger::Logger;

pub struct KopisService;

impl KopisService {
    /// KOPIS API에서 공연장 데이터를 동기화
    pub async fn sync_venues(pool: &MySqlPool) -> Result<SyncResult, String> {
        Logger::info("KOPIS", "Starting venue synchronization");

        // 동기화 시작 기록
        Self::update_sync_status(pool, "venues", "in_progress", None, None, None).await
            .map_err(|e| format!("Failed to update sync status: {}", e))?;

        // 마지막 동기화 날짜 조회
        let last_sync_date = Self::get_last_sync_date(pool, "venues").await?;
        let after_date = last_sync_date.format("%Y%m%d").to_string();

        Logger::info("KOPIS", &format!("Fetching venues after date: {}", after_date));

        // KOPIS 클라이언트 생성
        let client = KopisClient::from_env()?;

        // 공연장 목록 조회 (증분 업데이트)
        let venues = client.fetch_all_venues(Some(&after_date)).await?;

        Logger::info("KOPIS", &format!("Fetched {} venues from KOPIS API", venues.len()));

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
                                        Logger::debug("KOPIS", &format!("Updated venue: {} (ID: {})", detail.facility_name, venue_id));
                                    } else {
                                        added_count += 1;
                                        Logger::success("KOPIS", &format!("Added new venue: {} (ID: {})", detail.facility_name, venue_id));
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

                                            if let Err(e) = HallRepository::upsert(pool, hall_data).await {
                                                Logger::warn("KOPIS", &format!("Failed to upsert hall {}: {}", hall_detail.hall_name, e));
                                                error_count += 1;
                                            }
                                        }
                                    }
                                }
                                Err(e) => {
                                    Logger::error("KOPIS", &format!("Failed to upsert venue {}: {}", detail.facility_name, e));
                                    error_count += 1;
                                }
                            }
                        }
                        Err(e) => {
                            Logger::error("KOPIS", &format!("Failed to check existing venue {}: {}", detail.facility_id, e));
                            error_count += 1;
                        }
                    }
                }
                Err(e) => {
                    Logger::warn("KOPIS", &format!("Failed to fetch detail for venue {}: {}", venue_item.facility_id, e));
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
        ).await?;

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
        let row: Option<(NaiveDate,)> = sqlx::query_as(
            "SELECT last_sync_date FROM sync_metadata WHERE sync_type = ?"
        )
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
        let exists: Option<(i32,)> = sqlx::query_as(
            "SELECT id FROM sync_metadata WHERE sync_type = ?"
        )
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
}

#[derive(Debug)]
pub struct SyncResult {
    pub added: i32,
    pub updated: i32,
    pub errors: i32,
}
