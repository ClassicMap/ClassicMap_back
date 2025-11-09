#[macro_use]
extern crate rocket;

mod artist;
mod composer;
mod concert;
mod config;
mod db;
mod piece;
mod user;

use dotenv::dotenv;

#[launch]
async fn rocket() -> _ {
    dotenv().ok();

    let pool = db::create_pool()
        .await
        .expect("Failed to create database pool");

    rocket::build().manage(pool).mount(
        "/api",
        routes![
            // config
            config::favicon,
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
            user::create_user,
            user::update_user,
            user::delete_user,
        ],
    )
}
