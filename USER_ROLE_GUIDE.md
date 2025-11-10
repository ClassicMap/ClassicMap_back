# User 테이블 업데이트 가이드

## 추가된 필드

### 1. role (권한)
- **타입**: ENUM('user', 'moderator', 'admin')
- **기본값**: 'user'
- **설명**:
  - `user`: 일반 사용자
  - `moderator`: 중간 관리자 (콘텐츠 관리 등)
  - `admin`: 최고 관리자 (모든 권한)

### 2. is_first_visit (처음 방문 여부)
- **타입**: BOOLEAN
- **기본값**: TRUE
- **설명**: 
  - 회원가입 후 첫 로그인 시 TRUE
  - 튜토리얼/온보딩 완료 후 FALSE로 업데이트

## 데이터베이스 마이그레이션

기존 DB에 필드를 추가하려면:

```bash
mysql -u user -p classicmap < update_users_table.sql
```

또는 직접 실행:

```sql
-- role 컬럼 추가
ALTER TABLE users 
ADD COLUMN role ENUM('user', 'moderator', 'admin') NOT NULL DEFAULT 'user' COMMENT '권한: 사용자, 중간관리자, 관리자' AFTER email;

-- is_first_visit 컬럼 추가
ALTER TABLE users 
ADD COLUMN is_first_visit BOOLEAN DEFAULT TRUE COMMENT '처음 방문 여부' AFTER role;

-- role 인덱스 추가
ALTER TABLE users 
ADD INDEX idx_role (role);

-- 기존 유저들은 is_first_visit를 FALSE로 설정
UPDATE users SET is_first_visit = FALSE WHERE created_at < NOW();
```

## API 응답 변경

### Before
```json
{
  "id": 1,
  "clerk_id": "user_xxx",
  "email": "user@example.com",
  "favorite_era": "낭만주의"
}
```

### After
```json
{
  "id": 1,
  "clerk_id": "user_xxx",
  "email": "user@example.com",
  "role": "user",
  "is_first_visit": true,
  "favorite_era": "낭만주의"
}
```

## 업데이트 API

### 처음 방문 완료 처리
```bash
PUT /api/users/:id
Content-Type: application/json

{
  "is_first_visit": false
}
```

### 선호 시대 업데이트
```bash
PUT /api/users/:id
Content-Type: application/json

{
  "favorite_era": "바로크"
}
```

### 둘 다 업데이트
```bash
PUT /api/users/:id
Content-Type: application/json

{
  "is_first_visit": false,
  "favorite_era": "낭만주의"
}
```

## 권한 시스템 활용 예시

### 프론트엔드에서 권한 체크
```javascript
const user = await fetch('/api/users/me').then(r => r.json());

if (user.role === 'admin') {
  // 관리자 전용 UI 표시
  showAdminPanel();
} else if (user.role === 'moderator') {
  // 중간 관리자 UI 표시
  showModeratorPanel();
}

// 첫 방문 체크
if (user.is_first_visit) {
  showOnboarding();
  
  // 온보딩 완료 후
  await fetch(`/api/users/${user.id}`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ is_first_visit: false })
  });
}
```

### 백엔드에서 권한 체크 (추후 구현 가능)
```rust
// 미들웨어나 가드로 권한 체크
#[post("/admin/delete-user/<id>")]
pub async fn admin_delete_user(
    user: AdminGuard,  // role이 'admin'인지 체크
    id: i32
) -> Result<Json<String>, Status> {
    // admin만 접근 가능
}
```

## 권한별 기능 예시

### user (일반 사용자)
- 작곡가/아티스트 조회
- 즐겨찾기 추가/삭제
- 공연 정보 조회
- 프로필 수정

### moderator (중간 관리자)
- user 권한 + 
- 작곡가/아티스트 정보 수정
- 공연 정보 추가/수정
- 부적절한 리뷰 삭제

### admin (관리자)
- moderator 권한 +
- 사용자 권한 변경
- 사용자 삭제
- 시스템 설정 변경

## 주의사항

1. **role 변경은 admin만 가능하도록** API를 별도로 만들어야 함
2. **is_first_visit는 클라이언트에서 자유롭게** 업데이트 가능
3. **기본값은 항상 'user'** - 보안을 위해 권한 상승은 수동으로만
