use ClassicMap_back::db::DbPool;
use ClassicMap_back::composer::model::CreateComposer;
use ClassicMap_back::composer::service::ComposerService;
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
async fn test_create_composer_success() {
    let pool = setup_test_pool().await;

    let new_composer = CreateComposer {
        name: unique_name("바흐"),
        full_name: "요한 제바스티안 바흐".to_string(),
        english_name: "Johann Sebastian Bach".to_string(),
        period: "바로크".to_string(),
        birth_year: 1685,
        death_year: 1750,
        nationality: "독일".to_string(),
        image_url: None,
        avatar_url: None,
        cover_image_url: None,
        bio: Some("바로크 시대의 대표적인 작곡가".to_string()),
        style: Some("대위법의 대가".to_string()),
        influence: None,
    };

    let result = ComposerService::create_composer(&pool, new_composer).await;
    assert!(result.is_ok());
    let composer_id = result.unwrap();
    assert!(composer_id > 0);
    
    ComposerService::delete_composer(&pool, composer_id).await.ok();
}

#[tokio::test]
async fn test_get_composer_by_id() {
    let pool = setup_test_pool().await;

    let new_composer = CreateComposer {
        name: unique_name("모차르트"),
        full_name: "볼프강 아마데우스 모차르트".to_string(),
        english_name: "Wolfgang Amadeus Mozart".to_string(),
        period: "고전주의".to_string(),
        birth_year: 1756,
        death_year: 1791,
        nationality: "오스트리아".to_string(),
        image_url: None,
        avatar_url: None,
        cover_image_url: None,
        bio: None,
        style: None,
        influence: None,
    };

    let composer_id = ComposerService::create_composer(&pool, new_composer).await.unwrap();

    let result = ComposerService::get_composer_by_id(&pool, composer_id).await;
    assert!(result.is_ok());
    
    let composer = result.unwrap();
    assert!(composer.is_some());
    
    let composer = composer.unwrap();
    assert_eq!(composer.id, composer_id);
    assert_eq!(composer.period, "고전주의");
    assert_eq!(composer.nationality, "오스트리아");
    
    ComposerService::delete_composer(&pool, composer_id).await.ok();
}

#[tokio::test]
async fn test_get_composer_by_id_not_found() {
    let pool = setup_test_pool().await;

    let result = ComposerService::get_composer_by_id(&pool, 999999).await;
    assert!(result.is_ok());
    assert!(result.unwrap().is_none());
}

#[tokio::test]
async fn test_get_all_composers() {
    let pool = setup_test_pool().await;

    let composer1 = CreateComposer {
        name: unique_name("베토벤"),
        full_name: "루트비히 판 베토벤".to_string(),
        english_name: "Ludwig van Beethoven".to_string(),
        period: "고전주의".to_string(),
        birth_year: 1770,
        death_year: 1827,
        nationality: "독일".to_string(),
        image_url: None,
        avatar_url: None,
        cover_image_url: None,
        bio: None,
        style: None,
        influence: None,
    };

    let composer2 = CreateComposer {
        name: unique_name("쇼팽"),
        full_name: "프레데리크 쇼팽".to_string(),
        english_name: "Frederic Chopin".to_string(),
        period: "낭만주의".to_string(),
        birth_year: 1810,
        death_year: 1849,
        nationality: "폴란드".to_string(),
        image_url: None,
        avatar_url: None,
        cover_image_url: None,
        bio: None,
        style: None,
        influence: None,
    };

    let id1 = ComposerService::create_composer(&pool, composer1).await.unwrap();
    let id2 = ComposerService::create_composer(&pool, composer2).await.unwrap();

    let result = ComposerService::get_all_composers(&pool).await;
    assert!(result.is_ok());
    assert!(result.unwrap().len() >= 2);
    
    ComposerService::delete_composer(&pool, id1).await.ok();
    ComposerService::delete_composer(&pool, id2).await.ok();
}

#[tokio::test]
async fn test_delete_composer() {
    let pool = setup_test_pool().await;

    let new_composer = CreateComposer {
        name: unique_name("드뷔시"),
        full_name: "클로드 드뷔시".to_string(),
        english_name: "Claude Debussy".to_string(),
        period: "근현대".to_string(),
        birth_year: 1862,
        death_year: 1918,
        nationality: "프랑스".to_string(),
        image_url: None,
        avatar_url: None,
        cover_image_url: None,
        bio: None,
        style: None,
        influence: None,
    };

    let composer_id = ComposerService::create_composer(&pool, new_composer).await.unwrap();

    let result = ComposerService::delete_composer(&pool, composer_id).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);

    let deleted = ComposerService::get_composer_by_id(&pool, composer_id).await.unwrap();
    assert!(deleted.is_none());
}

#[tokio::test]
async fn test_delete_composer_not_exists() {
    let pool = setup_test_pool().await;

    let result = ComposerService::delete_composer(&pool, 999999).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 0);
}
