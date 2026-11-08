import json, glob, re, os, sys
H = re.compile(r"[가-힣]")
FIELDS = {"composers":["bio","style","influence"],"artists":["bio","style"],"awards":["award_name"],"pieces":["description"],
          "sectors":["description","name_ko"],"notes":["headline","note","facts"],"pairs":["title","note"],
          "screen_titles":["title_ko"],"screen_cues":["part_label","scene_note"]}
LIMIT = {"headline_en":60,"title_en":60,"scene_note_en":600}
total=0
for path in sorted(glob.glob("out/*.jsonl")):
    name=os.path.basename(path)[:-6]; kind=name.split("_",1)[1]
    inp=[json.loads(l) for l in open(f"chunks/{name}.jsonl")]
    try: out=[json.loads(l) for l in open(path)]
    except Exception as e: print(name,"PARSE",e); continue
    probs=[]
    if [r["id"] for r in inp]!=[r["id"] for r in out]: probs.append("ids differ")
    for a,b in zip(inp,out):
        for f in FIELDS[kind]:
            ko=a.get(f)
            if f=="name_ko":
                if a.get("name_en"): continue
                en=b.get("name_en")
            elif f=="title_ko":
                orig=a.get("title_original") or ""
                if orig and not re.search(r"[^\x00-\x7fÀ-ɏ‘-”–—·]", orig): continue
                en=b.get("title_ko_en") or b.get("title_en")
            elif f=="facts":
                facts=ko if isinstance(ko,list) else (json.loads(ko) if isinstance(ko,str) and ko else [])
                en=b.get("facts_en")
                if facts and (not isinstance(en,list) or len(en)!=len(facts)): probs.append(f"{a['id']} facts len")
                if isinstance(en,list) and any(H.search(x) for x in en): probs.append(f"{a['id']} facts hangul")
                continue
            else:
                en=b.get(f+"_en")
            if ko and not en: probs.append(f"{a['id']} missing {f}_en")
            if en and H.search(str(en)): probs.append(f"{a['id']} hangul in {f}")
            lim=LIMIT.get(f+"_en")
            if en and lim and len(str(en))>lim: probs.append(f"{a['id']} {f}_en len {len(str(en))}")
    total+=len(out)
    print(f"{name:20} {len(out):4} problems={len(probs)}", probs[:6])
print("records", total)
