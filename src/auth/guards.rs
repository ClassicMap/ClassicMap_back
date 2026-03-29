use crate::auth::jwt::verify_clerk_token;
use crate::user::model::User;
use rocket::{
    http::Status,
    request::{FromRequest, Outcome, Request},
    State,
};
use sqlx::MySqlPool;

/// 인증된 사용자 정보
#[derive(Debug, Clone)]
pub struct AuthenticatedUser {
    pub clerk_id: String,
    pub user: User,
}

#[rocket::async_trait]
impl<'r> FromRequest<'r> for AuthenticatedUser {
    type Error = String;

    async fn from_request(request: &'r Request<'_>) -> Outcome<Self, Self::Error> {
        // Authorization 헤더 추출
        let auth_header = match request.headers().get_one("Authorization") {
            Some(header) => header,
            None => {
                return Outcome::Error((
                    Status::Unauthorized,
                    "Missing Authorization header".to_string(),
                ))
            }
        };

        // Bearer 토큰 추출
        let token = match auth_header.strip_prefix("Bearer ") {
            Some(token) => token,
            None => {
                return Outcome::Error((
                    Status::Unauthorized,
                    "Invalid Authorization header format".to_string(),
                ))
            }
        };

        // JWT 검증
        let claims = match verify_clerk_token(token) {
            Ok(claims) => claims,
            Err(e) => {
                return Outcome::Error((Status::Unauthorized, format!("Invalid token: {}", e)))
            }
        };

        // DB에서 사용자 정보 조회
        let pool = match request.guard::<&State<MySqlPool>>().await {
            Outcome::Success(pool) => pool,
            _ => {
                return Outcome::Error((
                    Status::InternalServerError,
                    "Database connection failed".to_string(),
                ))
            }
        };

        let user = match sqlx::query_as::<_, User>(
            "SELECT id, clerk_id, email, role, is_first_visit, favorite_era FROM users WHERE clerk_id = ?"
        )
        .bind(&claims.sub)
        .fetch_one(pool.inner())
        .await
        {
            Ok(user) => user,
            Err(_) => {
                return Outcome::Error((
                    Status::Unauthorized,
                    "User not found in database".to_string(),
                ))
            }
        };

        Outcome::Success(AuthenticatedUser {
            clerk_id: claims.sub,
            user,
        })
    }
}

/// 관리자 권한 확인을 위한 가드
#[allow(dead_code)]
#[derive(Debug, Clone)]
pub struct AdminUser {
    pub clerk_id: String,
    pub user: User,
}

#[rocket::async_trait]
impl<'r> FromRequest<'r> for AdminUser {
    type Error = String;

    async fn from_request(request: &'r Request<'_>) -> Outcome<Self, Self::Error> {
        // 먼저 일반 인증 확인
        let authenticated = match request.guard::<AuthenticatedUser>().await {
            Outcome::Success(user) => user,
            Outcome::Error(e) => return Outcome::Error(e),
            Outcome::Forward(f) => return Outcome::Forward(f),
        };

        // role이 admin인지 확인
        if authenticated.user.role != "admin" {
            return Outcome::Error((Status::Forbidden, "Admin access required".to_string()));
        }

        Outcome::Success(AdminUser {
            clerk_id: authenticated.clerk_id,
            user: authenticated.user,
        })
    }
}

/// 모더레이터 이상 권한 확인을 위한 가드 (admin 또는 moderator)
#[allow(dead_code)]
#[derive(Debug, Clone)]
pub struct ModeratorUser {
    pub clerk_id: String,
    pub user: User,
}

#[rocket::async_trait]
impl<'r> FromRequest<'r> for ModeratorUser {
    type Error = String;

    async fn from_request(request: &'r Request<'_>) -> Outcome<Self, Self::Error> {
        // 먼저 일반 인증 확인
        let authenticated = match request.guard::<AuthenticatedUser>().await {
            Outcome::Success(user) => user,
            Outcome::Error(e) => return Outcome::Error(e),
            Outcome::Forward(f) => return Outcome::Forward(f),
        };

        // role이 admin 또는 moderator인지 확인
        if authenticated.user.role != "admin" && authenticated.user.role != "moderator" {
            return Outcome::Error((
                Status::Forbidden,
                "Moderator or Admin access required".to_string(),
            ));
        }

        Outcome::Success(ModeratorUser {
            clerk_id: authenticated.clerk_id,
            user: authenticated.user,
        })
    }
}
