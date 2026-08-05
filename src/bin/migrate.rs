use ClassicMap_back::db;

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    db::create_pool().await?;
    Ok(())
}
