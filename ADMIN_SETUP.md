# 관리자 계정 설정 가이드

## .env 파일 설정

관리자와 중간관리자 이메일을 환경변수로 설정합니다.

```env
# 관리자 이메일 (여러 명은 쉼표로 구분)
ADMIN_EMAILS=admin@example.com,boss@company.com

# 중간 관리자 이메일 (여러 명은 쉼표로 구분)
MODERATOR_EMAILS=moderator@example.com,manager@company.com
```

## 작동 방식

### 1. 회원가입 시 자동 권한 부여

Clerk를 통해 회원가입하면:
1. Webhook이 백엔드로 `user.created` 이벤트 전송
2. 백엔드가 이메일 체크:
   - `ADMIN_EMAILS`에 있으면 → **admin** 권한
   - `MODERATOR_EMAILS`에 있으면 → **moderator** 권한  
   - 둘 다 아니면 → **user** 권한
3. DB에 해당 권한으로 저장

### 2. 로그 출력

관리자 계정으로 가입하면:
```
2025-11-10 13:45:23 [USER] Admin account detected: admin@example.com
2025-11-10 13:45:23 [WEBHOOK] ✓ User created with ID: 1
```

중간 관리자 계정:
```
2025-11-10 13:46:15 [USER] Moderator account detected: moderator@example.com
2025-11-10 13:46:15 [WEBHOOK] ✓ User created with ID: 2
```

## 예시

### .env 설정
```env
ADMIN_EMAILS=kang1027@gmail.com,admin@classicmap.com
MODERATOR_EMAILS=mod1@classicmap.com,mod2@classicmap.com
```

### 테스트
1. `kang1027@gmail.com`으로 Clerk 가입
2. Webhook이 트리거됨
3. 로그 확인:
```
[USER] Admin account detected: kang1027@gmail.com
[WEBHOOK] ✓ User created with ID: 1
```
4. DB 확인:
```sql
SELECT * FROM users WHERE email = 'kang1027@gmail.com';
-- role: 'admin'
```

## 주의사항

### ✅ DO
- .env 파일은 절대 Git에 커밋하지 말 것 (.gitignore에 포함)
- 관리자 이메일은 신중하게 관리
- 배포 시 서버의 .env에도 동일하게 설정

### ❌ DON'T
- 코드에 이메일 하드코딩 금지
- .env 파일을 공개 저장소에 업로드 금지
- 관리자 권한 남용 금지

## 권한 변경

### 방법 1: .env 수정 후 재가입
1. .env에서 이메일 추가/제거
2. 서버 재시작
3. 해당 이메일로 재가입 (기존 계정 삭제 후)

### 방법 2: DB에서 직접 변경 (권장)
```sql
-- admin으로 변경
UPDATE users SET role = 'admin' WHERE email = 'someone@example.com';

-- moderator로 변경
UPDATE users SET role = 'moderator' WHERE email = 'another@example.com';

-- 다시 user로 변경
UPDATE users SET role = 'user' WHERE email = 'demote@example.com';
```

## 배포 시

### 개발 환경 (.env)
```env
ADMIN_EMAILS=dev@localhost.com
MODERATOR_EMAILS=test@localhost.com
```

### 프로덕션 환경 (서버 .env)
```env
ADMIN_EMAILS=ceo@company.com,cto@company.com
MODERATOR_EMAILS=manager1@company.com,manager2@company.com
```

## API 응답 예시

### Admin으로 가입한 경우
```json
{
  "id": 1,
  "clerk_id": "user_xxx",
  "email": "admin@example.com",
  "role": "admin",  // 👈 자동으로 admin
  "is_first_visit": true,
  "favorite_era": null
}
```

### 일반 유저
```json
{
  "id": 2,
  "clerk_id": "user_yyy",
  "email": "normal@example.com",
  "role": "user",  // 👈 기본값 user
  "is_first_visit": true,
  "favorite_era": null
}
```
