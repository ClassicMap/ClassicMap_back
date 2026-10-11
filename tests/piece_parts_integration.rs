use ClassicMap_back::{
    comparison::repository::ComparisonRepository,
    composer::{repository::ComposerRepository, service::ComposerSort},
    db,
    piece::repository::PieceRepository,
};

const COMPOSER_EN: &str = "Piece Parts Integration";
const OTHER_COMPOSER_EN: &str = "Piece Parts Integration Other";
const ARTIST_EN: &str = "Piece Parts Integration Artist";
const VIDEO_PREFIX: &str = "pp-integration-";

async fn cleanup_performances(pool: &db::DbPool) {
    let video = format!("{VIDEO_PREFIX}%");
    for (sql, label) in [
        (
            "DELETE asset FROM clip_assets asset
             JOIN performances performance ON performance.id = asset.performance_id
             WHERE performance.video_id LIKE ?",
            "클립 정리",
        ),
        (
            "DELETE job FROM clip_jobs job
             JOIN performances performance ON performance.id = job.performance_id
             WHERE performance.video_id LIKE ?",
            "클립 작업 정리",
        ),
        (
            "DELETE FROM performances WHERE video_id LIKE ?",
            "연주 정리",
        ),
        (
            "DELETE credit FROM performance_credits credit
             JOIN performance_sources source ON source.id = credit.performance_source_id
             WHERE source.provider_video_id LIKE ?",
            "크레딧 정리",
        ),
        (
            "DELETE FROM performance_sources WHERE provider_video_id LIKE ?",
            "출처 정리",
        ),
    ] {
        sqlx::query(sql)
            .bind(&video)
            .execute(pool)
            .await
            .expect(label);
    }
}

async fn cleanup(pool: &db::DbPool) {
    cleanup_performances(pool).await;
    for (sql, label) in [
        (
            "DELETE sector FROM performance_sectors sector
             JOIN pieces piece ON piece.id = sector.piece_id
             JOIN composers composer ON composer.id = piece.composer_id
             WHERE composer.english_name IN (?, ?)",
            "구간 정리",
        ),
        (
            "DELETE part FROM piece_parts part
             JOIN pieces piece ON piece.id = part.piece_id
             JOIN composers composer ON composer.id = piece.composer_id
             WHERE composer.english_name IN (?, ?)",
            "part 정리",
        ),
        (
            "DELETE piece FROM pieces piece
             JOIN composers composer ON composer.id = piece.composer_id
             WHERE composer.english_name IN (?, ?)",
            "작품 정리",
        ),
        (
            "DELETE FROM composers WHERE english_name IN (?, ?)",
            "작곡가 정리",
        ),
    ] {
        sqlx::query(sql)
            .bind(COMPOSER_EN)
            .bind(OTHER_COMPOSER_EN)
            .execute(pool)
            .await
            .expect(label);
    }
    sqlx::query("DELETE FROM artists WHERE english_name LIKE ?")
        .bind(format!("{ARTIST_EN}%"))
        .execute(pool)
        .await
        .expect("연주자 정리");
}

async fn insert_composer(pool: &db::DbPool, english_name: &str) -> i32 {
    sqlx::query(
        "INSERT INTO composers (name, full_name, english_name, period, birth_year, nationality)
         VALUES ('파츠 통합', '파츠 통합 작곡가', ?, '낭만주의', 1810, '폴란드')",
    )
    .bind(english_name)
    .execute(pool)
    .await
    .expect("작곡가")
    .last_insert_id() as i32
}

/// `listenable` 이면 스트리밍 링크와 설명을 채워 정렬 첫 단계에서 앞에 서게 한다.
async fn insert_piece(
    pool: &db::DbPool,
    composer_id: i32,
    title: &str,
    opus_number: Option<&str>,
    catalogue: Option<(&str, &str)>,
    listenable: bool,
) -> i32 {
    let (system, number) = catalogue.unzip();
    sqlx::query(
        "INSERT INTO pieces (
            composer_id, title, type, description, opus_number, spotify_url,
            catalogue_system, catalogue_number
         ) VALUES (?, ?, 'song', ?, ?, ?, ?, ?)",
    )
    .bind(composer_id)
    .bind(format!("파츠 통합 {title}"))
    .bind(listenable.then_some("설명"))
    .bind(opus_number)
    .bind(listenable.then_some("https://open.spotify.com/track/integration"))
    .bind(system)
    .bind(number)
    .execute(pool)
    .await
    .expect("작품")
    .last_insert_id() as i32
}

struct NewPart<'a> {
    key: &'a str,
    parent: Option<u64>,
    sequence: i32,
    movement: Option<&'a str>,
    name_ko: Option<&'a str>,
    name_en: Option<&'a str>,
    linked: Option<i32>,
}

async fn insert_part(pool: &db::DbPool, piece_id: i32, part: NewPart<'_>) -> u64 {
    sqlx::query(
        "INSERT INTO piece_parts (
            piece_id, parent_part_id, linked_piece_id, part_key, sequence_number,
            movement_number, name_ko, name_en, editorial_status, origin
         ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'FACTS_VERIFIED', 'manual')",
    )
    .bind(piece_id)
    .bind(part.parent)
    .bind(part.linked)
    .bind(format!("piece-parts-integration:{}", part.key))
    .bind(part.sequence)
    .bind(part.movement)
    .bind(part.name_ko)
    .bind(part.name_en)
    .execute(pool)
    .await
    .expect("part")
    .last_insert_id()
}

/// 서로 다른 주연주자의 공개 연주 하나를 붙인다. 비교 화면 공개 기준의 모든 조건을 채운다.
async fn insert_ready_performance(pool: &db::DbPool, piece_id: i32, sector_id: i32, index: u32) {
    let video = format!("{VIDEO_PREFIX}{piece_id}-{index}");
    let artist_id = sqlx::query(
        "INSERT INTO artists (name, english_name, category, nationality)
         VALUES ('파츠 통합 연주자', ?, '피아니스트', '한국')",
    )
    .bind(format!("{ARTIST_EN} {index}"))
    .execute(pool)
    .await
    .expect("연주자")
    .last_insert_id() as i32;
    let source_id = sqlx::query(
        "INSERT INTO performance_sources (provider, provider_video_id) VALUES ('youtube', ?)",
    )
    .bind(&video)
    .execute(pool)
    .await
    .expect("출처")
    .last_insert_id();
    sqlx::query(
        "INSERT INTO performance_credits (performance_source_id, artist_id, role_code, is_primary)
         VALUES (?, ?, 'soloist', TRUE)",
    )
    .bind(source_id)
    .bind(artist_id)
    .execute(pool)
    .await
    .expect("크레딧");
    let performance_id = sqlx::query(
        "INSERT INTO performances (
            piece_id, sector_id, artist_id, video_id, performance_source_id,
            start_ms, end_ms, publish_status
         ) VALUES (?, ?, ?, ?, ?, 1000, 61000, 'PUBLISHED')",
    )
    .bind(piece_id)
    .bind(sector_id)
    .bind(artist_id)
    .bind(&video)
    .bind(source_id)
    .execute(pool)
    .await
    .expect("연주")
    .last_insert_id() as i32;
    let output_key = format!("{video}.mp4");
    let job_id = sqlx::query(
        "INSERT INTO clip_jobs (performance_id, status, output_key, encoding_profile_version)
         VALUES (?, 'READY', ?, 'integration-v1')",
    )
    .bind(performance_id)
    .bind(&output_key)
    .execute(pool)
    .await
    .expect("클립 작업")
    .last_insert_id();
    sqlx::query(
        "INSERT INTO clip_assets (
            performance_id, clip_job_id, status, storage_path, public_url,
            encoding_profile_version, file_size, duration_ms, sha256,
            ffprobe_result, range_verified, is_current
         ) VALUES (?, ?, 'READY', ?, ?, 'integration-v1', 1024, 60000, ?,
                   JSON_OBJECT('durationMs', 60000), TRUE, TRUE)",
    )
    .bind(performance_id)
    .bind(job_id)
    .bind(format!("/integration/{output_key}"))
    .bind(format!("https://media.example.test/{output_key}"))
    .bind("a".repeat(64))
    .execute(pool)
    .await
    .expect("클립");
}

async fn composer_page(pool: &db::DbPool, composer_id: i32) -> Vec<i32> {
    PieceRepository::find_by_composer_id(pool, composer_id)
        .await
        .expect("작곡가 작품 목록")
        .into_iter()
        .map(|piece| piece.id)
        .collect()
}

#[tokio::test]
#[ignore = "격리 MySQL 에서 실행: scripts/test_piece_parts.sh"]
async fn bundle_parts_hide_linked_pieces_and_order_by_catalogue() {
    let pool = db::connect_pool().await.expect("DB 연결");
    cleanup(&pool).await;

    let composer = insert_composer(&pool, COMPOSER_EN).await;
    let other = insert_composer(&pool, OTHER_COMPOSER_EN).await;

    // 넣는 순서를 일부러 섞어 id 순이 작품번호 순과 다르게 한다
    let quiet = insert_piece(&pool, composer, "조용한 곡", Some("Op. 1"), None, false).await;
    let unnumbered = insert_piece(&pool, composer, "번호 없는 곡", None, None, true).await;
    let op100 = insert_piece(&pool, composer, "Op. 100", Some("Op. 100"), None, true).await;
    let b49 = insert_piece(&pool, composer, "유작", Some("B. 49"), None, true).await;
    let revolutionary = insert_piece(
        &pool,
        composer,
        "연습곡 혁명",
        Some("Op. 10, No. 12"),
        None,
        true,
    )
    .await;
    let op66 = insert_piece(&pool, composer, "즉흥 환상곡", Some("Op. 66"), None, true).await;
    let no3 = insert_piece(
        &pool,
        composer,
        "이별의 곡",
        Some("Op. 10 No. 3"),
        None,
        true,
    )
    .await;
    // catalogue_number 가 있으면 opus_number 보다 그것을 따른다
    let catalogued = insert_piece(
        &pool,
        composer,
        "전주곡집",
        Some("Op. 99"),
        Some(("Op.", "28")),
        true,
    )
    .await;
    let cross_linked = insert_piece(&pool, composer, "스케르초", Some("Op. 50"), None, true).await;
    let bundle = insert_piece(
        &pool,
        composer,
        "연습곡집 Op. 10",
        Some("Op. 10"),
        None,
        true,
    )
    .await;
    let op9 = insert_piece(&pool, composer, "녹턴", Some("Op. 9, No. 2"), None, true).await;
    let other_bundle = insert_piece(&pool, other, "다른 묶음", Some("Op. 1"), None, true).await;

    let revolutionary_part = insert_part(
        &pool,
        bundle,
        NewPart {
            key: "op10-12",
            parent: None,
            sequence: 12,
            movement: Some("12"),
            name_ko: None,
            name_en: Some("No. 12 in C minor \"Revolutionary\""),
            linked: Some(revolutionary),
        },
    )
    .await;
    let second = insert_part(
        &pool,
        bundle,
        NewPart {
            key: "op10-2",
            parent: None,
            sequence: 2,
            movement: Some("2"),
            name_ko: Some("2번 A단조"),
            name_en: Some("No. 2 in A minor"),
            linked: None,
        },
    )
    .await;
    let second_b = insert_part(
        &pool,
        bundle,
        NewPart {
            key: "op10-2-b",
            parent: Some(second),
            sequence: 2,
            movement: None,
            name_ko: None,
            name_en: Some("Coda"),
            linked: None,
        },
    )
    .await;
    let second_a = insert_part(
        &pool,
        bundle,
        NewPart {
            key: "op10-2-a",
            parent: Some(second),
            sequence: 1,
            movement: None,
            name_ko: Some("도입"),
            name_en: None,
            linked: None,
        },
    )
    .await;
    let first = insert_part(
        &pool,
        bundle,
        NewPart {
            key: "op10-1",
            parent: None,
            sequence: 1,
            movement: Some("1"),
            name_ko: Some("1번 C장조"),
            name_en: Some("No. 1 in C major"),
            linked: None,
        },
    )
    .await;
    // 다른 작곡가의 묶음이 가리키는 작품, 자기 자신을 가리키는 part 는 목록에서 빼지 않는다
    insert_part(
        &pool,
        other_bundle,
        NewPart {
            key: "other-1",
            parent: None,
            sequence: 1,
            movement: None,
            name_ko: None,
            name_en: Some("Borrowed"),
            linked: Some(cross_linked),
        },
    )
    .await;
    insert_part(
        &pool,
        op66,
        NewPart {
            key: "op66-self",
            parent: None,
            sequence: 1,
            movement: None,
            name_ko: None,
            name_en: Some("Self"),
            linked: Some(op66),
        },
    )
    .await;

    // 목록: 이어진 혁명은 빠지고, 들을 수 있는 작품 안에서 Op. 번호 → 다른 목록 → 번호 없음 순
    let expected = vec![
        op9,
        bundle,
        no3,
        catalogued,
        cross_linked,
        op66,
        op100,
        b49,
        unnumbered,
        quiet,
    ];
    assert_eq!(composer_page(&pool, composer).await, expected);
    let page = PieceRepository::find_page_by_composer_id(&pool, composer, 2, 3)
        .await
        .expect("작품 페이지");
    assert_eq!(
        page.iter().map(|piece| piece.id).collect::<Vec<_>>(),
        expected[2..5]
    );
    let listed = PieceRepository::find_by_composer_id(&pool, composer)
        .await
        .expect("작품 목록");
    let part_count = |id: i32| {
        listed
            .iter()
            .find(|piece| piece.id == id)
            .map(|piece| piece.part_count)
    };
    assert_eq!(part_count(bundle), Some(3), "최상위 part 만 센다");
    assert_eq!(part_count(op66), Some(1));
    assert_eq!(part_count(no3), Some(0));

    // 작곡가 작품 수도 같은 기준으로 센다
    let detail = ComposerRepository::find_by_id(&pool, composer)
        .await
        .expect("작곡가 상세")
        .expect("작곡가");
    assert_eq!(detail.piece_count, Some(expected.len() as i64));
    let searched = ComposerRepository::search_composers(
        &pool,
        Some(COMPOSER_EN.to_string()),
        None,
        0,
        20,
        ComposerSort::BirthYear,
    )
    .await
    .expect("작곡가 검색");
    let count_of = |id: i32| {
        searched
            .iter()
            .find(|composer| composer.id == id)
            .and_then(|composer| composer.piece_count)
    };
    assert_eq!(count_of(composer), Some(expected.len() as i64));
    assert_eq!(count_of(other), Some(1));

    // 단건·검색은 이어진 작품도 그대로 주고 part 수를 싣는다
    let single = PieceRepository::find_by_id(&pool, bundle)
        .await
        .expect("작품")
        .expect("묶음");
    assert_eq!(single.part_count, 3);
    let found = PieceRepository::search(&pool, Some("파츠 통합 연습곡"), 0, 20)
        .await
        .expect("작품 검색");
    assert!(found
        .iter()
        .any(|result| result.piece.id == revolutionary && result.piece.part_count == 0));
    assert!(found
        .iter()
        .any(|result| result.piece.id == bundle && result.piece.part_count == 3));
    let all = PieceRepository::find_all(&pool).await.expect("전체 작품");
    assert!(all
        .iter()
        .any(|piece| piece.id == bundle && piece.part_count == 3));

    // part: 부모 순서 안에서 자식, 이름은 한국어 → 영어
    let parts = PieceRepository::find_parts(&pool, bundle)
        .await
        .expect("part 목록");
    assert_eq!(
        parts.iter().map(|part| part.id).collect::<Vec<_>>(),
        vec![first, second, second_a, second_b, revolutionary_part]
    );
    assert_eq!(parts[0].name, "1번 C장조");
    assert_eq!(parts[3].name, "Coda");
    assert_eq!(parts[2].parent_part_id, Some(second));
    let linked = parts[4].linked_piece.as_ref().expect("이어진 작품");
    assert_eq!(linked.id, revolutionary);
    assert_eq!(linked.title, "파츠 통합 연습곡 혁명");
    assert_eq!(
        linked.spotify_url.as_deref(),
        Some("https://open.spotify.com/track/integration")
    );
    assert!(!linked.comparable, "공개 구간이 없으면 비교 불가");
    assert!(PieceRepository::find_parts(&pool, i32::MAX)
        .await
        .expect("없는 작품")
        .is_empty());

    // 비교 가능: 비교 화면과 같이 주연주자 3명이 모여야 켜진다
    let sector_id = sqlx::query(
        "INSERT INTO performance_sectors (piece_id, sector_name, editorial_status)
         VALUES (?, '파츠 통합 구간', 'EDITOR_REVIEWED')",
    )
    .bind(revolutionary)
    .execute(&pool)
    .await
    .expect("구간")
    .last_insert_id() as i32;
    insert_ready_performance(&pool, revolutionary, sector_id, 1).await;
    insert_ready_performance(&pool, revolutionary, sector_id, 2).await;
    let comparable = |parts: &[ClassicMap_back::piece::model::PiecePart]| {
        parts[4].linked_piece.as_ref().map(|piece| piece.comparable)
    };
    let two = PieceRepository::find_parts(&pool, bundle)
        .await
        .expect("연주자 둘");
    assert_eq!(comparable(&two), Some(false));
    insert_ready_performance(&pool, revolutionary, sector_id, 3).await;
    let three = PieceRepository::find_parts(&pool, bundle)
        .await
        .expect("연주자 셋");
    assert_eq!(comparable(&three), Some(true));
    let catalog = ComparisonRepository::find_public_pieces(&pool, Some(composer), 0, 50)
        .await
        .expect("비교 카탈로그");
    assert_eq!(
        catalog
            .iter()
            .map(|piece| piece.piece_id)
            .collect::<Vec<_>>(),
        vec![revolutionary],
        "비교 카탈로그도 같은 작품을 연다"
    );

    // 이어진 작품이 지워지면 part 는 남고 연결만 끊긴다
    cleanup_performances(&pool).await;
    sqlx::query("DELETE FROM performance_sectors WHERE id = ?")
        .bind(sector_id)
        .execute(&pool)
        .await
        .expect("구간 삭제");
    PieceRepository::delete(&pool, revolutionary)
        .await
        .expect("이어진 작품 삭제");
    let after = PieceRepository::find_parts(&pool, bundle)
        .await
        .expect("삭제 뒤 part");
    assert_eq!(after.len(), 5);
    assert_eq!(after[4].linked_piece, None);
    assert_eq!(after[4].name, "No. 12 in C minor \"Revolutionary\"");

    cleanup(&pool).await;
}
