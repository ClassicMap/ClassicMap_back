use rocket::{get, http::ContentType};

static FAVICON: &[u8] = include_bytes!("../../static/favicon.ico");

#[get("/favicon.ico")]
pub fn favicon() -> (ContentType, &'static [u8]) {
    (ContentType::new("image", "x-icon"), FAVICON)
}

#[get("/classicmap/delete-account")]
pub fn delete_account() -> (ContentType, &'static str) {
    (ContentType::HTML, r#"<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>클래식맵 - 계정 삭제</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; background: #f5f5f5; color: #333; line-height: 1.6; }
        .container { max-width: 600px; margin: 40px auto; padding: 32px; background: #fff; border-radius: 12px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        h1 { font-size: 24px; margin-bottom: 8px; }
        .subtitle { color: #666; margin-bottom: 24px; }
        h2 { font-size: 18px; margin-top: 24px; margin-bottom: 8px; }
        ul { padding-left: 20px; margin-bottom: 16px; }
        li { margin-bottom: 4px; }
        .info { background: #f0f0f0; padding: 16px; border-radius: 8px; margin-top: 24px; }
        .info p { margin-bottom: 4px; }
        a { color: #1a73e8; }
    </style>
</head>
<body>
    <div class="container">
        <h1>클래식맵 (ClassicMap)</h1>
        <p class="subtitle">개발자: DongHyeon Kang</p>

        <h2>계정 삭제 방법</h2>
        <p>앱 내에서 직접 계정을 삭제할 수 있습니다.</p>
        <ul>
            <li>앱 실행 → 설정 → 계정 삭제</li>
        </ul>

        <h2>삭제되는 데이터</h2>
        <ul>
            <li>계정 정보 (이메일, 프로필)</li>
            <li>평점 및 리뷰 데이터</li>
            <li>즐겨찾기 및 개인 설정</li>
        </ul>

        <h2>보관 기간</h2>
        <p>계정 삭제 요청 시 모든 데이터는 <strong>즉시 삭제</strong>되며, 복구할 수 없습니다.</p>

        <div class="info">
            <p><strong>문의</strong></p>
            <p>이메일: <a href="mailto:kang3171611@naver.com">kang3171611@naver.com</a></p>
        </div>
    </div>
</body>
</html>"#)
}
