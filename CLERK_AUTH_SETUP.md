# Clerk JWT 인증 설정 가이드

ClassicMap 백엔드에 Clerk JWT 인증이 추가되었습니다.

## 📋 변경 사항

### 1. 새로 추가된 파일
- `src/auth/mod.rs` - Auth 모듈
- `src/auth/jwt.rs` - JWT 검증 로직
- `src/auth/guards.rs` - Rocket request guards (AuthenticatedUser, ModeratorUser, AdminUser)

### 2. 수정된 파일
- `Cargo.toml` - jsonwebtoken, reqwest 의존성 추가
- `src/main.rs` - auth 모듈 추가
- `.env` - Clerk 환경 변수 추가
- 모든 API 모듈 (composer, artist, piece, concert, performance, recording, venue)
  - GET 요청: 인증 불필요 (공개)
  - POST/PUT/DELETE 요청: ModeratorUser 권한 필요 (admin 또는 moderator)

## 🔧 설정 방법

### 1. Clerk Dashboard에서 공개 키 가져오기

1. [Clerk Dashboard](https://dashboard.clerk.com)에 로그인
2. 프로젝트 선택
3. **Settings** → **API Keys** 클릭
4. **Show JWT public key** 클릭
5. **PEM Public Key** 복사

### 2. .env 파일 설정

`.env` 파일에서 다음 부분을 수정하세요:

```env
# Clerk JWT 인증 설정
CLERK_PEM_PUBLIC_KEY="-----BEGIN PUBLIC KEY-----
여기에_복사한_PEM_공개키를_붙여넣으세요
(여러 줄이어도 됩니다)
-----END PUBLIC KEY-----"

# Clerk issuer (선택사항)
# 형식: https://your-app-name.clerk.accounts.dev
CLERK_ISSUER=https://your-app-name.clerk.accounts.dev
```

### 3. 의존성 설치

```bash
cargo build
```

### 4. 서버 실행

```bash
cargo run
```

## 🔐 인증 플로우

### 프론트엔드 (React Native)

1. 사용자가 Clerk로 로그인
2. `useAuth` 훅이 자동으로 JWT 토큰 획득
3. 모든 API 요청에 `Authorization: Bearer <token>` 헤더 자동 추가

### 백엔드 (Rust Rocket)

1. Request Guard가 Authorization 헤더 확인
2. JWT 토큰을 Clerk 공개 키로 검증
3. 검증 성공 시 DB에서 사용자 정보 조회
4. 사용자 role 확인 (user, moderator, admin)
5. 권한에 따라 요청 허용/거부

## 📝 권한 레벨

### AuthenticatedUser
- 로그인한 모든 사용자
- 사용 예시:
  ```rust
  #[get("/profile")]
  fn get_profile(user: AuthenticatedUser) -> Json<User> {
      Json(user.user)
  }
  ```

### ModeratorUser
- role이 "moderator" 또는 "admin"인 사용자
- 데이터 생성/수정/삭제 권한
- 현재 모든 POST/PUT/DELETE 엔드포인트에 적용됨
- 사용 예시:
  ```rust
  #[post("/composers", data = "<composer>")]
  fn create_composer(
      pool: &State<DbPool>,
      composer: Json<CreateComposer>,
      _moderator: ModeratorUser,
  ) -> Result<Json<i32>, Status> {
      // ...
  }
  ```

### AdminUser
- role이 "admin"인 사용자만
- 최고 권한 (현재는 사용되지 않음, 향후 확장 가능)

## 🧪 테스트

### 인증 없이 GET 요청 (성공)
```bash
curl http://localhost:1028/api/composers
```

### 인증 없이 POST 요청 (401 Unauthorized)
```bash
curl -X POST http://localhost:1028/api/composers \
  -H "Content-Type: application/json" \
  -d '{"name": "Test"}'
```

### JWT 토큰으로 POST 요청 (성공 - moderator 이상)
```bash
curl -X POST http://localhost:1028/api/composers \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -d '{"name": "Test", ...}'
```

## 🐛 문제 해결

### "CLERK_PEM_PUBLIC_KEY not set" 에러
- `.env` 파일에 Clerk 공개 키가 제대로 설정되었는지 확인
- 키가 `"-----BEGIN PUBLIC KEY-----"`로 시작하고 `"-----END PUBLIC KEY-----"`로 끝나는지 확인

### "Invalid token" 에러
- 프론트엔드에서 올바른 Clerk 토큰을 전송하는지 확인
- Clerk Dashboard의 API 키가 프론트엔드와 백엔드에서 동일한지 확인

### "User not found in database" 에러
- Clerk webhook이 제대로 설정되어 있는지 확인
- 사용자가 users 테이블에 존재하는지 확인

### "Moderator or Admin access required" 에러
- 사용자의 role이 "moderator" 또는 "admin"으로 설정되어 있는지 확인
- DB에서 직접 확인:
  ```sql
  SELECT clerk_id, email, role FROM users WHERE email = 'your@email.com';
  ```

## 📚 추가 정보

- [Clerk JWT 문서](https://clerk.com/docs/backend-requests/handling/manual-jwt)
- [Rocket Request Guards](https://rocket.rs/v0.5/guide/requests/#request-guards)
- [jsonwebtoken 크레이트](https://docs.rs/jsonwebtoken/)
