use ClassicMap_back::db::DbPool;
use ClassicMap_back::composer::model::CreateComposer;
use ClassicMap_back::composer::service::ComposerService;
use ClassicMap_back::piece::model::CreatePiece;
use ClassicMap_back::piece::service::PieceService;
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

async fn create_test_composer(pool: &DbPool) -> i32 {
    let composer = CreateComposer {
        name: unique_name("test_composer"),
        full_name: "Test Composer".to_string(),
        english_name: "Test Composer".to_string(),
        period: "바로크".to_string(),
        birth_year: 1800,
        death_year: 1900,
        nationality: "테스트".to_string(),
        image_url: None,
        avatar_url: None,
        cover_image_url: None,
        bio: None,
        style: None,
        influence: None,
    };
    ComposerService::create_composer(pool, composer).await.unwrap()
}

async fn cleanup_piece_and_composer(pool: &DbPool, piece_id: i32, composer_id: i32) {
    PieceService::delete_piece(pool, piece_id).await.ok();
    ComposerService::delete_composer(pool, composer_id).await.ok();
}

#[tokio::test]
async fn test_create_piece_success() {
    let pool = setup_test_pool().await;
    let composer_id = create_test_composer(&pool).await;

    let new_piece = CreatePiece {
        composer_id,
        title: unique_title("교향곡 제5번"),
        description: Some("운명".to_string()),
        opus_number: Some("Op. 67".to_string()),
        composition_year: Some(1808),
        difficulty_level: Some(5),
        duration_minutes: Some(33),
    };

    let result = PieceService::create_piece(&pool, new_piece).await;
    assert!(result.is_ok());
    let piece_id = result.unwrap();
    assert!(piece_id > 0);
    
    cleanup_piece_and_composer(&pool, piece_id, composer_id).await;
}

#[tokio::test]
async fn test_get_piece_by_id() {
    let pool = setup_test_pool().await;
    let composer_id = create_test_composer(&pool).await;

    let new_piece = CreatePiece {
        composer_id,
        title: unique_title("피아노 소나타"),
        description: Some("월광".to_string()),
        opus_number: Some("Op. 27 No. 2".to_string()),
        composition_year: Some(1801),
        difficulty_level: Some(4),
        duration_minutes: Some(15),
    };

    let piece_id = PieceService::create_piece(&pool, new_piece).await.unwrap();

    let result = PieceService::get_piece_by_id(&pool, piece_id).await;
    assert!(result.is_ok());
    
    let piece = result.unwrap();
    assert!(piece.is_some());
    
    let piece = piece.unwrap();
    assert_eq!(piece.id, piece_id);
    assert_eq!(piece.composer_id, composer_id);
    assert_eq!(piece.description, Some("월광".to_string()));
    
    cleanup_piece_and_composer(&pool, piece_id, composer_id).await;
}

#[tokio::test]
async fn test_get_piece_by_id_not_found() {
    let pool = setup_test_pool().await;

    let result = PieceService::get_piece_by_id(&pool, 999999).await;
    assert!(result.is_ok());
    assert!(result.unwrap().is_none());
}

#[tokio::test]
async fn test_get_pieces_by_composer() {
    let pool = setup_test_pool().await;
    let composer_id = create_test_composer(&pool).await;

    let piece1 = CreatePiece {
        composer_id,
        title: unique_title("교향곡 제1번"),
        description: None,
        opus_number: None,
        composition_year: None,
        difficulty_level: None,
        duration_minutes: None,
    };

    let piece2 = CreatePiece {
        composer_id,
        title: unique_title("교향곡 제2번"),
        description: None,
        opus_number: None,
        composition_year: None,
        difficulty_level: None,
        duration_minutes: None,
    };

    let piece_id1 = PieceService::create_piece(&pool, piece1).await.unwrap();
    let piece_id2 = PieceService::create_piece(&pool, piece2).await.unwrap();

    let result = PieceService::get_pieces_by_composer(&pool, composer_id).await;
    assert!(result.is_ok());
    
    let pieces = result.unwrap();
    assert!(pieces.len() >= 2);
    assert!(pieces.iter().all(|p| p.composer_id == composer_id));
    
    PieceService::delete_piece(&pool, piece_id1).await.ok();
    PieceService::delete_piece(&pool, piece_id2).await.ok();
    ComposerService::delete_composer(&pool, composer_id).await.ok();
}

#[tokio::test]
async fn test_get_all_pieces() {
    let pool = setup_test_pool().await;
    let composer_id = create_test_composer(&pool).await;

    let piece1 = CreatePiece {
        composer_id,
        title: unique_title("협주곡 제1번"),
        description: None,
        opus_number: None,
        composition_year: None,
        difficulty_level: None,
        duration_minutes: None,
    };

    let piece2 = CreatePiece {
        composer_id,
        title: unique_title("협주곡 제2번"),
        description: None,
        opus_number: None,
        composition_year: None,
        difficulty_level: None,
        duration_minutes: None,
    };

    let piece_id1 = PieceService::create_piece(&pool, piece1).await.unwrap();
    let piece_id2 = PieceService::create_piece(&pool, piece2).await.unwrap();

    let result = PieceService::get_all_pieces(&pool).await;
    assert!(result.is_ok());
    assert!(result.unwrap().len() >= 2);
    
    PieceService::delete_piece(&pool, piece_id1).await.ok();
    PieceService::delete_piece(&pool, piece_id2).await.ok();
    ComposerService::delete_composer(&pool, composer_id).await.ok();
}

#[tokio::test]
async fn test_delete_piece() {
    let pool = setup_test_pool().await;
    let composer_id = create_test_composer(&pool).await;

    let new_piece = CreatePiece {
        composer_id,
        title: unique_title("테스트 작품"),
        description: None,
        opus_number: None,
        composition_year: None,
        difficulty_level: None,
        duration_minutes: None,
    };

    let piece_id = PieceService::create_piece(&pool, new_piece).await.unwrap();

    let result = PieceService::delete_piece(&pool, piece_id).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 1);

    let deleted = PieceService::get_piece_by_id(&pool, piece_id).await.unwrap();
    assert!(deleted.is_none());
    
    ComposerService::delete_composer(&pool, composer_id).await.ok();
}

#[tokio::test]
async fn test_delete_piece_not_exists() {
    let pool = setup_test_pool().await;

    let result = PieceService::delete_piece(&pool, 999999).await;
    assert!(result.is_ok());
    assert_eq!(result.unwrap(), 0);
}
