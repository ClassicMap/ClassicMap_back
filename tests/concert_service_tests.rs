use ClassicMap_back::db::DbPool;
use ClassicMap_back::concert::model::CreateConcert;
use ClassicMap_back::concert::service::ConcertService;
use std::sync::atomic::{AtomicU32, Ordering};

static TEST_COUNTER: AtomicU32 = AtomicU32::new(0);

fn unique_title(prefix: &str) -> String {
    let id = TEST_COUNTER.fetch_add(1, Ordering::SeqCst);
    let timestamp = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis();
    format!("{}_{}", prefix, timestamp + id as u128)
}

async fn setup_test_pool() -> DbPool {
    dotenv::dotenv().ok();
    let database_url = std::env::var("DATABASE_URL")
        .unwrap_or_else(|_| "mysql://root:password@localhost:3306/classicmap_test".to_string());

    sqlx::mysql::MySqlPoolOptions::new()
        .max_connections(5)
        .connect(&database_url)
        .await
        .expect("Failed to create test pool")
}

async fn create_test_venue(pool: &DbPool) -> i32 {
    let result = sqlx::query(
        "INSERT INTO venues (name, address, city, country, capacity) VALUES (?, ?, ?, ?, ?)"
    )
    .bind("테스트 공연장")
    .bind("서울시 강남구")
    .bind("서울")
    .bind("한국")
    .bind(1000)
    .execute(pool)
    .await
    .expect("Failed to create test venue");

    result.last_insert_id() as i32
}

async fn cleanup_concert_and_venue(pool: &DbPool, concert_id: i32, venue_id: i32) {
    ConcertService::delete_concert(pool, concert_id).await.ok();
    sqlx::query("DELETE FROM venues WHERE id = ?")
        .bind(venue_id)
        .execute(pool)
        .await
        .ok();
}

#[tokio::test]
async fn test_create_concert_success() {
    let pool = setup_test_pool().await;
    let venue_id = create_test_venue(&pool).await;

    let new_concert = CreateConcert {
        title: unique_title("베토벤 교향곡 전곡 연주회"),
        composer_info: Some("베토벤 - 교향곡 5번, 9번".to_string()),
        venue_id,
        concert_date: "2024-12-25".to_string(),
        concert_time: Some("19:30:00".to_string()),
        price_info: Some("R석 100,000원, S석 70,000원".to_string()),
        is_recommended: true,
        status: "upcoming".to_string(),
    };

    let result = ConcertService::create_concert(&pool, new_concert).await;
    assert!(result.is_ok());
    let concert_id = result.unwrap();
    assert!(concert_id > 0);
    
    cleanup_concert_and_venue(&pool, concert_id, venue_id).await;
}

#[tokio::test]
async fn test_get_concert_by_id() {
    let pool = setup_test_pool().await;
    let venue_id = create_test_venue(&pool).await;

    let new_concert = CreateConcert {
        title: unique_title("쇼팽 피아노 리사이틀"),
        composer_info: Some("쇼팽 - 녹턴, 발라드".to_string()),
        venue_id,
        concert_date: "2024-11-15".to_string(),
        concert_time: Some("20:00:00".to_string()),
        price_info: None,
        is_recommended: false,
        status: "upcoming".to_string(),
    };

    let concert_id = ConcertService::create_concert(&pool, new_concert).await.unwrap();

    let result = ConcertService::get_concert_by_id(&pool, concert_id).await;
    if let Err(ref e) = result {
        eprintln!("Error getting concert: {}", e);
    }
    assert!(result.is_ok());
    
    let concert = result.unwrap();
    assert!(concert.is_some());
    
    let concert = concert.unwrap();
    assert_eq!(concert.id, concert_id);
    assert_eq!(concert.venue_id, venue_id);
    assert_eq!(concert.is_recommended, false);
    
    cleanup_concert_and_venue(&pool, concert_id, venue_id).await;
}

#[tokio::test]
async fn test_get_concert_by_id_not_found() {
    let pool = setup_test_pool().await;

    let result = ConcertService::get_concert_by_id(&pool, 999999).await;
    assert!(result.is_ok());
    assert!(result.unwrap().is_none());
}

#[tokio::test]
async fn test_get_all_concerts() {
    let pool = setup_test_pool().await;
    let venue_id = create_test_venue(&pool).await;

    let concert1 = CreateConcert {
        title: unique_title("모차르트 실내악 콘서트"),
        composer_info: None,
        venue_id,
        concert_date: "2024-10-10".to_string(),
        concert_time: None,
        price_info: None,
        is_recommended: true,
        status: "upcoming".to_string(),
    };

    let concert2 = CreateConcert {
        title: unique_title("브람스 교향곡의 밤"),
        composer_info: Some("브람스 - 교향곡 1번".to_string()),
        venue_id,
        concert_date: "2024-10-20".to_string(),
        concert_time: None,
        price_info: None,
        is_recommended: false,
        status: "upcoming".to_string(),
    };

    let concert_id1 = ConcertService::create_concert(&pool, concert1).await.unwrap();
    let concert_id2 = ConcertService::create_concert(&pool, concert2).await.unwrap();

    let result = ConcertService::get_all_concerts(&pool).await;
    assert!(result.is_ok());
    assert!(result.unwrap().len() >= 2);
    
    ConcertService::delete_concert(&pool, concert_id1).await.ok();
    ConcertService::delete_concert(&pool, concert_id2).await.ok();
    sqlx::query("DELETE FROM venues WHERE id = ?").bind(venue_id).execute(&pool).await.ok();
}

#[tokio::test]
async fn test_delete_concert() {
    let pool = setup_test_pool().await;
    let venue_id = create_test_venue(&pool).await;

    let new_concert = CreateConcert {
        title: unique_title("테스트 공연"),
        composer_info: None,
        venue_id,
        concert_date: "2024-12-31".to_string(),
        concert_time: None,
        price_info: None,
        is_recommended: false,
        status: "upcoming".to_string(),
    };

    let concert_id = ConcertService::create_concert(&pool, new_concert).await.unwrap();

    let result = ConcertService::delete_concert(&pool, concert_id).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);

    let deleted = ConcertService::get_concert_by_id(&pool, concert_id).await.unwrap();
    assert!(deleted.is_none());
    
    sqlx::query("DELETE FROM venues WHERE id = ?").bind(venue_id).execute(&pool).await.ok();
}

#[tokio::test]
async fn test_delete_concert_not_exists() {
    let pool = setup_test_pool().await;

    let result = ConcertService::delete_concert(&pool, 999999).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 0);
}

#[tokio::test]
async fn test_create_recommended_concert() {
    let pool = setup_test_pool().await;
    let venue_id = create_test_venue(&pool).await;

    let new_concert = CreateConcert {
        title: unique_title("추천 콘서트"),
        composer_info: Some("바흐 - 골드베르크 변주곡".to_string()),
        venue_id,
        concert_date: "2024-11-30".to_string(),
        concert_time: Some("19:00:00".to_string()),
        price_info: Some("전석 50,000원".to_string()),
        is_recommended: true,
        status: "upcoming".to_string(),
    };

    let concert_id = ConcertService::create_concert(&pool, new_concert).await.unwrap();
    let concert = ConcertService::get_concert_by_id(&pool, concert_id).await.unwrap().unwrap();

    assert_eq!(concert.is_recommended, true);
    assert_eq!(concert.status, "upcoming");
    
    cleanup_concert_and_venue(&pool, concert_id, venue_id).await;
}
