#[macro_use]
extern crate rocket;

mod artist;
mod composer;
mod concert;
mod config;
mod db;
mod logger;
mod piece;
mod user;

use dotenv::dotenv;
use logger::Logger;

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

    rocket::build()
        .manage(pool)
        .mount("/", routes![config::favicon])
        .mount(
            "/api",
            routes![
                // Composer routes
                composer::get_composers,
                composer::get_composer,
                composer::create_composer,
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
                artist::create_artist,
                artist::delete_artist,
                // Concert routes
                concert::get_concerts,
                concert::get_concert,
                concert::create_concert,
                concert::delete_concert,
                // User routes
                user::get_users,
                user::get_user,
                user::get_user_by_clerk_id,
                user::get_user_by_email,
                user::update_user,
                user::delete_user,
                user::clerk_webhook,
            ],
        )
}
