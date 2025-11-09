use rocket::{get, http::ContentType};

static FAVICON: &[u8] = include_bytes!("../../static/favicon.ico");

#[get("/favicon.ico")]
pub fn favicon() -> (ContentType, &'static [u8]) {
    (ContentType::new("image", "x-icon"), FAVICON)
}
