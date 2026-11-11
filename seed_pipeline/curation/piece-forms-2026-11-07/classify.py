# ruff: noqa: E501 — 규칙 표(정규식)는 한 줄로 두어야 읽기 쉽다.
"""작품마다 갈래(장르 7종)와 형식(form_key)을 규칙으로 붙인다.

사람·에이전트 판단 없이 제목(우리말·원어)과 작품번호, MusicBrainz 작품 유형만 본다.
장르 기준은 `../piece-genres-2026-11-07/README.md`(원곡 편성 기준)와 같고, 거기서 손으로 붙인
비교 작품 257곡의 장르는 그대로 두고 형식만 그 장르 안에서 고른다. 못 정한 작품은 갈래·형식이
모두 없고 화면에서 '기타'로 보인다.

사용(seed_pipeline 에서):
    uv run python <이 파일> --input classify_input.tsv \\
        --genres ../piece-genres-2026-11-07/genres.jsonl --out classes.jsonl
"""

import argparse
import csv
import json
import re
from collections import Counter
from dataclasses import dataclass

csv.field_size_limit(10_000_000)

# 형식 → 갈래. 마이그레이션 202611072101 의 piece_forms 와 같아야 한다.
FORM_GENRE: dict[str, str] = {
    "symphony": "symphony",
    "sinfonia": "symphony",
    "symphony_other": "symphony",
    "piano_concerto": "concerto",
    "violin_concerto": "concerto",
    "cello_concerto": "concerto",
    "wind_concerto": "concerto",
    "other_concerto": "concerto",
    "concerto_grosso": "concerto",
    "concertante": "concerto",
    "concerto_other": "concerto",
    "sonata": "piano",
    "etude": "piano",
    "prelude_fugue": "piano",
    "ballade": "piano",
    "scherzo": "piano",
    "nocturne": "piano",
    "impromptu": "piano",
    "fantasia": "piano",
    "character": "piano",
    "mazurka": "piano",
    "polonaise": "piano",
    "waltz": "piano",
    "dance": "piano",
    "variations": "piano",
    "rondo": "piano",
    "keyboard_suite": "piano",
    "four_hands": "piano",
    "organ": "piano",
    "piano_other": "piano",
    "string_quartet": "chamber",
    "string_ensemble": "chamber",
    "piano_chamber": "chamber",
    "duo_sonata": "chamber",
    "wind_chamber": "chamber",
    "solo": "chamber",
    "chamber_other": "chamber",
    "overture": "orchestral",
    "symphonic_poem": "orchestral",
    "orch_suite": "orchestral",
    "serenade": "orchestral",
    "dance_march": "orchestral",
    "incidental": "orchestral",
    "orchestral_other": "orchestral",
    "opera": "stage",
    "operetta": "stage",
    "ballet": "stage",
    "stage_excerpt": "stage",
    "stage_other": "stage",
    "song": "vocal",
    "concert_aria": "vocal",
    "mass_requiem": "vocal",
    "oratorio_passion": "vocal",
    "cantata": "vocal",
    "sacred": "vocal",
    "choral": "vocal",
    "folk": "vocal",
    "vocal_other": "vocal",
}
OTHER_FORM = {genre: f"{genre}_other" for genre in set(FORM_GENRE.values())}
OTHER_FORM["concerto"] = "concerto_other"

# 무곡을 관현악으로 쓴 작곡가: 요한 슈트라우스 1·2세, 모차르트·하이든의 무곡 묶음
ORCHESTRAL_DANCE_COMPOSERS = {42, 54, 14, 16}
STRAUSS = {42, 54}
BACH = 4
# 작품 대부분이 피아노곡인 작곡가: 못 나눈 곡과 무곡은 피아노로 본다(쇼팽)
PIANO_COMPOSERS = {28}

# 제목만으로 못 가리는 작품(편성이 제목에 없음). 작품 id → 형식
OVERRIDES: dict[int, str] = {
    26061: "concertante",  # 쇼팽 「라 치 다렘 라 마노」 변주곡 Op. 2 (피아노와 관현악)
    26071: "concertante",  # 쇼팽 폴란드 민요에 의한 환상곡 Op. 13
    26072: "concertante",  # 쇼팽 크라코비아크풍 론도 Op. 14
    26036: "concertante",  # 쇼팽 안단테 스피아나토와 화려한 대폴로네즈 Op. 22
    26062: "chamber_other",  # 쇼팽 서주와 화려한 폴로네즈 Op. 3 (첼로와 피아노)
    26141: "chamber_other",  # 쇼팽 「악마 로베르」 주제에 의한 협주풍 대이중주 (첼로와 피아노)
    # 2026-11-11 편성 확인(../piece-genre-fixes-2026-11-11/README.md)
    27524: "sonata",  # 슈만 피아노 소나타 3번 「관현악 없는 협주곡」
    29149: "other_concerto",  # 비발디 바이올린과 메아리 바이올린 협주곡(독주 둘)
    17523: "piano_concerto",  # 카월 Concerto Piccolo(피콜로는 악기가 아님)
    26732: "chamber_other",  # 베토벤 「마술피리」 변주곡 Op. 66 (첼로와 피아노)
    26842: "chamber_other",  # 베토벤 「마술피리」 변주곡 WoO 46 (첼로와 피아노)
    32077: "solo",  # 파가니니 「Nel cor più non mi sento」 변주곡 MS 44 (무반주 바이올린)
    1320: "concertante",  # 생상스 바이올린 로망스 Op. 48 (바이올린과 관현악)
    2205: "concertante",  # 생상스 호른 로망스 Op. 67 (호른과 관현악)
    32489: "concertante",  # 생상스 플루트 로망스 Op. 37 (플루트와 관현악)
    32490: "concertante",  # 생상스 호른 로망스 Op. 36 (호른과 관현악)
    32500: "concertante",  # 생상스 알레그로 아파시오나토 Op. 43 (첼로와 관현악)
    31435: "concertante",  # 림스키코르사코프 클라리넷 콘체르트슈튀크 (클라리넷과 군악대)
    32093: "concertante",  # 파가니니 그랑 비올라 소나타 (비올라와 관현악)
    26229: "concertante",  # 모차르트 콘체르토네 K. 190 (바이올린 둘과 관현악)
    18794: "concertante",  # 카월 Piece for Piano with Strings
    2005: "chamber_other",  # 케이지 Sonata for Two Voices (두 성부 = 두 악기)
    10628: "orchestral_other",  # 홀스트 2개의 무언가 Op. 22 (소관현악)
    11338: "song",  # 프로코피예프 5개의 무언가 Op. 35 (목소리와 피아노, 가사 없는 노래)
    11651: "song",  # 비제 「가사 없는 멜로디」 WD 110 (소프라노 둘의 보칼리즈, MB)
    8352: "chamber_other",  # 홀스트 Lied ohne Worte H. 51 (바이올린과 피아노, MB)
    18214: "song",  # 웰처 Songs Without Words (편성 확인 못 함, 원래 값 유지)
    32450: "waltz",  # 라벨 고귀하고 감상적인 왈츠 원곡(피아노, MB 'for piano')
    32386: "four_hands",  # 드뷔시 관현악 모음곡 1번의 피아노 연탄판
    32545: "prelude_fugue",  # 생상스 Fugue et chœur (편성 확인 못 함, 원래 값 유지)
    7532: "song",  # 로타 Works for Harp(영화음악 하프 편곡, 영화 쪽에서 다룸)
    10310: "orch_suite",  # 로타 Works for Harp 중 「La Dolce Vita」(영화음악, 영화 쪽에서 다룸)
    17629: "orchestral_other",  # 오도넬 게임 음악(영화·게임 쪽에서 다룸)
    1327: "wind_chamber",  # 번스타인 Dance Suite (금관 5중주)
    2077: "variations",  # 번스타인 Touches (피아노 독주)
    2269: "vocal_other",  # 하차투리안 조국의 발라드 (베이스 독창과 관현악)
    7531: "orch_suite",  # 홀스트 Suite de ballet Op. 10 (연주회용 관현악 모음곡)
    8147: "variations",  # 글래스 12 Pieces for a Ballet (편성 확인 못 함, 원래 값 유지)
    10881: "variations",  # 같은 곡집
    9501: "waltz",  # 마스네 Valse folle (피아노)
    10747: "overture",  # 홀스트 A Fugal Overture (관현악)
    11184: "chamber_other",  # 본 윌리엄스 Suite de Ballet (플루트와 피아노)
    12262: "piano_other",  # C.P.E. 바흐 「전문가와 애호가를 위한」 소나타·론도 곡집
    12321: "piano_other",
    12584: "fantasia",
    13083: "fantasia",
    13416: "fantasia",
    17702: "orch_suite",  # 아서 벤저민 Two Jamaican Pieces (관현악판)
    17828: "organ",  # 프란츠 슈미트 Fantasie und Fuge D장조 (오르간)
    18238: "organ",  # 프란츠 슈미트 「Königsfanfaren」 변주곡과 푸가 (오르간)
    17845: "mazurka",  # 탈렉시 Bella Aminta polka-mazurka (피아노)
    1344: "vocal_other",  # 베를리오즈 파우스트의 겁벌 중 이중창
    1001: "vocal_other",  # 베를리오즈 파우스트의 겁벌 중 메피스토펠레스의 세레나데(노래)
    1406: "solo",  # 케이지 Chorals (바이올린 독주)
    7448: "character",  # 사티 12개의 작은 코랄 (피아노)
    2307: "choral",  # 브리튼 옛 프랑스 캐럴에 의한 코랄 (무반주 합창)
    8059: "choral",  # 아이브스 Harvest Home Chorales (합창)
    2132: "organ",  # 베를리오즈 Sérénade agreste à la madone (오르간·하모니움)
    2625: "sacred",  # 엘가 베토벤 교향곡 주제에 의한 크레도 (합창과 오르간)
    1533: "four_hands",  # 브리튼 2대의 피아노를 위한 소품
    1721: "stage_excerpt",  # 거슈윈 뮤지컬 <Lady Be Good> 서곡
    1789: "orchestral_other",  # 케이지 Quartets I-VIII (관현악)
    9558: "character",  # 파야 안달루시아 세레나데 (피아노)
    13025: "dance",  # 안나 막달레나 노트 행진곡 BWV Anh. 127 (건반)
    19931: "string_quartet",  # 수크 「성 바츨라프」 코랄에 의한 명상곡 Op. 35a (현악 4중주)
    16364: "solo",  # 로드리고 알람브라에 바치는 시를 위한 전주곡 (기타)
    33324: "concertante",  # 로드리고 어느 귀족을 위한 환상곡 (기타와 관현악)
    32082: "concertante",  # 파가니니 Maestosa sonata sentimentale (바이올린과 관현악)
    8599: "concertante",  # 사라사테 「파우스트」 환상곡 Op. 13 (바이올린과 관현악)
    8626: "concertante",  # 사라사테 「마술피리」 환상곡 Op. 54 (바이올린과 관현악)
    263: "concertante",  # 사라사테 카르멘 환상곡 Op. 25 (바이올린과 관현악)
    25698: "orchestral_other",  # 게오르크 슈만 코랄에 의한 교향적 변주곡 (관현악)
    18170: "song",  # 멀리 Duet no. 1 「Chorale Pointing Downwards」 (편성 확인 못 함, 원래 값 유지)
    8292: "chamber_other",  # 글래스 Prelude to Endgame (팀파니와 콘트라베이스)
    16779: "solo",  # 소르 하르폴리르를 위한 장송 행진곡
    17644: "solo",  # 소르 「신데렐라」 행진곡 Op. 15c (기타 편곡판)
    24884: "chamber_other",  # 쿠프랭 Pièces de violes (비올과 통주저음)
    33164: "piano_concerto",  # 풀랑크 전원 협주곡 (하프시코드와 관현악)
    7573: "solo",  # 빌라로부스 5개의 전주곡 W 419 (기타)
    2168: "chamber_other",  # 브리튼 Timpani Piece for Jimmy (팀파니와 피아노)
    # 2026-11-11 공개 카드·대표곡 전수 확인: 제목 규칙이 못 붙였거나 틀리게 붙인 작품
    17: "opera",  # 몬테베르디 오르페오
    19: "choral",  # 몬테베르디 님프의 탄식 (마드리갈)
    20: "opera",  # 몬테베르디 포페아의 대관
    22: "orch_suite",  # 헨델 수상 음악
    23: "orch_suite",  # 헨델 왕궁의 불꽃놀이
    29: "other_concerto",  # 비발디 조화의 영감 (협주곡집)
    36: "opera",  # 퍼셀 세미 오페라 요정 여왕
    37: "sacred",  # 퍼셀 메리 여왕의 장례식 음악
    52: "orch_suite",  # 텔레만 타펠무지크 (관현악 모음곡·실내악·협주곡 묶음)
    55: "orch_suite",  # 텔레만 돈키호테 풍자극 (관현악 모음곡)
    114: "etude",  # 클레멘티 그라두스 아드 파르나숨
    203: "stage_excerpt",  # 림스키코르사코프 왕벌의 비행 (오페라 발췌)
    204: "orchestral_other",  # 림스키코르사코프 스페인 기상곡
    252: "chamber_other",  # 생상스 동물의 사육제 (두 피아노와 소편성 앙상블)
    314: "song",  # 쇤베르크 달에 홀린 피에로 (낭송 성부와 앙상블)
    315: "vocal_other",  # 쇤베르크 바르샤바의 생존자 (낭송·남성 합창·관현악)
    324: "orchestral_other",  # 프로코피예프 피터와 늑대 (해설과 관현악)
    340: "song",  # 안익태 애국가 (국가, 종교곡 아님)
    361: "piano_other",  # 메시앙 아기 예수에 대한 20개의 시선 (피아노)
    656: "piano_other",  # 같은 곡(관현악 모음곡으로 잘못 붙음)
    363: "piano_other",  # 메시앙 새의 카탈로그 (피아노)
    550: "orchestral_other",  # 엘가 에니그마 변주곡 (관현악)
    645: "orchestral_other",  # 브람스 하이든 주제에 의한 변주곡 Op. 56a (관현악)
    863: "concertante",  # 브루흐 스코틀랜드 환상곡 (바이올린과 관현악)
    1096: "choral",  # 하차투리안 아르메니아 공화국 국가 (합창과 관현악)
    1105: "opera",  # 브리튼 Curlew River (교회 우화극)
    1476: "opera",  # 슈토크하우젠 LICHT (오페라 연작)
    1746: "song",  # 홀스트 I Vow to Thee, My Country
    2849: "keyboard_suite",  # 라벨 밤의 가스파르 (피아노)
    8876: "keyboard_suite",  # 드뷔시 베르가마스크 모음곡 (피아노)
    7443: "waltz",  # 드뷔시 렌토보다 느리게 (피아노 왈츠)
    7542: "character",  # 드뷔시 기쁨의 섬 (피아노)
    7598: "concertante",  # 파야 스페인 정원의 밤 (피아노와 관현악)
    8179: "chamber_other",  # 사티 가구 음악 (소편성 앙상블)
    8723: "chamber_other",  # 베베른 협주곡 Op. 24 (아홉 악기, 독주 없음)
    10414: "orchestral_other",  # 야나체크 타라스 불바 (관현악 랩소디)
    10942: "character",  # 사티 그노시엔 (피아노)
    11344: "vocal_other",  # 브람스 알토 랩소디 (알토·남성 합창·관현악)
    11355: "four_hands",  # 브람스 헝가리 무곡 WoO 1 원곡 (피아노 연탄)
    11526: "sacred",  # 포레 장 라신의 찬가 (합창)
    12014: "symphony",  # C.P.E. 바흐 6개의 교향곡 Wq. 182
    23086: "orch_suite",  # 리환즈 춘절 모음곡 (관현악)
    26028: "orchestral_other",  # 리게티 아트모스페르 (관현악)
    26544: "orchestral_other",  # 모차르트 프리메이슨 장송 음악
    26783: "variations",  # 베토벤 디아벨리 변주곡
    26796: "string_quartet",  # 베토벤 대푸가 Op. 133 (현악 4중주)
    27537: "character",  # 슈만 3개의 로망스 Op. 28 (피아노)
    27596: "song",  # 슈만 6개의 시와 레퀴엠 Op. 90 (목소리와 피아노)
    27984: "concertante",  # 리스트 죽음의 무도 (피아노와 관현악)
    28106: "waltz",  # 리스트 잊힌 왈츠 (피아노)
    28264: "symphonic_poem",  # 차이콥스키 프란체스카 다 리미니 (관현악)
    28265: "concertante",  # 차이콥스키 로코코 변주곡 (첼로와 관현악)
    28276: "orchestral_other",  # 차이콥스키 이탈리아 기상곡
    28434: "stage_other",  # 헨델 아시스와 갈라테아 (가면극)
    28555: "concert_aria",  # 헨델 9개의 독일 아리아
    28592: "sacred",  # 헨델 대관식 찬가
    29933: "orchestral_other",  # 바그너 지크프리트 목가
    30979: "symphonic_poem",  # 스메타나 나의 조국
    31377: "character",  # 드보르자크 유모레스크 Op. 101 (피아노)
    31851: "stage_other",  # 스트라빈스키 여우 (부를레스크)
    31862: "stage_other",  # 스트라빈스키 병사의 이야기 (음악극)
    32317: "duo_sonata",  # 슈베르트 아르페지오네 소나타
    32348: "four_hands",  # 브람스 16개의 왈츠 Op. 39 원곡 (피아노 연탄)
    32403: "solo",  # 드뷔시 시링크스 (무반주 플루트)
    32731: "cantata",  # 쇼스타코비치 반형식주의 라요크
    32922: "choral",  # 브리튼 A Ceremony of Carols (고음 합창과 하프)
    32983: "character",  # 사티 짐노페디 (피아노)
    33052: "chamber_other",  # 엘가 사랑의 인사 원곡 (바이올린과 피아노)
    33266: "mass_requiem",  # 야나체크 글라골 미사
    33346: "keyboard_suite",  # 알베니스 이베리아 (피아노)
    258: "concertante",  # 브루흐 스코틀랜드 환상곡 (바이올린과 관현악)
    267: "orchestral_other",  # 엘가 수수께끼 변주곡 (관현악)
    18402: "chamber_other",  # 수크 발라드와 세레나데 Op. 3 (첼로와 피아노)
    1582: "song",  # 브리튼 녹턴 Op. 60 (테너와 관현악 연가곡)
    32874: "duo_sonata",  # 보케리니 소나타 6번 C장조 G. 6 (첼로 소나타, 중복 정리 마이그레이션 0501 이 바꿈)
    12256: "chamber_other",  # C.P.E. 바흐 플루트와 바이올린 2중주 Wq. 140 (같은 0501 이 바꿈)
}
# 규칙이 갈래를 붙이지만 편성을 확인하지 못해 비워 두는 작품
UNDECIDED: set[int] = {
    10320,  # 로타 Works for Harp 중 「말괄량이 길들이기」 서곡(영화음악 하프 편곡)
    33681,  # 로타 Works for Harp(영화음악 하프 편곡 묶음)
    9762,  # 글래스 「A Brief History of Time」(다큐멘터리 영화음악)
    1301,  # 피아졸라 Orchestre Du Theatre(무슨 곡인지 확인 못 함)
    18749,  # 카베손 Obras de musica para tecla, arpa y vihuela(건반·하프·비우엘라 곡집)
    513,  # 케이지 Four Dances (편성 확인 못 함)
    1947,  # 피아졸라 Preludio 9 (편성 확인 못 함)
    2236,  # 피아졸라 Preludio 1953 (편성 확인 못 함)
    2310,  # 피아졸라 Cinco piezas (편성 확인 못 함)
    2547,  # 피아졸라 Tres piezas breves (편성 확인 못 함)
    9053,  # 사라사테 「로미오와 줄리엣」 환상곡 (반주 확인 못 함)
    25896,  # 쾨클랭 Choral en fa mineur Op. 90b (편성 확인 못 함)
    24048,  # 쾨클랭 Quelques chorals pour des fêtes populaires Op. 153 (편성 확인 못 함)
    33261,  # 쾨클랭 Choral sur le nom de Fauré Op. 73bis (편성 확인 못 함)
    # 갈래가 없던 작품 중 제목이 한 낱말뿐이라 편성을 못 가리는 것(피아노 규칙이 붙지만 관현악·성악일 수 있음)
    33421,
    33428,
    33443,
    33470,
    25891,
    33543,
    17034,
    16374,
    16835,
    33556,
    33575,
    19412,
    9667,  # 글래스 Dance Nos. 1-5 (앙상블·오르간판이 섞임)
    8066,  # 빌라로부스 전주곡 2번 Op. 20 (편성 확인 못 함)
}
# 기타 작곡가: 피아노 형식·세레나데로 읽힌 곡은 기타 독주다(디베르티멘토·소품·전주곡·연습곡)
GUITAR_COMPOSERS = {75, 239, 204, 449}  # 타레가, 소르, 브라우어, 요베트
# 바이올린 작곡가: 피아노 갈래로 읽힌 곡은 바이올린과 피아노 곡이다
VIOLIN_COMPOSERS = {63, 503, 74}  # 사라사테, 크라이슬러, 비에니아프스키
# 파가니니: 바이올린 독주·바이올린과 관현악·바이올린과 기타·기타 독주가 섞여 제목만으로 못 가린다
PAGANINI = {35}
# 피아노·기타 곡이 섞여 제목만으로 편성을 못 가리는 작곡가: 피아노 형식·세레나데·무곡으로 읽히면 비워 둔다
MIXED_KEYBOARD_GUITAR_COMPOSERS = {341}  # 로드리고
# 피아노 곡이 대부분인 작곡가: 세레나데·민속 무곡은 피아노 곡이다
PIANO_DANCE_COMPOSERS = {66}  # 알베니스

STAGE_PREFIX = re.compile(
    r"^(오페라|오페레타|징슈필|뮤지컬|사르수엘라|발레|부수음악|극음악)\s*<([^>]+)>"
)
BRACKET_NAME = re.compile(r"<([^>]+)>")
# 「무언가(Lieder ohne Worte)」·「가사 없는 로망스」는 노래가 아니라 기악 소품이다
WORDLESS = re.compile(r"무언가|가사 없는|ohne worte|without words|sans paroles|senza parole", re.I)
# 영화·드라마·게임 음악은 일곱 갈래 밖이라 규칙으로 갈래를 붙이지 않는다
FILM = re.compile(
    r"^영화음악|^영화 음악|^영화 <|사운드트랙|\b(soundtrack|original score|motion picture|film scores?)\b",
    re.I,
)


@dataclass(frozen=True)
class Row:
    piece_id: int
    composer_id: int
    title: str
    title_en: str
    work_type: str
    catalogue: str
    parts: int


def norm(value: str) -> str:
    return "" if value == "NULL" else value


def bwv_form(number: int, title: str) -> str | None:
    """바흐 BWV 번호대(장르순 목록)로 형식을 정한다."""
    if 1 <= number <= 224:
        return "cantata"
    if 225 <= number <= 231:
        return "sacred"
    if 232 <= number <= 243:
        return "mass_requiem" if number <= 236 or number == 242 else "sacred"
    if 244 <= number <= 249:
        return "oratorio_passion"
    if 250 <= number <= 524:
        return "song" if number >= 439 else "sacred"
    if 525 <= number <= 771:
        return "organ"
    if 772 <= number <= 994:
        if 846 <= number <= 893 or "푸가" in title or "전주곡" in title or "토카타" in title:
            return "prelude_fugue"
        if re.search(r"모음곡|파르티타|서곡", title) or 806 <= number <= 831:
            return "keyboard_suite"
        if number == 988 or "변주" in title:
            return "variations"
        return "piano_other"
    if 995 <= number <= 1013:
        return "solo"
    if 1014 <= number <= 1040:
        return "duo_sonata" if "소나타" in title or "sonata" in title.lower() else "chamber_other"
    if 1046 <= number <= 1051:
        return "concerto_grosso"
    if 1041 <= number <= 1065:
        if "바이올린" in title:
            return "violin_concerto"
        if re.search(r"하프시코드|쳄발로|클라비어|건반", title):
            return "piano_concerto"
        return "other_concerto"
    if 1066 <= number <= 1071:
        return "orch_suite"
    if number == 1079:
        return "chamber_other"
    if number == 1080:
        return "prelude_fugue"
    return None


# 제목에 적힌 편성. 피아노 형식 규칙(전주곡·연습곡·소품·변주곡·모음곡 등)은 이름만 보고 붙이므로,
# 편성이 건반이 아니라고 적혀 있으면 그 규칙보다 먼저 편성으로 갈래를 정한다(2026-11-11).
# 악기 이름은 편성을 적는 자리에서만 읽는다: 「for/pour/für/para/per …」 뒤, 「… solo」, 우리말 「…를 위한」
# 「(바이올린과 피아노)」 「첼로 로망스」 꼴. 「하프너」「포스트호른」「마술피리」「My Guitar…」 같은
# 별명·노래 제목은 편성이 아니다.
SCORING_PHRASE = re.compile(
    r"\b(for|für|pour|para|per|avec|mit|con)\s+([^|:\"“”«»<>()\[\]]*)", re.I
)
INSTRUMENTS: dict[str, str] = {
    "violin": r"violin|violon\b|violine|violino|geige",
    "viola": r"viola\b(?! da gamba)|bratsche|\balto\b",
    "cello": r"cello|violoncell|violonchelo",
    "bass": r"double bass|contrabass|kontrabass|contrebasse",
    "gamba": r"viola da gamba|gambe?\b",
    "flute": r"flute|flûte|flöte|flauta|flauto",
    "oboe": r"oboe|hautbois|cor anglais|english horn|oboe d'amore|hautbois d'amour",
    "clarinet": r"clarinet|clarinette|klarinette|clarinetto",
    "bassoon": r"bassoon|basson|fagott",
    "saxophone": r"saxophon",
    "recorder": r"recorder|blockflöte",
    "horn": r"(?<!english )(?<!posthorn)\bhorns?\b|\bcors?\b(?! anglais)|\bcorno\b",
    "trumpet": r"trumpet|trompet",
    "trombone": r"trombone|posaune",
    "tuba": r"\btuba\b",
    "harp": r"\bharps?\b|\bharpe\b|\bharfe\b|\barpa\b",
    "guitar": r"guitar|guitare|gitarre|guitarra|chitarra",
    "mandolin": r"mandolin|amandorlino",
    "lute": r"\blute\b|\blaute\b|\bluth\b",
    "kantele": r"kantele",
    "percussion": r"percussion|marimba|vibraphone|timpani|drums|cymbals",
    "accordion": r"bandone[oó]n|accordion",
    "glass_harmonica": r"glass harmonica",
}
FAMILY: dict[str, str] = {
    "violin": "bowed",
    "viola": "bowed",
    "cello": "bowed",
    "bass": "bowed",
    "gamba": "bowed",
    "flute": "wind",
    "oboe": "wind",
    "clarinet": "wind",
    "bassoon": "wind",
    "saxophone": "wind",
    "recorder": "wind",
    "horn": "brass",
    "trumpet": "brass",
    "trombone": "brass",
    "tuba": "brass",
    "harp": "plucked",
    "guitar": "plucked",
    "mandolin": "plucked",
    "lute": "plucked",
    "kantele": "plucked",
    "percussion": "percussion",
    "accordion": "other",
    "glass_harmonica": "other",
}
KO_INSTRUMENTS: dict[str, str] = {
    "violin": "바이올린",
    "viola": "비올라(?! 다 감바)",
    "cello": "첼로",
    "bass": "콘트라베이스|더블베이스",
    "gamba": "비올라 다 감바",
    "flute": "플루트|피콜로",
    "oboe": "오보에|잉글리시 호른",
    "clarinet": "클라리넷",
    "bassoon": "바순",
    "saxophone": "색소폰",
    "recorder": "리코더",
    "horn": "(?<!잉글리시 )호른",
    "trumpet": "트럼펫",
    "trombone": "트롬본",
    "tuba": "튜바",
    "harp": "하프(?!시코드)",
    "mandolin": "만돌린",
    "lute": "류트",
    "kantele": "칸텔레",
    "percussion": "타악기|마림바|비브라폰",
    "accordion": "반도네온|아코디언",
    "glass_harmonica": "글라스 하모니카",
}
KO_AFTER = (
    r"(?=를|을|와|과|,|\)| 독주| 솔로| 소품| 로망스| 소나티나| 소나타| 연습곡| 엘레지| 모음곡| 자장가| 가보트|"
    r" 카바티나| 즉흥곡| 환상곡| 변주곡| 론도| 왈츠| 2중주| 이중주| 랩소디| 전주곡| 협주곡)"
)
KO_GUITAR = re.compile(
    r"(?:^|[\s(<,])기타(?=를|을|와|과|,|\)| 독주| 솔로| 연습곡| 전주곡| 소나타| 소나티나| 협주곡| 모음곡| [2-5]중주)"
)
EN_FORM_AFTER = r"\s+(solo|alone|seule?|sola|allein|sonat|concert|etude|étude|stud|romance|pieces?\b|suite|fantas|partita|capric|prelude|elegy)"
SOLO_MARKER = re.compile(
    r"독주|솔로|무반주|\b(solo|unaccompanied|alone|seule?|sola|allein)\b", re.I
)
ORCHESTRA = re.compile(
    r"관현악|오케스트라|관악단|취주악|브라스 밴드|금관 밴드|윈드 밴드|현악 합주|현을 위한|현악을 위한|(와|과) 현(악)?(을|를)? |현악(과|와) |"
    r"\borchest|\borquest|\bbrass band|\bwind (band|ensemble|orchestra)|\bconcert band|\bmilitary band|\bsymphonic band|"
    r"\b(and|with|for|e|et|und|für) (string(s)?|archi|cordes|streicher)\b(?! (quartet|trio|quintet|sextet))",
    re.I,
)
VOICE = re.compile(
    r"성악|독창(?!적)|합창|소프라노|메조소프라노|테너|바리톤|낭송|"
    r"\b(for|für|pour|para|per|with|avec|mit|con|and|und|et|e)\s+(\w+\s+)?(voice|voices|soprano|mezzo-soprano|contralto|tenor|baritone|choir|chorus|chœur|coro|chor|singstimme|singers|narrator)\b",
    re.I,
)
KEYBOARD = re.compile(
    r"피아노|하프시코드|쳄발로|클라비어|건반|클라브생|오르간|\b(piano|pianoforte|klavier|clavier|harpsichord|cembalo|clavecin|organ|orgue|orgel)\b",
    re.I,
)
PLURAL = re.compile(
    r"두 대|2대|세 대|3대|네 대|4대|[2-9]개의 (바이올린|첼로|플루트|기타|호른|트럼펫|트롬본)|"
    r"\b(two|three|four|\d+|due|deux|zwei|dos|tre|trois|drei)\s+(\w+\s+)?(violins?|violas?|cellos?|flutes?|oboes?|clarinets?|bassoons?|horns?|trumpets?|trombones?|posaunen|guitars?|guitarras|guitares|chitarre|harps?|violini|violons)\b|"
    r"\b(violins|cellos|flutes|oboes|clarinets|bassoons|horns|trumpets|trombones|guitars|harps)\b",
    re.I,
)


def scored_instruments(t: str, en: str) -> set[str]:
    """편성을 적는 자리에서 읽은 건반 아닌 악기."""
    found: set[str] = set()
    for text in (t, en):
        for match in SCORING_PHRASE.finditer(text):
            phrase = match.group(2)
            found |= {
                name for name, pattern in INSTRUMENTS.items() if re.search(pattern, phrase, re.I)
            }
        for name, pattern in INSTRUMENTS.items():
            if re.search(
                rf"\b(solo|unaccompanied)\s+({pattern})|({pattern}){EN_FORM_AFTER}", text, re.I
            ):
                found.add(name)
    for name, pattern in KO_INSTRUMENTS.items():
        if re.search(rf"(?:^|[\s(<,·])({pattern}){KO_AFTER}", t):
            found.add(name)
    if KO_GUITAR.search(t):
        found.add("guitar")
    return found


def scoring(t: str, en: str) -> tuple[str, int] | None:
    """제목에 적힌 편성(종류, 건반 아닌 악기 수). 적혀 있지 않거나 건반 독주면 None."""
    x = f"{t} | {en}"
    instruments = scored_instruments(t, en)
    if ORCHESTRA.search(x):
        if VOICE.search(x) or re.search(
            r"가곡|\b(lieder|songs|chansons|mélodies|orchesterlieder)\b", x, re.I
        ):
            return "voice", len(instruments)
        if instruments or re.search(
            r"(피아노|건반|하프시코드|오르간)(와|과|,)|\b(piano|keyboard|harpsichord|organ|cembali)\b[^|]*\b(and|und|et|e)\b[^|]*\b(orchest|orquest)",
            x,
            re.I,
        ):
            return "solo_orchestra", len(instruments)
        return "orchestra", 0
    if VOICE.search(x):
        return "voice", len(instruments)
    if not instruments:
        return None
    if KEYBOARD.search(x):
        return "with_keyboard", len(instruments)
    if len(instruments) > 1 or PLURAL.search(x):
        return "ensemble", len(instruments)
    (only,) = instruments
    if SOLO_MARKER.search(x) or FAMILY[only] in ("plucked", "percussion", "other"):
        return "solo", 1
    # 「Romance for Horn」「바이올린 소나티나」처럼 반주를 적지 않은 현·관악기 곡: 실내악으로 보되 독주로 단정하지 않는다
    return "unsure", 1


def scored_form(kind: str, count: int, x: str) -> str:
    """편성으로 정한 형식."""
    if kind == "orchestra":
        if re.search(r"신포니에타|\bsinfonietta\b", x, re.I):
            return "sinfonia"
        if re.search(r"교향시|symphonic poem|tone poem", x, re.I):
            return "symphonic_poem"
        if re.search(r"서곡|\bouvert", x, re.I):
            return "overture"
        if re.search(r"세레나데|디베르티멘토|\b(serenade|divertimento)\b", x, re.I):
            return "serenade"
        if re.search(
            r"행진곡|왈츠|폴카|무곡|미뉴에트|폴로네즈|에코세즈|콩트르당스|렌틀러|"
            r"\b(march|marsch|waltz|valse|walzer|polka|dances?|minuets?|polonaise|écossaise|contredanses?|ländler)\b",
            x,
            re.I,
        ):
            return "dance_march"
        if re.search(r"모음곡|\bsuite\b", x, re.I):
            return "orch_suite"
        return "orchestral_other"
    if kind == "solo_orchestra":
        return "concertante"
    if kind == "voice":
        if re.search(r"합창|\d+성부|\b(choir|chorus|chœur|coro|chor)\b", x, re.I):
            return "choral"
        if re.search(r"가곡|노래|\b(song|songs|lied|lieder|mélodie|melodie)\b", x, re.I):
            return "song"
        return "vocal_other"
    if kind in ("with_keyboard", "unsure"):
        if count == 1 and re.search(r"소나타|소나티나|\bsonat", x, re.I) and not PLURAL.search(x):
            return "duo_sonata"
        return "chamber_other"
    if kind == "solo":
        return "solo"
    if re.search(
        r"(트롬본|호른|트럼펫|관악)|\b(trombones|horns|trumpets|posaunen|wind|brass)\b", x, re.I
    ):
        return "wind_chamber"
    return "chamber_other"


KEYBOARD_KINDS = (
    r"피아노|\b(piano|pianoforte|klavier)\b",
    r"하프시코드|쳄발로|\b(harpsichord|cembalo|cembali|clavecin)\b",
    r"오르간|\b(organ|orgue|orgel)\b",
)


def solo_instruments(text: str) -> set[str]:
    """협주곡 제목에 적힌 독주 악기(서로 다른 악기마다 하나)."""
    found = {name for name, pattern in INSTRUMENTS.items() if re.search(pattern, text, re.I)}
    found |= {name for name, pattern in KO_INSTRUMENTS.items() if re.search(pattern, text)}
    found |= {pattern for pattern in KEYBOARD_KINDS if re.search(pattern, text, re.I)}
    return found


def concerto_form(text: str) -> str:
    if re.search(r"합주 협주곡|concerto grosso", text, re.I):
        return "concerto_grosso"
    if re.search(
        r"(피아노|건반|하프시코드|쳄발로|클라비어) 협주곡|piano concerto|klavierkonzert|keyboard concerto|harpsichord concerto",
        text,
        re.I,
    ):
        return "piano_concerto"
    if re.search(r"바이올린 협주곡|violin concerto|violinkonzert", text, re.I):
        return "violin_concerto"
    if re.search(r"첼로 협주곡|cello concerto|violoncello concerto|cellokonzert", text, re.I):
        return "cello_concerto"
    if re.search(
        r"(플루트|오보에|클라리넷|바순|호른|트럼펫|트롬본|색소폰|리코더|관악) 협주곡|(flute|oboe|clarinet|bassoon|horn|trumpet|trombone|saxophone|recorder) concerto",
        text,
        re.I,
    ):
        return "wind_concerto"
    # 「Concerto for Violin and Orchestra」「Concerto pour violon」처럼 독주 악기만 적은 협주곡.
    # 독주 악기가 둘 이상이면(이중·삼중 협주곡) 그 밖의 협주곡이다
    soloists = solo_instruments(text)
    if (
        len(soloists) != 1
        or PLURAL.search(text)
        or re.search(r"이중|삼중|double|triple|doppel", text, re.I)
    ):
        return "other_concerto"
    (only,) = soloists
    if only in KEYBOARD_KINDS[:2]:
        return "piano_concerto"
    if only == "violin":
        return "violin_concerto"
    if only == "cello":
        return "cello_concerto"
    if FAMILY.get(only) in ("wind", "brass"):
        return "wind_concerto"
    return "other_concerto"


def classify_text(row: Row, stage_names: set[str]) -> tuple[str | None, str]:
    """(형식, 규칙 이름). 형식이 없으면 None."""
    t = row.title.strip()
    x = f"{t} | {row.title_en}"
    low = x.lower()

    if row.piece_id in OVERRIDES:
        return OVERRIDES[row.piece_id], "override"
    if row.piece_id in UNDECIDED:
        return None, "undecided"
    match = re.match(r"^BWV\s*(\d+)", row.catalogue)
    if row.composer_id == BACH and match and (form := bwv_form(int(match.group(1)), t)):
        return form, "bwv"

    # 무대 작품과 그 발췌(서곡·아리아·합창·무곡·모음곡)
    if re.match(r"^(부수음악|극음악)", t) or re.search(r"<[^>]+>\s*(부수음악|극음악)", t):
        return "incidental", "incidental"
    if not re.search(r"주제에 의한|변주|회상|패러프레이즈|환상곡|편곡", t):
        if re.match(
            r"^(오페라|오페레타|징슈필|뮤지컬|사르수엘라|발레)\s*<[^>]+>\s*(중|서곡|전주곡|모음곡|에서)",
            t,
        ):
            return "stage_excerpt", "stage-excerpt"
        excerpt = re.match(r"^(서곡\s*)?<([^>]+)>\s*(중|의|서곡|전주곡|모음곡|에서|$)", t)
        if excerpt and excerpt.group(2) in stage_names:
            return "stage_excerpt", "stage-excerpt-known"
    if re.match(r"^(오페라|오페라 부파|오페라 세리아)\b|^오페라 ?<", t):
        return "opera", "opera"
    if re.match(r"^(오페레타|징슈필|뮤지컬|사르수엘라)", t):
        return "operetta", "operetta"
    if re.match(r"^발레", t):
        return ("stage_excerpt" if "모음곡" in t else "ballet"), "ballet"
    if FILM.search(x):
        return None, "film"

    # 관현악·교향곡
    if re.match(r"^교향시", t) or "목신의 오후" in t:
        return "symphonic_poem", "symphonic-poem"
    if re.search(r"협주 교향곡|신포니아 콘체르탄테|sinfonia concertante", x, re.I):
        return "other_concerto", "sinfonia-concertante"
    if re.match(r"^교향곡", t) or (
        re.search(r"\bsymphon(y|ie)\b|\bsinfonie\b", low) and "concert" not in low
    ):
        return "symphony", "symphony"
    if re.match(r"^(신포니에타|신포니아)", t) and row.composer_id != BACH:
        return "sinfonia", "sinfonia"

    # 협주곡과 독주·관현악
    if re.search(
        r"파가니니 주제에 의한 광시곡|랩소디 인 블루|(와|과) 관현악을 위한|(와|과) 현악 (합주|오케스트라)를 위한|for [\w\s,]+ (and|&) (string |small |chamber )?orchestra|\bpara [\w\s,]+ e orquestra|\bpour [\w\s,]+ et orchestre|\bfür [\w\s,]+ und orchester",
        x,
        re.I,
    ) and not (
        # 협주곡이면 아래 협주곡 규칙이 독주 악기로 형식을 고르고, 노래가 든 곡은 성악이다
        re.search(r"협주곡|\b(concerto|konzert|concierto)\b", x, re.I) or VOICE.search(x)
    ):
        return "concertante", "concertante"
    if "이탈리아 협주곡" in t:
        return "piano_other", "italian-concerto"
    if re.search(r"협주곡|콘체르티노|\bconcerto\b|\bkonzert\b|concertino", x, re.I):
        return concerto_form(x), "concerto"

    # 성악
    if re.match(r"^(미사|장엄 미사|레퀴엠|진혼곡)", t) or re.search(
        r"\b(missa|messe|mass|requiem)\b", low
    ):
        return "mass_requiem", "mass"
    if re.search(r"^오라토리오|수난곡|\boratori|\bpassion\b|matthäus|johannes-passion", x, re.I):
        return "oratorio_passion", "oratorio"
    if re.search(r"^칸타타|칸타타|\bcantata\b|\bkantate\b", x, re.I):
        return "cantata", "cantata"
    if re.search(r"코랄 전주곡|오르간|\borgan\b|\borgel\b", x, re.I):
        return "organ", "organ"
    if (
        re.match(
            r"^(모테트|마니피카트|스타바트 마테르|테 데움|시편|찬가|성가|아베 마리아|글로리아|미제레레|살베 레지나|레지나 첼리|봉헌송|키리에|리타니아|베스페레|저녁 기도|철야 기도|전례)",
            t,
        )
        or re.search(
            r"전례|철야 기도|\b(motet|magnificat|stabat mater|te deum|psalm|ave maria|hymn|anthem|vespers|liturgy|offertorium|litaniae|regina coeli)\b",
            x,
            re.I,
        )
        or (
            # 「코랄」은 오르간·피아노·관현악 곡 제목에도 흔해서 악기가 적혀 있으면 성악으로 보지 않는다
            re.search(r"코랄|\bchorales?\b|\bchoräle\b", x, re.I)
            and not (
                KEYBOARD.search(x) or ORCHESTRA.search(x) or scored_instruments(t, row.title_en)
            )
        )
    ):
        return "sacred", "sacred"
    if re.search(
        r"^(가곡|연가곡|리트|샹송)|연가곡|가곡|개의 로망스|^로망스 <|이중창|2중창|3중창|아리에타|\b(lied|lieder|song|songs|chanson|mélodie|melodie|romances)\b",
        x,
        re.I,
    ) and not WORDLESS.search(x):
        return "song", "song"
    if re.match(r"^(연주회용 아리아|아리아)", t) or re.search(
        r"레치타티보와 아리아|장면과 아리아|(소프라노|테너|베이스|알토) 아리아|\bconcert aria\b",
        x,
        re.I,
    ):
        return "concert_aria", "aria"
    if re.search(
        r"저녁기도|\b(sancte|sancta|domine|agnus dei|exsultate|alleluia|salve)\b", x, re.I
    ):
        return "sacred", "sacred-latin"
    if re.match(r"^(합창곡|무반주 합창|마드리갈|파트송|카논 <)", t) or re.search(
        r"(남성|여성|혼성) 합창|^합창|\b(madrigal|partsong|chorus)\b", x, re.I
    ):
        return "choral", "choral"
    if re.search(r"민요 편곡|folk ?song arrangement", x, re.I):
        return "folk", "folk"

    # 실내악
    if re.search(
        r"무반주|\bunaccompanied\b|solo (violin|cello)|for solo (violin|cello|flute)", x, re.I
    ) or re.match(r"^(첼로|바이올린|기타|류트|플루트) (모음곡|파르티타)", t):
        return "solo", "solo"
    if re.search(r"현악 4중주|string quartet|streichquartett|quatuor à cordes", x, re.I):
        return "string_quartet", "string-quartet"
    if re.search(
        r"현악 [3-8]중주|string (trio|quintet|sextet|octet)|streich(trio|quintett|sextett)", x, re.I
    ):
        return "string_ensemble", "string-ensemble"
    if re.search(
        r"피아노 [3-5]중주|piano (trio|quartet|quintet)|klavier(trio|quartett|quintett)", x, re.I
    ):
        return "piano_chamber", "piano-chamber"
    if re.match(
        r"^(바이올린|첼로|비올라|플루트|클라리넷|오보에|호른|바순|트럼펫|기타|하프|콘트라베이스|리코더|비올라 다 감바) 소나타",
        t,
    ) or re.search(
        r"(violin|cello|viola|flute|clarinet|oboe|horn|bassoon) sonata|sonata for (violin|cello|viola|flute|clarinet|oboe)",
        low,
    ):
        return "duo_sonata", "duo-sonata"
    if re.search(
        r"(바이올린|첼로|비올라|플루트|클라리넷|만돌린|호른|오보에|바순|기타)(와|과) 피아노를 위한",
        t,
    ):
        return "chamber_other", "duo-with-piano"
    if re.search(
        r"(목관|관악|플루트|오보에|클라리넷|바순|호른) ?[2-9]중주|wind (quintet|octet)|bläser",
        x,
        re.I,
    ):
        return "wind_chamber", "wind-chamber"
    if re.search(
        r"[2-9]중주|이중주|트리오 소나타|\b(duo|trio|quartet|quintet|sextet|septet|octet|nonet|kvintet|kvartet|quintett|quartett|oktett|septett|sextett)\b|trio sonata",
        x,
        re.I,
    ):
        return "chamber_other", "chamber"

    # 제목에 건반 아닌 편성이 적혀 있으면 건반 형식 규칙보다 먼저 편성으로 정한다
    if (scored := scoring(t, row.title_en)) is not None:
        kind, count = scored
        return scored_form(kind, count, x), f"scoring-{kind}"

    # 건반 독주
    if re.search(
        r"네 손|두 대의 피아노|2대의 피아노|연탄|four hands|4 hands|two pianos|2 pianos|zu vier händen|deux pianos|à quatre mains",
        x,
        re.I,
    ):
        return "four_hands", "four-hands"
    if re.match(
        r"^(피아노 소나타|건반 소나타|하프시코드 소나타|클라비어 소나타|소나티네|소나티나|소나타)",
        t,
    ) or re.search(r"piano sonata|klaviersonate|keyboard sonata|harpsichord sonata|sonatin", low):
        return "sonata", "sonata"
    if re.search(r"연습곡|에튀드|초절기교|\b(étude|etude|études|etudes|study|studies)\b", x, re.I):
        return "etude", "etude"
    if re.search(
        r"^(피아노 모음곡|클라브생 모음곡|하프시코드 모음곡|건반 모음곡|프랑스 모음곡|영국 모음곡|파르티타)|^클라브생 모음곡",
        t,
    ):
        return "keyboard_suite", "keyboard-suite"
    if "전주곡집" in t or (
        re.search(
            r"전주곡|푸가|평균율|토카타|인벤션|\b(prelude|prélude|fugue|fuga|toccata)\b", x, re.I
        )
        and not re.search(r"<", t)
    ):
        return "prelude_fugue", "prelude"
    if re.search(r"^발라드|\bballade\b", x, re.I):
        return "ballade", "ballade"
    if re.match(r"^스케르초", t) or (re.search(r"\bscherzo\b", low) and "교향적" not in t):
        return "scherzo", "scherzo"
    if re.search(r"^(녹턴|야상곡)|녹턴|\bnocturne\b", x, re.I):
        return "nocturne", "nocturne"
    if re.search(r"즉흥곡|즉흥 환상곡|\bimpromptu", x, re.I):
        return "impromptu", "impromptu"
    if re.match(r"^마주르카(?!풍)", t) or re.search(r"\bmazurk", low):
        return "mazurka", "mazurka"
    if re.search(r"폴로네즈|폴로네이즈|\bpolonaise", x, re.I):
        return "polonaise", "polonaise"
    if re.match(r"^(왈츠|발스)", t) or re.search(r"\b(waltz|valse|walzer)\b", low):
        if row.composer_id in STRAUSS or BRACKET_NAME.search(t):
            return "dance_march", "strauss-waltz"
        return "waltz", "waltz"
    if re.search(r"^(서곡|연주회용 서곡)|서곡|\bouvert", x, re.I):
        return "overture", "overture"
    if re.match(r"^(폴카|갤럽|행진곡|카드리유|마주르카 <)", t) or re.search(
        r"행진곡|\b(march|marsch|polka|galop)\b", x, re.I
    ):
        return "dance_march", "march"
    if re.match(
        r"^(\d+개의 )?(미뉴에트|독일 무곡|렌틀러|에코세즈|콩트르당스|무곡|춤곡|가보트|부레|지그|사라방드|쿠랑트|알망드|타란텔라|볼레로|갤럽)",
        t,
    ) or re.search(r"\b(minuet|menuett|german dance|ländler|écossaise|contredanse)\b", low):
        if row.composer_id in ORCHESTRAL_DANCE_COMPOSERS and (
            row.parts > 1 or re.match(r"^\d+개의", t)
        ):
            return "dance_march", "dance-set"
        return "dance", "dance"
    if re.search(r"헝가리 무곡|슬라브 무곡|노르웨이 무곡|스페인 무곡", t):
        return "dance_march", "national-dance"
    if re.search(r"변주곡|주제에 의한|\bvariation", x, re.I):
        return "variations", "variations"
    if re.search(r"^론도|론도|\brondo\b", x, re.I):
        return "rondo", "rondo"
    if re.search(r"환상곡|판타지|랩소디|광시곡|\b(fantasia|fantasie|fantaisie|rhapsod)", x, re.I):
        return "fantasia", "fantasia"
    if re.search(
        r"바가텔|간주곡|무언가|서정 소품|악흥의 순간|앨범|아라베스크|노벨레테|자장가|뱃노래|소품|둠카|\b(bagatelle|intermezzo|song without words|lyric piece|moment musical|albumblatt|arabesque|berceuse|barcarolle)\b",
        x,
        re.I,
    ):
        return "character", "character"
    if (
        row.composer_id in ORCHESTRAL_DANCE_COMPOSERS | {15, 26}
        and row.parts == 0
        and re.match(
            r"^(아다지오|알레그로|안단테|안단티노|알레그레토|라르고|모데라토|프레스토|칸타빌레)( [A-G][♭#]?(장조|단조))",
            t,
        )
    ):
        return "piano_other", "tempo-title"
    if re.match(r"^교회 소나타", t):
        return "chamber_other", "church-sonata"
    if re.search(
        r"세레나데|디베르티멘토|카사시옹|노투르노|\b(serenade|divertimento|cassation)\b", x, re.I
    ):
        return "serenade", "serenade"
    if re.search(r"모음곡|\bsuite\b", x, re.I):
        if re.search(r"피아노|하프시코드|클라브생|건반", t):
            return "keyboard_suite", "keyboard-suite"
        return "orch_suite", "suite"
    if re.search(r"관현악|오케스트라|교향적|\borchestra", x, re.I):
        return "orchestral_other", "orchestral"
    if re.search(
        r"피아노|하프시코드|클라비어|건반|쳄발로|클라브생|\b(piano|klavier|harpsichord|clavier|cembalo)\b",
        x,
        re.I,
    ):
        return "piano_other", "keyboard"

    by_type = {
        "Symphony": "symphony",
        "Concerto": "other_concerto",
        "Opera": "opera",
        "Ballet": "ballet",
        "Song": "song",
        "Song-cycle": "song",
        "Aria": "concert_aria",
        "Cantata": "cantata",
        "Mass": "mass_requiem",
        "Motet": "sacred",
        "Oratorio": "oratorio_passion",
        "Requiem": "mass_requiem",
        "Quartet": "chamber_other",
        "Quintet": "chamber_other",
        "Trio": "chamber_other",
        "Sonata": "sonata",
        "Étude": "etude",
        "Overture": "overture",
        "Suite": "orch_suite",
        "Symphonic poem": "symphonic_poem",
        "Madrigal": "choral",
        "Partita": "keyboard_suite",
        "Operetta": "operetta",
        "Zarzuela": "operetta",
        "Incidental music": "incidental",
        "Prelude": "prelude_fugue",
        "Nocturne": "nocturne",
        "Waltz": "waltz",
        "Variations": "variations",
        "Serenade": "serenade",
        "Chanson": "song",
    }
    if row.work_type in by_type:
        return by_type[row.work_type], "mb-type"
    return None, "none"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", required=True)
    parser.add_argument("--genres", required=True)
    parser.add_argument("--out", required=True)
    args = parser.parse_args()

    with open(args.input, encoding="utf-8") as handle:
        raw = list(csv.DictReader(handle, delimiter="\t", quoting=csv.QUOTE_NONE))
    rows = [
        Row(
            piece_id=int(r["id"]),
            composer_id=int(r["composer_id"]),
            title=norm(r["title"]),
            title_en=norm(r["title_en"]),
            work_type=norm(r["work_type"]),
            catalogue=" ".join(
                x for x in (norm(r["catalogue_system"]), norm(r["catalogue_number"])) if x
            )
            or norm(r["opus_number"]),
            parts=int(r["parts"]),
        )
        for r in raw
    ]
    with open(args.genres, encoding="utf-8") as handle:
        entries = [json.loads(line) for line in handle if line.strip()]
    curated = {int(e["pieceId"]): str(e["genre"]) for e in entries}

    # 작곡가별 무대 작품 이름(<…>): 「서곡 <윌리엄 텔>」 같은 발췌를 무대 작품으로 보기 위해
    stage_names: dict[int, set[str]] = {}
    for row in rows:
        match = STAGE_PREFIX.match(row.title)
        if match and match.group(1) not in ("부수음악", "극음악"):
            stage_names.setdefault(row.composer_id, set()).add(match.group(2))

    first: dict[int, tuple[str | None, str]] = {
        row.piece_id: classify_text(row, stage_names.get(row.composer_id, set())) for row in rows
    }
    for row in rows:
        form, rule = first[row.piece_id]
        if rule in ("override", "undecided"):
            continue
        genre = FORM_GENRE.get(form) if form else None
        keyboard = bool(KEYBOARD.search(f"{row.title} | {row.title_en}"))
        if (
            row.composer_id in GUITAR_COMPOSERS
            and (genre == "piano" or form == "serenade")
            and not keyboard
        ):
            first[row.piece_id] = ("solo", "guitar-composer")
        elif row.composer_id in PAGANINI and (
            genre == "piano" or form in ("serenade", "dance_march")
        ):
            first[row.piece_id] = (None, "mixed-composer")
        elif row.composer_id in VIOLIN_COMPOSERS and (
            genre == "piano" or form in ("serenade", "dance_march")
        ):
            first[row.piece_id] = ("chamber_other", "violin-composer")
        elif (
            row.composer_id in MIXED_KEYBOARD_GUITAR_COMPOSERS
            and (genre == "piano" or form in ("serenade", "dance_march"))
            and not KEYBOARD.search(f"{row.title} | {row.title_en}")
        ):
            first[row.piece_id] = (None, "mixed-composer")
        elif row.composer_id in PIANO_DANCE_COMPOSERS and form == "serenade":
            first[row.piece_id] = ("character", "piano-dance-composer")
        elif row.composer_id in PIANO_DANCE_COMPOSERS and rule == "national-dance":
            first[row.piece_id] = ("dance", "piano-dance-composer")
    for row in rows:
        form, rule = first[row.piece_id]
        if row.composer_id in PIANO_COMPOSERS and form in (None, "dance_march"):
            first[row.piece_id] = (
                "dance" if form == "dance_march" else "piano_other",
                "piano-composer",
            )
    # 「<전주곡집> 1권 중 "돛"」처럼 못 나눈 발췌는 같은 작곡가의 원 작품(제목에 그 이름이 든 작품)을 따른다
    by_composer: dict[int, list[Row]] = {}
    for row in rows:
        by_composer.setdefault(row.composer_id, []).append(row)
    for row in rows:
        if first[row.piece_id][0] is not None:
            continue
        match = re.match(r"^<([^>]+)>", row.title)
        if not match:
            continue
        name = match.group(1)
        for other in by_composer[row.composer_id]:
            form = first[other.piece_id][0]
            if (
                other.piece_id != row.piece_id
                and form
                and name in other.title
                and first[other.piece_id][1] != "parent"
            ):
                first[row.piece_id] = (form, "parent")
                break

    stats: Counter[str] = Counter()
    with open(args.out, "w", encoding="utf-8") as out:
        for row in rows:
            form, rule = first[row.piece_id]
            genre = FORM_GENRE.get(form) if form else None
            if row.piece_id in curated:
                fixed = curated[row.piece_id]
                if genre != fixed:
                    form, rule = OTHER_FORM[fixed], f"curated-genre({rule})"
                genre = fixed
            stats["classified" if genre else "none"] += 1
            stats[f"rule:{rule.split('(')[0]}"] += 1
            out.write(
                json.dumps(
                    {
                        "pieceId": row.piece_id,
                        "genre": genre,
                        "formKey": form if genre else None,
                        "rule": rule,
                    },
                    ensure_ascii=False,
                )
                + "\n"
            )
    print(json.dumps(dict(stats.most_common()), ensure_ascii=False))


if __name__ == "__main__":
    main()
