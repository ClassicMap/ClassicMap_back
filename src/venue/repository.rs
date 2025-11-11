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

    pub async fn create(pool: &MySqlPool, venue: CreateVenue) -> Result<i32, sqlx::Error> {
        let result = sqlx::query(
            "INSERT INTO venues (name, address, city, country, capacity) VALUES (?, ?, ?, ?, ?)"
        )
        .bind(&venue.name)
        .bind(&venue.address)
        .bind(&venue.city)
        .bind(&venue.country)
        .bind(&venue.capacity)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id() as i32)
    }

    pub async fn update(pool: &MySqlPool, id: i32, venue: UpdateVenue) -> Result<u64, sqlx::Error> {
        let mut query = String::from("UPDATE venues SET ");
        let mut updates = Vec::new();
        let mut params: Vec<String> = Vec::new();

        if let Some(name) = &venue.name {
            updates.push("name = ?");
            params.push(name.clone());
        }
        if let Some(address) = &venue.address {
            updates.push("address = ?");
            params.push(address.clone());
        }
        if let Some(city) = &venue.city {
            updates.push("city = ?");
            params.push(city.clone());
        }
        if let Some(country) = &venue.country {
            updates.push("country = ?");
            params.push(country.clone());
        }

        if updates.is_empty() && venue.capacity.is_none() {
            return Ok(0);
        }

        query.push_str(&updates.join(", "));

        if venue.capacity.is_some() {
            if !updates.is_empty() {
                query.push_str(", ");
            }
            query.push_str("capacity = ?");
        }

        query.push_str(" WHERE id = ?");

        let mut q = sqlx::query(&query);
        for param in params {
            q = q.bind(param);
        }
        if let Some(capacity) = venue.capacity {
            q = q.bind(capacity);
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
