# ClassicMap English text translation spec

ClassicMap is a Korean classical-music app (composers, works, performers, side-by-side performance comparisons, classical music in films). We are adding an English version. You translate Korean text fields into English. The English is stored in new `*_en` database columns and shown as-is to English-speaking users.

## Input / output
- Input: a JSONL file. Each line is one record with an `id`, some context fields (English names/titles — use them, do not translate them) and one or more Korean text fields.
- Output: a JSONL file, one line per input record, same order, same `id`. For every Korean text field that is present and non-empty, write `<field>_en`. Skip fields that are null/empty. No other keys besides `id` and the `_en` fields.
  - `facts` (a JSON array of short Korean tags, or a JSON string holding such an array) → `facts_en`: a JSON array of English tags, same length and order.
- Write the file with a script (e.g. a Python heredoc that builds the records and `json.dumps(..., ensure_ascii=False)` each line). The translations themselves are yours — write them by hand into the script; do not call any external translation service or API.

## Fields
| file | Korean fields → English fields | limits |
|---|---|---|
| composers | bio, style, influence | style is a comma-separated keyword list: keep it a comma-separated keyword list |
| artists | bio, style | same |
| awards | award_name | competition/award name + rank, e.g. "제18회 쇼팽 국제 피아노 콩쿠르 1위" → "18th International Chopin Piano Competition, 1st prize" |
| screen_titles | title_ko (only when title_original is empty or not in Latin script) | the official English title of the film/series if one exists; otherwise a faithful translation |
| screen_cues | part_label, scene_note | scene_note ≤ 550 characters |
| pieces | description | |
| sectors | description; and name_ko → name_en ONLY when name_en is empty | |
| notes | headline, note, facts | headline_en ≤ 60 characters |
| pairs | title, note | title_en ≤ 60 characters |

## Style
- Write the way an English-native classical-music editor would: natural, concise, specific. Faithful to the meaning; do not add facts, praise or interpretation that is not in the Korean. Do not drop facts.
- Keep paragraph breaks (`\n`) where the Korean has them.
- Biographies and work descriptions: neutral encyclopedic tone, present/past tense as natural in English.
- Listening notes and comparison notes: they guide the listener ("listen for…", comparisons between performances). Keep them direct and vivid but plain. Korean sentence-final politeness (해요/합니다) has no English equivalent — just write good English.
- Names: use the English names. The glossary `names.tsv` (kind, Korean name, English name) covers performers and composers; when a Korean name appears in the text, write the English name from the glossary. Orchestras and ensembles: use their usual English names (베를린 필 → Berlin Philharmonic, 빈 필 → Vienna Philharmonic, 런던 심포니 → London Symphony Orchestra, 콘세르트허바우 → Concertgebouw Orchestra, 세인트 마틴 인 더 필즈 → Academy of St Martin in the Fields). In short fact tags, the short forms are fine (Berlin Phil, Vienna Phil).
- Work titles: use the standard English title (the record's English title/context is the reference). Nicknames as commonly known in English ("Moonlight", "Emperor", "Revolutionary").
- Music terms: 제시부 exposition, 발전부 development, 재현부 recapitulation, 코다 coda, 주제 theme, 제1주제 first theme, 경과구 transition, 악장 movement, 카덴차 cadenza, 셈여림 dynamics, 템포 tempo, 루바토 rubato, 프레이징 phrasing, 아티큘레이션 articulation, 페달 pedal(ling), 절정 climax, 피아니시모 pianissimo, 포르티시모 fortissimo, 조성 key, 장조/단조 major/minor (E♭ major, C-sharp minor). Italian tempo/expression marks stay in Italian.
- Keep numbers, years, opus/catalogue numbers, keys and quoted Italian markings exactly.
- No markdown, no notes to the reader, no brackets like "[translator's note]".

## Done means
- Every input `id` appears once in the output, in the same order.
- Every non-empty Korean field has its `_en` field; `facts_en` arrays match `facts` length.
- Length limits are met.
- No Korean characters remain in any `_en` value (except where a Korean proper name has no English form — rare; transliterate it instead).
