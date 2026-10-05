use std::{fs, path::PathBuf};
use ClassicMap_back::{
    db,
    screen::repository::ScreenRepository,
    screen_music_loader::{ScreenMusicLoadOptions, ScreenMusicLoader},
    search::SearchText,
};

const SLUG: &str = "screen-music-integration";
const SECTOR_KEY: &str = "screen-music-integration-sector";

fn line(piece_id: i32, composer_id: i32, status: &str, note: &str) -> String {
    format!(
        r#"{{"slug":"{SLUG}","kind":"SERIES","titleKo":"오징어 게임 통합","titleOriginal":"Squid Integration","releaseYear":2021,"countryCode":"KR","creditLine":"테스트","displayOrder":1,"status":"{status}","identifiers":{{"tmdb_tv":"999999001"}},"cues":[{{"key":"first","order":1,"episode":"S1E1","composerId":{composer_id},"composerName":"작곡가","pieceId":{piece_id},"workTitle":"테스트 곡","part":"3악장","sectorKey":"{SECTOR_KEY}","usage":"SOURCE","arranged":false,"sceneNote":"{note}","spoiler":false,"evidence":[{{"grade":"1","kind":"ost","url":"https://example.com/ost","note":"OST"}}],"status":"{status}"}},{{"key":"second","order":2,"composerName":"없는 작곡가","workTitle":"카탈로그 밖 곡","usage":"SCORE","arranged":true,"sceneNote":"배경으로 흘러요.","spoiler":true,"evidence":[{{"grade":"2","kind":"article","url":"https://a.example.com/1","note":"기사"}},{{"grade":"2","kind":"article","url":"https://b.example.org/2","note":"기사"}}],"status":"{status}"}}]}}"#
    )
}

fn options(path: &PathBuf, dry_run: bool) -> ScreenMusicLoadOptions {
    ScreenMusicLoadOptions {
        input_path: path.clone(),
        dry_run,
        limit: Some(10),
        run_id: Some("screen-music-integration".to_string()),
    }
}

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: scripts/test_screen_music.sh"]
async fn screen_music_loads_idempotently_and_is_served() {
    let pool = db::connect_pool().await.expect("DB 연결");
    sqlx::query("DELETE FROM screen_titles WHERE slug = ?")
        .bind(SLUG)
        .execute(&pool)
        .await
        .expect("이전 작품 정리");

    let (piece_id, composer_id): (i32, i32) =
        sqlx::query_as("SELECT id, composer_id FROM pieces ORDER BY id LIMIT 1")
            .fetch_one(&pool)
            .await
            .expect("작품");
    sqlx::query("DELETE FROM performance_sectors WHERE sector_key = ?")
        .bind(SECTOR_KEY)
        .execute(&pool)
        .await
        .expect("이전 구간 정리");
    sqlx::query(
        "INSERT INTO performance_sectors (piece_id, sector_name, sector_key) VALUES (?, '테스트 구간', ?)",
    )
    .bind(piece_id)
    .bind(SECTOR_KEY)
    .execute(&pool)
    .await
    .expect("구간");

    let path = std::env::temp_dir().join(format!("screen-music-{}.jsonl", std::process::id()));
    fs::write(
        &path,
        line(
            piece_id,
            composer_id,
            "PUBLISHED",
            "숙소에 기상 음악으로 틀어요.",
        ),
    )
    .expect("입력");

    let dry = ScreenMusicLoader::load(&pool, &options(&path, true))
        .await
        .expect("dry-run");
    assert_eq!(dry.planned_mutations.titles_inserted, 1);
    assert_eq!(dry.planned_mutations.cues_inserted, 2);
    assert_eq!(dry.mutations.total, 0);
    assert!(dry.skipped.is_empty(), "{:?}", dry.skipped);

    let applied = ScreenMusicLoader::load(&pool, &options(&path, false))
        .await
        .expect("적재");
    assert_eq!(applied.mutations.cues_inserted, 2);
    let again = ScreenMusicLoader::load(&pool, &options(&path, true))
        .await
        .expect("두 번째 dry-run");
    assert_eq!(
        again.planned_mutations.total, 0,
        "{:?}",
        again.planned_mutations
    );
    assert_eq!(again.unchanged_cues, 2);

    // 연주가 붙기 전에는 같은 대목이라도 비교로 들을 수 없다
    let title_id: i32 = sqlx::query_scalar("SELECT id FROM screen_titles WHERE slug = ?")
        .bind(SLUG)
        .fetch_one(&pool)
        .await
        .expect("작품 id");
    let detail = ScreenRepository::find_title(&pool, title_id)
        .await
        .expect("작품 조회")
        .expect("공개 작품");
    assert_eq!(detail.cues.len(), 2);
    assert_eq!(detail.cues[0].episode_label.as_deref(), Some("S1E1"));
    assert_ne!(detail.cues[0].listen.kind, "sector");

    // 서로 다른 주 연주자 셋의 공개 연주가 붙으면 그 구간으로 바로 듣는다
    let sector_id: i32 =
        sqlx::query_scalar("SELECT id FROM performance_sectors WHERE sector_key = ?")
            .bind(SECTOR_KEY)
            .fetch_one(&pool)
            .await
            .expect("구간 id");
    for artist in 1..=3_i64 {
        let source = 9_000_000 + artist;
        let performance = sqlx::query(
            "INSERT INTO performances (sector_id, piece_id, performance_source_id, start_ms, end_ms, publish_status)
             VALUES (?, ?, ?, 0, 60000, 'PUBLISHED')",
        )
        .bind(sector_id)
        .bind(piece_id)
        .bind(source)
        .execute(&pool)
        .await
        .expect("연주")
        .last_insert_id();
        sqlx::query(
            "INSERT INTO clip_assets (performance_id, is_current, status, public_url)
             VALUES (?, TRUE, 'READY', 'https://clips.example.com/a.mp4')",
        )
        .bind(performance)
        .execute(&pool)
        .await
        .expect("클립");
        sqlx::query(
            "INSERT INTO performance_credits (performance_source_id, artist_id, is_primary) VALUES (?, ?, TRUE)",
        )
        .bind(source)
        .bind(artist)
        .execute(&pool)
        .await
        .expect("크레딧");
    }
    let detail = ScreenRepository::find_title(&pool, title_id)
        .await
        .expect("작품 조회")
        .expect("공개 작품");
    assert_eq!(detail.cues[0].listen.kind, "sector");
    assert_eq!(detail.cues[0].listen.ready_performance_count, Some(3));
    let featured = ScreenRepository::find_featured_cues(&pool, Some(5))
        .await
        .expect("바로 듣기");
    assert!(featured
        .iter()
        .any(|cue| cue.sector_id == sector_id && cue.title_id == title_id));
    assert_eq!(detail.cues[1].listen.kind, "none");
    assert!(detail.cues[1].spoiler);
    assert_eq!(detail.cues[1].evidence.len(), 2);

    let search = ScreenRepository::search_titles(
        &pool,
        &SearchText::parse(Some("오징어게임")).expect("검색어"),
        None,
        None,
        None,
    )
    .await
    .expect("검색");
    assert!(search.items.iter().any(|item| item.id == title_id));
    let by_work = ScreenRepository::search_titles(
        &pool,
        &SearchText::parse(Some("카탈로그 밖")).expect("검색어"),
        None,
        None,
        None,
    )
    .await
    .expect("곡 이름 검색");
    assert!(by_work.items.iter().any(|item| item.id == title_id));
    let other_kind = ScreenRepository::search_titles(
        &pool,
        &SearchText::parse(Some("오징어게임")).expect("검색어"),
        Some("MOVIE"),
        None,
        None,
    )
    .await
    .expect("종류 검색");
    assert!(other_kind.items.iter().all(|item| item.id != title_id));

    let piece_cues = ScreenRepository::find_piece_cues(&pool, piece_id)
        .await
        .expect("곡 쪽 띠");
    assert!(piece_cues.iter().any(|cue| cue.title_id == title_id));

    // 스틸은 후보 안에서만 고르고, 적재기를 다시 돌려도 남는다
    let cue_id = detail.cues[0].id;
    assert_eq!(
        ScreenRepository::set_cue_still(&pool, cue_id, Some("/nope.jpg"))
            .await
            .expect("스틸"),
        Some(false)
    );
    sqlx::query("UPDATE screen_titles SET still_paths = JSON_ARRAY('/a.jpg') WHERE id = ?")
        .bind(title_id)
        .execute(&pool)
        .await
        .expect("후보");
    assert_eq!(
        ScreenRepository::set_cue_still(&pool, cue_id, Some("/a.jpg"))
            .await
            .expect("스틸"),
        Some(true)
    );
    fs::write(
        &path,
        line(
            piece_id,
            composer_id,
            "PUBLISHED",
            "숙소에 아침마다 틀어요.",
        ),
    )
    .expect("입력");
    let changed = ScreenMusicLoader::load(&pool, &options(&path, false))
        .await
        .expect("고친 적재");
    assert_eq!(changed.mutations.cues_updated, 1);
    let still: Option<String> =
        sqlx::query_scalar("SELECT still_path FROM screen_music_cues WHERE id = ?")
            .bind(cue_id)
            .fetch_one(&pool)
            .await
            .expect("스틸 조회");
    assert_eq!(still.as_deref(), Some("/a.jpg"));

    // 초안으로 돌리면 화면에서 빠진다
    fs::write(
        &path,
        line(piece_id, composer_id, "DRAFT", "숙소에 아침마다 틀어요."),
    )
    .expect("입력");
    ScreenMusicLoader::load(&pool, &options(&path, false))
        .await
        .expect("초안 적재");
    assert!(ScreenRepository::find_title(&pool, title_id)
        .await
        .expect("조회")
        .is_none());

    sqlx::query("DELETE FROM screen_titles WHERE slug = ?")
        .bind(SLUG)
        .execute(&pool)
        .await
        .expect("정리");
    for cleanup in [
        "DELETE FROM clip_assets WHERE performance_id IN (SELECT id FROM performances WHERE performance_source_id BETWEEN 9000001 AND 9000003)",
        "DELETE FROM performances WHERE performance_source_id BETWEEN 9000001 AND 9000003",
        "DELETE FROM performance_credits WHERE performance_source_id BETWEEN 9000001 AND 9000003",
    ] {
        sqlx::query(cleanup).execute(&pool).await.expect("연주 정리");
    }
    sqlx::query("DELETE FROM performance_sectors WHERE sector_key = ?")
        .bind(SECTOR_KEY)
        .execute(&pool)
        .await
        .expect("구간 정리");
    let _ = fs::remove_file(&path);
}
