use jsonwebtoken::{decode, Algorithm, DecodingKey, Validation};
use serde::{Deserialize, Serialize};
use std::env;

#[derive(Debug, Serialize, Deserialize)]
pub struct Claims {
    pub sub: String, // Clerk user ID
    pub exp: usize,
    pub iat: usize,
    pub iss: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub azp: Option<String>,
}

/// Clerk JWT 토큰 검증
pub fn verify_clerk_token(token: &str) -> Result<Claims, String> {
    // 환경 변수에서 Clerk 공개 키 가져오기
    let public_key = env::var("CLERK_PEM_PUBLIC_KEY")
        .map_err(|_| "CLERK_PEM_PUBLIC_KEY not set in environment".to_string())?;

    let decoding_key = DecodingKey::from_rsa_pem(public_key.as_bytes())
        .map_err(|e| format!("Invalid public key: {}", e))?;

    let validation = Validation::new(Algorithm::RS256);

    // JWT 디코딩 및 검증
    let token_data = decode::<Claims>(token, &decoding_key, &validation)
        .map_err(|e| format!("Token validation failed: {}", e))?;

    Ok(token_data.claims)
}
