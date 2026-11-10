// 웹 페이지를 WebKit 으로 열어 그림(img, 배경 그림, og:image)을 모으고 큰 가로 그림만 받아 둔다.
// 사용: node page_images.mjs <tsv: key\tpage url> <저장 폴더> <출력 jsonl>
import { createRequire } from 'node:module';
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';

// playwright 가 깔린 node_modules 를 PLAYWRIGHT_MODULES 로 넘긴다(없으면 이 파일 기준으로 찾는다)
const require = createRequire(process.env.PLAYWRIGHT_MODULES ?? import.meta.url);
const { webkit } = require('playwright');

const [input, folder, output] = process.argv.slice(2);
fs.mkdirSync(folder, { recursive: true });
const rows = fs.readFileSync(input, 'utf8').split('\n').filter(Boolean).map((line) => line.split('\t'));
const browser = await webkit.launch();
const context = await browser.newContext({ locale: 'en-US', viewport: { width: 1600, height: 1000 }, ignoreHTTPSErrors: true });
const seen = new Set();

function size(buffer) {
  // JPEG·PNG·WebP 머리에서 크기만 읽는다
  if (buffer[0] === 0x89 && buffer[1] === 0x50) return [buffer.readUInt32BE(16), buffer.readUInt32BE(20)];
  if (buffer.toString('ascii', 0, 4) === 'RIFF' && buffer.toString('ascii', 8, 12) === 'WEBP') {
    const kind = buffer.toString('ascii', 12, 16);
    if (kind === 'VP8X') return [1 + buffer.readUIntLE(24, 3), 1 + buffer.readUIntLE(27, 3)];
    if (kind === 'VP8 ') return [buffer.readUInt16LE(26) & 0x3fff, buffer.readUInt16LE(28) & 0x3fff];
    if (kind === 'VP8L') {
      const bits = buffer.readUInt32LE(21);
      return [1 + (bits & 0x3fff), 1 + ((bits >> 14) & 0x3fff)];
    }
  }
  if (buffer[0] === 0xff && buffer[1] === 0xd8) {
    let offset = 2;
    while (offset < buffer.length) {
      if (buffer[offset] !== 0xff) return null;
      const marker = buffer[offset + 1];
      const length = buffer.readUInt16BE(offset + 2);
      if (marker >= 0xc0 && marker <= 0xcf && ![0xc4, 0xc8, 0xcc].includes(marker)) {
        return [buffer.readUInt16BE(offset + 7), buffer.readUInt16BE(offset + 5)];
      }
      offset += 2 + length;
    }
  }
  return null;
}

for (const [key, url] of rows) {
  const page = await context.newPage();
  let urls = [];
  try {
    await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 45000 });
    await page.waitForTimeout(6000);
    for (let i = 0; i < 6; i += 1) {
      await page.mouse.wheel(0, 1200);
      await page.waitForTimeout(700);
    }
    urls = await page.evaluate(() => {
      const out = [];
      const meta = document.querySelector('meta[property="og:image"], meta[name="og:image"], meta[name="twitter:image"]');
      if (meta?.content) out.push(meta.content);
      for (const img of document.querySelectorAll('img')) {
        if (img.currentSrc) out.push(img.currentSrc);
        for (const part of (img.srcset || '').split(',')) {
          const bit = part.trim().split(/\s+/)[0];
          if (bit) out.push(bit);
        }
      }
      for (const source of document.querySelectorAll('source[srcset]')) {
        for (const part of source.srcset.split(',')) {
          const bit = part.trim().split(/\s+/)[0];
          if (bit) out.push(bit);
        }
      }
      for (const el of document.querySelectorAll('*')) {
        const bg = getComputedStyle(el).backgroundImage;
        const match = bg && bg.match(/url\(["']?([^"')]+)/);
        if (match) out.push(match[1]);
      }
      return out.map((u) => new URL(u, location.href).href);
    });
  } catch (error) {
    console.error('fail', key, url, String(error).slice(0, 100));
  }
  urls = [...new Set(urls)].filter((u) => u.startsWith('http') && !/logo|icon|sprite|favicon|\.svg/i.test(u));
  let kept = 0;
  for (const imageUrl of urls.slice(0, 80)) {
    try {
      const response = await page.request.get(imageUrl, { timeout: 30000 });
      if (!response.ok()) continue;
      const body = await response.body();
      if (body.length < 20000) continue;
      const digest = crypto.createHash('sha1').update(body).digest('hex').slice(0, 12);
      if (seen.has(digest)) continue;
      seen.add(digest);
      const dims = size(body);
      if (!dims) continue;
      const [width, height] = dims;
      if (width < 1000 || width / height < 1.2) continue;
      const file = path.join(folder, `${key}_${digest}.img`);
      fs.writeFileSync(file, body);
      fs.appendFileSync(output, `${JSON.stringify({ key, page: url, url: imageUrl, file, width, height })}\n`);
      kept += 1;
    } catch {
      // 받지 못한 그림
    }
  }
  console.error(key, url.slice(0, 70), 'urls', urls.length, 'kept', kept);
  await page.close();
}
await browser.close();
