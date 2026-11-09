// Spotify 웹 플레이어가 앨범 페이지에서 보내는 getAlbum 요청(주소·헤더·본문)을 잡아 파일에 쓴다
// (fetch_full_albums.py 가 부른다). 잡은 파일에는 웹 플레이어 토큰이 있으니 커밋하지 않는다.
// playwright 가 다른 곳에 있으면 PLAYWRIGHT_MODULE 로 준다.
const { chromium } = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
const fs = require('fs');
(async () => {
  const browser = await chromium.launch({ channel: 'chrome', headless: true });
  const page = await (await browser.newContext({ locale: 'en-US' })).newPage();
  const seen = [];
  page.on('request', (req) => {
    if (!req.url().includes('pathfinder')) return;
    seen.push({ url: req.url(), method: req.method(), headers: req.headers(), body: req.postData() });
  });
  await page.goto('https://open.spotify.com/album/' + process.argv[2], { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(6000);
  fs.writeFileSync(process.argv[3], JSON.stringify(seen, null, 1));
  await browser.close();
})();
