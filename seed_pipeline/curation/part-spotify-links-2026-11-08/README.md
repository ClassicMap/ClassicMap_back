# 세트 안 곡 Spotify 트랙 링크 (2026-11-08)

`piece_parts.spotify_url`(migration `202611082202`)을 채운 자료입니다. 마이그레이션은 `202611082204_fill_piece_part_spotify_url.sql`입니다.

- 앨범: 세트마다 고른 Spotify 앨범(`../piece-album-links-2026-11-08/spotify-picks.jsonl`)입니다. 앨범을 고르는 방법은 그 폴더 README에 있습니다.
- 앨범 트랙 목록: 임베드 페이지(`open.spotify.com/embed/album/<id>`)의 `__NEXT_DATA__` → `entity.trackList`(앨범 순서)입니다.
- 매칭: Apple Music과 같은 `../part-apple-links-2026-11-08/match.py`를 `--column spotify_url`로 씁니다. 규칙은 number·range·movement·name·tail·order·album입니다.
- 결과: `matches.jsonl`(곡마다 트랙·규칙). 세트 5,036개, 곡 25,074개 중 17,750곡입니다.

다시 만들 때(작업 폴더는 repo 밖에 둡니다):

```bash
cd seed_pipeline
D=curation/piece-album-links-2026-11-08
uv run python $D/build_links.py spotify $W/picks-final.jsonl $W/all_parts.tsv $W \
  ../migrations/<번호>_fill_piece_spotify_album_links.sql piece-album-links-2026-11-08 $W/sets.tsv
uv run python curation/part-apple-links-2026-11-08/match.py --parts $W/spotify_parts.tsv \
  --raw $W/raw --out curation/part-spotify-links-2026-11-08 --name matches.jsonl \
  --column spotify_url --source-dir part-spotify-links-2026-11-08 \
  --migration ../migrations/<번호>_fill_piece_part_spotify_url.sql
```
