//! 영화 속 클래식. 영화·드라마·애니에 나온 클래식 곡(큐)을 작품과 곡 양쪽에서 찾는다.
mod api;
pub mod model;
pub mod repository;

pub use api::{
    get_featured_screen_cues, get_piece_screen_cues, get_screen_still_candidates, get_screen_title,
    get_screen_titles, put_screen_cue_still, search_screen_titles,
};
