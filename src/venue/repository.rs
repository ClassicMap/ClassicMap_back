use sqlx::MySqlPool;
use super::model::{Venue, CreateVenue, UpdateVenue};

pub struct VenueRepository;

impl VenueRepository {
    pub async fn get_all(pool: &MySqlPool) -> Result<Vec<Venue>, sqlx::Error> {
        sqlx::query_as::<_, Venue>("SELECT * FROM venues ORDER BY name")
            .fetch_all(pool)
            .await
    }

    pub async fn get_by_id(pool: &MySqlPool, id: i32) -> Result<Option<Venue>, sqlx::Error> {
        sqlx::query_as::<_, Venue>("SELECT * FROM venues WHERE id = ?")
            .bind(id)
            .fetch_optional(pool)
            .await
    }

    pub async fn get_by_kopis_id(pool: &MySqlPool, kopis_id: &str) -> Result<Option<Venue>, sqlx::Error> {
        sqlx::query_as::<_, Venue>("SELECT * FROM venues WHERE kopis_id = ?")
            .bind(kopis_id)
            .fetch_optional(pool)
            .await
    }

    pub async fn create(pool: &MySqlPool, venue: CreateVenue) -> Result<i32, sqlx::Error> {
        let result = sqlx::query(
            "INSERT INTO venues (kopis_id, name, address, city, province, country, seats, hall_count, opening_year, is_active, data_source)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(&venue.kopis_id)
        .bind(&venue.name)
        .bind(&venue.address)
        .bind(&venue.city)
        .bind(&venue.province)
        .bind(&venue.country)
        .bind(venue.seats)
        .bind(venue.hall_count)
        .bind(venue.opening_year)
        .bind(venue.is_active.unwrap_or(true))
        .bind(&venue.data_source)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn upsert(pool: &MySqlPool, venue: CreateVenue) -> Result<i32, sqlx::Error> {
        // kopis_id가 있으면 해당 레코드를 업데이트하고, 없으면 새로 생성
        if let Some(ref kopis_id) = venue.kopis_id {
            let existing = Self::get_by_kopis_id(pool, kopis_id).await?;

            if let Some(existing_venue) = existing {
                // 업데이트
                sqlx::query(
                    "UPDATE venues SET name = ?, address = ?, city = ?, province = ?, country = ?,
                     seats = ?, hall_count = ?, opening_year = ?, is_active = ?, data_source = ?
                     WHERE kopis_id = ?"
                )
                .bind(&venue.name)
                .bind(&venue.address)
                .bind(&venue.city)
                .bind(&venue.province)
                .bind(&venue.country)
                .bind(venue.seats)
                .bind(venue.hall_count)
                .bind(venue.opening_year)
                .bind(venue.is_active.unwrap_or(true))
                .bind(&venue.data_source)
                .bind(kopis_id)
                .execute(pool)
                .await?;

                return Ok(existing_venue.id);
            }
        }

        // 새로 생성
        Self::create(pool, venue).await
    }

    pub async fn update(pool: &MySqlPool, id: i32, venue: UpdateVenue) -> Result<u64, sqlx::Error> {
        let mut updates = Vec::new();

        if venue.kopis_id.is_some() {
            updates.push("kopis_id");
        }
        if venue.name.is_some() {
            updates.push("name");
        }
        if venue.address.is_some() {
            updates.push("address");
        }
        if venue.city.is_some() {
            updates.push("city");
        }
        if venue.province.is_some() {
            updates.push("province");
        }
        if venue.country.is_some() {
            updates.push("country");
        }
        if venue.seats.is_some() {
            updates.push("seats");
        }
        if venue.hall_count.is_some() {
            updates.push("hall_count");
        }
        if venue.opening_year.is_some() {
            updates.push("opening_year");
        }
        if venue.is_active.is_some() {
            updates.push("is_active");
        }
        if venue.data_source.is_some() {
            updates.push("data_source");
        }

        if updates.is_empty() {
            return Ok(0);
        }

        let set_clause = updates.iter().map(|field| format!("{} = ?", field)).collect::<Vec<_>>().join(", ");
        let query = format!("UPDATE venues SET {} WHERE id = ?", set_clause);

        let mut q = sqlx::query(&query);

        if let Some(kopis_id) = &venue.kopis_id {
            q = q.bind(kopis_id);
        }
        if let Some(name) = &venue.name {
            q = q.bind(name);
        }
        if let Some(address) = &venue.address {
            q = q.bind(address);
        }
        if let Some(city) = &venue.city {
            q = q.bind(city);
        }
        if let Some(province) = &venue.province {
            q = q.bind(province);
        }
        if let Some(country) = &venue.country {
            q = q.bind(country);
        }
        if let Some(seats) = venue.seats {
            q = q.bind(seats);
        }
        if let Some(hall_count) = venue.hall_count {
            q = q.bind(hall_count);
        }
        if let Some(opening_year) = venue.opening_year {
            q = q.bind(opening_year);
        }
        if let Some(is_active) = venue.is_active {
            q = q.bind(is_active);
        }
        if let Some(data_source) = &venue.data_source {
            q = q.bind(data_source);
        }

        q = q.bind(id);

        let result = q.execute(pool).await?;
        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &MySqlPool, id: i32) -> Result<u64, sqlx::Error> {
        let result = sqlx::query("DELETE FROM venues WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
