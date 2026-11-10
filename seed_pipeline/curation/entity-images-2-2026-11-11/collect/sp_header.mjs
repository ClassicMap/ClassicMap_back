// 스포티파이 아티스트 웹 페이지가 부르는 pathfinder(queryArtistOverview) 응답에서 머리 그림(headerImage)을 꺼낸다.
// 아이디가 없으면 웹 검색(아티스트 탭) 결과 중 이름이 정확히 같은 첫 아티스트를 쓴다.
// 사용: node sp_header.mjs <입력 jsonl: {key, spotifyId?, names:[...]}> <출력 jsonl>
import { createRequire } from 'node:module';
import fs from 'node:fs';

const require = createRequire('/Users/kdh/.agents/skills/playwright-skill/node_modules/');
const { webkit } = require('playwright');

const [input, output] = process.argv.slice(2);
const rows = fs.readFileSync(input, 'utf8').split('\n').filter(Boolean).map((line) => JSON.parse(line));
const done = new Set();
if (fs.existsSync(output)) {
  for (const line of fs.readFileSync(output, 'utf8').split('\n').filter(Boolean)) done.add(JSON.parse(line).key);
}

const norm = (text) => (text || '').normalize('NFKD').replace(/[̀-ͯ]/g, '').toLowerCase().replace(/[^a-z0-9]+/g, '');

function findKey(value, key, found = []) {
  if (value && typeof value === 'object') {
    for (const [k, v] of Object.entries(value)) {
      if (k === key) found.push(v);
      findKey(v, key, found);
    }
  }
  return found;
}

const browser = await webkit.launch();
const context = await browser.newContext({ locale: 'en-US', viewport: { width: 1400, height: 900 } });

async function capture(url, test, waitMs = 20000) {
  const page = await context.newPage();
  let result = null;
  page.on('response', async (response) => {
    if (!response.url().includes('pathfinder')) return;
    try {
      const body = await response.json();
      const value = test(body);
      if (value) result = value;
    } catch {
      // 다른 응답
    }
  });
  try {
    await page.goto(url, { waitUntil: 'domcontentloaded', timeout: 45000 });
    for (let i = 0; i < waitMs / 500 && !result; i += 1) await page.waitForTimeout(500);
  } catch (error) {
    console.error('fail', url, String(error).slice(0, 100));
  }
  await page.close();
  return result;
}

async function searchId(names) {
  const wanted = new Set(names.map(norm));
  for (const name of names.slice(0, 2)) {
    const items = await capture(`https://open.spotify.com/search/${encodeURIComponent(name)}/artists`, (body) => {
      const artists = findKey(body?.data ?? {}, 'artists').flatMap((a) => a?.items ?? []);
      return artists.length ? artists : null;
    }, 15000);
    await new Promise((resolve) => setTimeout(resolve, 1500));
    for (const item of items ?? []) {
      const data = item?.data ?? item;
      const uri = data?.uri ?? '';
      if (uri.startsWith('spotify:artist:') && wanted.has(norm(data?.profile?.name))) {
        return { id: uri.split(':')[2], name: data.profile.name };
      }
    }
  }
  return null;
}

for (const row of rows) {
  if (done.has(row.key)) continue;
  let spotifyId = row.spotifyId;
  let matched = null;
  if (!spotifyId) {
    const found = await searchId(row.names);
    if (found) {
      spotifyId = found.id;
      matched = found.name;
    }
  }
  const record = { key: row.key, spotifyId: spotifyId ?? null, matchedName: matched, name: null, header: null, avatar: null, followers: null };
  if (spotifyId) {
    let overview = null;
    for (let attempt = 0; attempt < 3 && !overview; attempt += 1) {
      overview = await capture(`https://open.spotify.com/artist/${spotifyId}`, (body) => {
        const artist = body?.data?.artistUnion;
        return artist && artist.profile ? artist : null;
      });
      if (!overview) await new Promise((resolve) => setTimeout(resolve, 5000));
    }
    if (overview) {
      record.name = overview.profile?.name ?? null;
      record.followers = overview.stats?.followers ?? null;
      // 머리 그림은 artistUnion.headerImage.data.sources(maxWidth·maxHeight) 에 있다
      const width = (source) => source.maxWidth ?? source.width ?? 0;
      const sources = [...(overview.headerImage?.data?.sources ?? [])];
      sources.sort((a, b) => width(b) - width(a));
      record.header = sources[0]
        ? { url: sources[0].url, width: width(sources[0]), height: sources[0].maxHeight ?? sources[0].height ?? 0 }
        : null;
      const avatars = [...(overview.visuals?.avatarImage?.sources ?? [])];
      avatars.sort((a, b) => width(b) - width(a));
      record.avatar = avatars[0] ?? null;
    } else {
      record.error = 'overview';
    }
  }
  fs.appendFileSync(output, `${JSON.stringify(record)}\n`);
  console.error(row.key, spotifyId, record.name, record.header ? `${record.header.width}x${record.header.height}` : '-');
  await new Promise((resolve) => setTimeout(resolve, 1500));
}
await browser.close();
