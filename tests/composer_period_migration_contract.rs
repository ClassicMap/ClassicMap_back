#[test]
fn composer_period_migration_covers_international_eras() {
    let migration = include_str!("../migrations/202608050005_expand_composer_periods.sql");

    for period in [
        "'중세'",
        "'르네상스'",
        "'바로크'",
        "'고전주의'",
        "'낭만주의'",
        "'근현대'",
    ] {
        assert!(
            migration.contains(period),
            "시대값이 누락되었습니다: {period}"
        );
    }
}
