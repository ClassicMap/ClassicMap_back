// Spotify 웹 플레이어의 트랙 검색 pathfinder 요청(주소·헤더·본문)을 잡아 파일에 쓴다(spotify_search.py 가 부른다).
// 잡은 파일에는 웹 플레이어 토큰이 있으니 커밋하지 않는다. playwright 가 다른 곳에 있으면 PLAYWRIGHT_MODULE 로 준다.
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
  await page.goto('https://open.spotify.com/search/chopin%20piano%20concerto%20op.%2021/tracks', { waitUntil: 'domcontentloaded', timeout: 30000 });
  await page.waitForTimeout(6000);
  fs.writeFileSync(process.argv[2], JSON.stringify(seen, null, 1));
  console.log(seen.map((s) => (s.body ? JSON.parse(s.body).operationName : s.url.slice(0, 120))).join('\n'));
  await browser.close();
})();
