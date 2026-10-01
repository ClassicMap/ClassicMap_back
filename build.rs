// sqlx::migrate! 는 컴파일할 때 migrations 폴더를 읽어 넣는다.
// 새 migration 파일만 추가하면 증분 빌드가 다시 읽지 않으므로 폴더 변경을 알린다.
fn main() {
    println!("cargo:rerun-if-changed=migrations");
}
