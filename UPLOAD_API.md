# Image Upload API

## 엔드포인트

### 작곡가 아바타 업로드
POST /api/upload/composer/avatar

### 작곡가 커버 업로드
POST /api/upload/composer/cover

### 아티스트 아바타 업로드
POST /api/upload/artist/avatar

### 아티스트 커버 업로드
POST /api/upload/artist/cover

### 공연 포스터 업로드
POST /api/upload/concert/poster

## 사용법

```bash
# 작곡가 아바타 업로드
curl -X POST \
  -F "file=@/path/to/image.jpg" \
  http://34.60.221.92:1028/api/upload/composer/avatar

# 공연 포스터 업로드
curl -X POST \
  -F "file=@/path/to/poster.jpg" \
  http://34.60.221.92:1028/api/upload/concert/poster

# 응답
{
  "url": "/uploads/composers/avatar/1731239999_image.jpg"
}
```

## 파일 접근

업로드된 파일은 다음 URL로 접근:
```
http://34.60.221.92:1028/uploads/composers/avatar/1731239999_image.jpg
http://34.60.221.92:1028/uploads/composers/cover/1731239999_image.jpg
http://34.60.221.92:1028/uploads/artists/avatar/1731239999_image.jpg
http://34.60.221.92:1028/uploads/artists/cover/1731239999_image.jpg
http://34.60.221.92:1028/uploads/concerts/poster/1731239999_poster.jpg
```

## 지원 포맷
- jpg, jpeg
- png
- webp
- gif

## 폴더 구조
```
static/uploads/
├── composers/
│   ├── avatar/    # 작곡가 아바타
│   └── cover/     # 작곡가 배경
├── artists/
│   ├── avatar/    # 아티스트 아바타
│   └── cover/     # 아티스트 배경
└── concerts/
    └── poster/    # 공연 포스터
```

## 프론트엔드 예시

```javascript
// 이미지 업로드
const uploadImage = async (file, type) => {
  const formData = new FormData();
  formData.append('file', file);
  
  const endpoint = {
    'composer-avatar': '/api/upload/composer/avatar',
    'composer-cover': '/api/upload/composer/cover',
    'artist-avatar': '/api/upload/artist/avatar',
    'artist-cover': '/api/upload/artist/cover',
    'concert-poster': '/api/upload/concert/poster',
  }[type];
  
  const response = await fetch(`http://34.60.221.92:1028${endpoint}`, {
    method: 'POST',
    body: formData
  });
  
  const data = await response.json();
  return `http://34.60.221.92:1028${data.url}`;
};

// 사용
const imageUrl = await uploadImage(file, 'concert-poster');
// DB에 imageUrl 저장
```

