use ClassicMap_back::db::DbPool;
use ClassicMap_back::artist::model::CreateArtist;
use ClassicMap_back::artist::service::ArtistService;
use std::sync::atomic::{AtomicU32, Ordering};

static TEST_COUNTER: AtomicU32 = AtomicU32::new(0);

fn unique_name(prefix: &str) -> String {
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

#[tokio::test]
async fn test_create_artist_success() {
    let pool = setup_test_pool().await;

    let new_artist = CreateArtist {
        name: unique_name("조성진"),
        english_name: "Seong-Jin Cho".to_string(),
        category: "피아니스트".to_string(),
        tier: "A".to_string(),
        nationality: "한국".to_string(),
        rating: Some(4.8),
        image_url: None,
        cover_image_url: None,
        birth_year: Some("1994".to_string()),
        bio: Some("2015 쇼팽 콩쿠르 우승".to_string()),
        style: Some("섬세하고 정교한 연주".to_string()),
    };

    let result = ArtistService::create_artist(&pool, new_artist).await;
    assert!(result.is_ok());
    let artist_id = result.unwrap();
    assert!(artist_id > 0);
    
    ArtistService::delete_artist(&pool, artist_id).await.ok();
}

#[tokio::test]
async fn test_get_artist_by_id() {
    let pool = setup_test_pool().await;

    let new_artist = CreateArtist {
        name: unique_name("임윤찬"),
        english_name: "Yunchan Lim".to_string(),
        category: "피아니스트".to_string(),
        tier: "S".to_string(),
        nationality: "한국".to_string(),
        rating: Some(5.0),
        image_url: None,
        cover_image_url: None,
        birth_year: Some("2004".to_string()),
        bio: Some("2022 반 클라이번 콩쿠르 우승".to_string()),
        style: None,
    };

    let artist_id = ArtistService::create_artist(&pool, new_artist).await.unwrap();

    let result = ArtistService::get_artist_by_id(&pool, artist_id).await;
    if let Err(ref e) = result {
        eprintln!("Error getting artist: {}", e);
    }
    assert!(result.is_ok());
    
    let artist = result.unwrap();
    assert!(artist.is_some());
    
    let artist = artist.unwrap();
    assert_eq!(artist.id, artist_id);
    assert_eq!(artist.category, "피아니스트");
    assert_eq!(artist.tier, "S");
    
    ArtistService::delete_artist(&pool, artist_id).await.ok();
}

#[tokio::test]
async fn test_get_artist_by_id_not_found() {
    let pool = setup_test_pool().await;

    let result = ArtistService::get_artist_by_id(&pool, 999999).await;
    assert!(result.is_ok());
    assert!(result.unwrap().is_none());
}

#[tokio::test]
async fn test_get_all_artists() {
    let pool = setup_test_pool().await;

    let artist1 = CreateArtist {
        name: unique_name("손열음"),
        english_name: "Yeol Eum Son".to_string(),
        category: "피아니스트".to_string(),
        tier: "A".to_string(),
        nationality: "한국".to_string(),
        rating: None,
        image_url: None,
        cover_image_url: None,
        birth_year: Some("1986".to_string()),
        bio: None,
        style: None,
    };

    let artist2 = CreateArtist {
        name: unique_name("정경화"),
        english_name: "Kyung Wha Chung".to_string(),
        category: "바이올리니스트".to_string(),
        tier: "S".to_string(),
        nationality: "한국".to_string(),
        rating: Some(4.9),
        image_url: None,
        cover_image_url: None,
        birth_year: Some("1948".to_string()),
        bio: None,
        style: None,
    };

    let id1 = ArtistService::create_artist(&pool, artist1).await.unwrap();
    let id2 = ArtistService::create_artist(&pool, artist2).await.unwrap();

    let result = ArtistService::get_all_artists(&pool).await;
    assert!(result.is_ok());
    assert!(result.unwrap().len() >= 2);
    
    ArtistService::delete_artist(&pool, id1).await.ok();
    ArtistService::delete_artist(&pool, id2).await.ok();
}

#[tokio::test]
async fn test_delete_artist() {
    let pool = setup_test_pool().await;

    let new_artist = CreateArtist {
        name: unique_name("테스트 아티스트"),
        english_name: "Test Artist".to_string(),
        category: "피아니스트".to_string(),
        tier: "B".to_string(),
        nationality: "테스트".to_string(),
        rating: None,
        image_url: None,
        cover_image_url: None,
        birth_year: None,
        bio: None,
        style: None,
    };

    let artist_id = ArtistService::create_artist(&pool, new_artist).await.unwrap();

    let result = ArtistService::delete_artist(&pool, artist_id).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);

    let deleted = ArtistService::get_artist_by_id(&pool, artist_id).await.unwrap();
    assert!(deleted.is_none());
}

#[tokio::test]
async fn test_delete_artist_not_exists() {
    let pool = setup_test_pool().await;

    let result = ArtistService::delete_artist(&pool, 999999).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 0);
}
