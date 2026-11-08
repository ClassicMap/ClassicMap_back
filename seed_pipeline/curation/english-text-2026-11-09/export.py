import json, subprocess, sys
SP = sys.argv[1]
pw = open(f"{SP}/devdb/pw").read().strip()
Q = {
 "composers": "SELECT JSON_OBJECT('id', id, 'name', english_name, 'bio', bio, 'style', style, 'influence', influence) FROM composers WHERE hidden_reason IS NULL AND (COALESCE(bio,'')<>'' OR COALESCE(style,'')<>'' OR COALESCE(influence,'')<>'') ORDER BY id",
 "artists": "SELECT JSON_OBJECT('id', id, 'name', english_name, 'category', category, 'bio', bio, 'style', style) FROM artists WHERE COALESCE(bio,'')<>'' OR COALESCE(style,'')<>'' ORDER BY id",
 "awards": "SELECT JSON_OBJECT('id', aw.id, 'artist', a.english_name, 'year', aw.year, 'award_name', aw.award_name, 'organization', aw.organization) FROM artist_awards aw JOIN artists a ON a.id=aw.artist_id ORDER BY aw.id",
 "pieces": "SELECT JSON_OBJECT('id', p.id, 'composer', c.english_name, 'title_en', p.title_en, 'description', p.description) FROM pieces p JOIN composers c ON c.id=p.composer_id WHERE COALESCE(p.description,'')<>'' AND p.hidden_reason IS NULL ORDER BY p.id",
 "sectors": "SELECT JSON_OBJECT('id', s.id, 'composer', c.english_name, 'piece_title_en', p.title_en, 'name_ko', COALESCE(s.name_ko, s.sector_name), 'name_en', s.name_en, 'description', s.description) FROM performance_sectors s JOIN pieces p ON p.id=s.piece_id JOIN composers c ON c.id=p.composer_id WHERE COALESCE(s.description,'')<>'' OR ((s.name_en IS NULL OR s.name_en='') AND s.editorial_status='PUBLISHED') ORDER BY s.id",
 "notes": "SELECT JSON_OBJECT('id', n.performance_id, 'piece_title_en', p.title_en, 'sector_en', s.name_en, 'headline', n.headline, 'note', n.note, 'facts', n.facts) FROM performance_listening_notes n JOIN performances pf ON pf.id=n.performance_id JOIN performance_sectors s ON s.id=pf.sector_id JOIN pieces p ON p.id=s.piece_id ORDER BY n.performance_id",
 "pairs": "SELECT JSON_OBJECT('id', pr.sector_id, 'piece_title_en', p.title_en, 'sector_en', s.name_en, 'title', pr.title, 'note', pr.note) FROM sector_featured_pairs pr JOIN performance_sectors s ON s.id=pr.sector_id JOIN pieces p ON p.id=s.piece_id ORDER BY pr.sector_id",
 "screen_titles": "SELECT JSON_OBJECT('id', id, 'kind', kind, 'title_ko', title_ko, 'title_original', title_original, 'release_year', release_year, 'country', country_code) FROM screen_titles ORDER BY id",
 "screen_cues": "SELECT JSON_OBJECT('id', c.id, 'title_original', t.title_original, 'title_ko', t.title_ko, 'work_title', c.work_title, 'part_label', c.part_label, 'scene_note', c.scene_note) FROM screen_music_cues c JOIN screen_titles t ON t.id=c.screen_title_id ORDER BY c.id",
}
only = sys.argv[2:]
for name, sql in Q.items():
    if only and name not in only: continue
    out = subprocess.run(["docker","exec","-i","-e",f"MYSQL_PWD={pw}","cm-dev-mysql","mysql","-uroot","--default-character-set=utf8mb4","-B","-N","-r","classicmap_combined","-e",sql], capture_output=True, text=True)
    if out.returncode: print(name, out.stderr.strip()); continue
    rows = [json.loads(l) for l in out.stdout.splitlines() if l.strip()]
    with open(f"{SP}/en-text/in/{name}.jsonl","w",encoding="utf-8") as f:
        for r in rows: f.write(json.dumps(r, ensure_ascii=False)+"\n")
    chars = sum(len(str(v)) for r in rows for k,v in r.items() if k not in ('id',))
    print(name, len(rows), chars)
