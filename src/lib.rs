#![allow(non_snake_case)]
#[macro_use]
extern crate rocket;
// main.rs가 모듈을 따로 컴파일하므로 양쪽에서 같은 경로로 lib 항목을 부르게 한다.
extern crate self as ClassicMap_back;

pub mod artist;
pub mod auth;
pub mod boxoffice;
pub mod clip_alignment_loader;
pub mod clip_asset_loader;
pub mod clip_bundle_builder;
pub mod comparison;
pub mod comparison_seed_loader;
pub mod composer;
pub mod concert;
pub mod db;
pub mod global_seed_loader;
pub mod legacy_authority_linker;
pub mod listening_note_loader;
pub mod logger;
pub mod loudness_profile_loader;
pub mod performance;
pub mod performance_sector;
pub mod piece;
pub mod piece_reco_feature_loader;
pub mod recording;
pub mod search;
pub mod seed_approval;
pub mod taste;
pub mod user;
