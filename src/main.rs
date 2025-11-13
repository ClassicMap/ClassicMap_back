#[macro_use]
extern crate rocket;

mod artist;
mod auth;
mod composer;
mod concert;
mod config;
mod db;
mod logger;
mod performance;
mod piece;
mod recording;
mod upload;
mod user;
mod venue;

use dotenv::dotenv;
use logger::Logger;
use rocket::fs::FileServer;
use rocket::http::Method;
use rocket_cors::{AllowedHeaders, AllowedOrigins, CorsOptions};

#[launch]
async fn rocket() -> _ {
    dotenv().ok();
    Logger::init();

    Logger::info("SYSTEM", "Starting ClassicMap API Server...");

    let pool = db::create_pool()
        .await
        .expect("Failed to create database pool");

    Logger::success("DATABASE", "Connection pool created");
    Logger::info("SERVER", "Mounting routes...");

    // CORS 설정
    let cors = CorsOptions::default()
        .allowed_origins(AllowedOrigins::all())
        .allowed_methods(
            vec![
                Method::Get,
                Method::Post,
                Method::Put,
                Method::Delete,
                Method::Options,
            ]
            .into_iter()
            .map(From::from)
            .collect(),
        )
        .allowed_headers(AllowedHeaders::all())
        .allow_credentials(true)
        .max_age(Some(3600))
        .to_cors()
        .expect("Failed to create CORS");

    rocket::build()
        .manage(pool)
        .attach(cors)
        .mount("/", routes![config::favicon])
        .mount("/uploads", FileServer::from("static/uploads"))
        .mount(
            "/api",
            routes![
                // Composer routes
                composer::get_composers,
                composer::get_composer,
                composer::create_composer,
                composer::update_composer,
                composer::delete_composer,
                // Piece routes
                piece::get_pieces,
                piece::get_piece,
                piece::get_pieces_by_composer,
                piece::create_piece,
                piece::delete_piece,
                // Artist routes
                artist::get_artists,
                artist::get_artist,
                artist::get_artist_concerts,
                artist::create_artist,
                artist::update_artist,
                artist::delete_artist,
                artist::create_artist_award,
                artist::delete_artist_award,
                // Concert routes
                concert::get_concerts,
                concert::get_concert,
                concert::create_concert,
                concert::update_concert,
                concert::delete_concert,
                concert::submit_rating,
                concert::get_user_rating,
                // Performance routes
                performance::get_performances,
                performance::get_performances_by_piece,
                performance::get_performances_by_artist,
                performance::get_performance,
                performance::create_performance,
                performance::update_performance,
                performance::delete_performance,
                // Recording routes
                recording::get_recordings,
                recording::get_recordings_by_artist,
                recording::get_recording,
                recording::create_recording,
                recording::update_recording,
                recording::delete_recording,
                // User routes
                user::get_users,
                user::get_user,
                user::get_user_by_clerk_id,
                user::get_user_by_email,
                user::update_user,
                user::delete_user,
                user::clerk_webhook,
                // Venue routes
                venue::get_venues,
                venue::get_venue,
                venue::create_venue,
                venue::update_venue,
                venue::delete_venue,
                // Upload routes
                upload::upload_composer_avatar,
                upload::upload_composer_cover,
                upload::upload_artist_avatar,
                upload::upload_artist_cover,
                upload::upload_concert_poster,
            ],
        )
}
