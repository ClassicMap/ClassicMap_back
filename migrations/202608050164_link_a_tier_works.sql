-- A tier 수동 곡 59 개에 MusicBrainz 작품 식별자를 붙인다.
--
-- A tier 수동 곡에는 식별자가 하나도 안 붙어 있었다. 적재기는 곡을
-- musicbrainz_work 로만 해소하므로 이것이 없으면 연주를 붙일 수 없다.
--
-- 작곡가 arid 로 작품 목록 약 25,000 곡을 받아 로컬에서 맞췄다. 제목으로 검색하면
-- 빈 결과가 나와 "없다"고 잘못 결론 내리기 쉽다. 고르면서 네 가지를 대조했다.
--   조성과 번호 — 제목 단어만 겹쳐 보면 드보르자크 첼로 협주곡 B단조 자리에
--                 A장조 협주곡이, 파가니니 1번 자리에 기타 4중주 4번이 올라온다
--   원어 제목   — 비제 교향곡은 프랑스어 Symphonie no. 1 en ut majeur 로만 있다
--   편곡 여부   — 라흐마니노프 전주곡·보칼리제는 단독 제목 work 이 전부 편곡판이고
--                 원곡은 10 Preludes, op. 23: No. 5 처럼 묶음의 낱곡으로 등록돼 있다
--   판본        — 베베른 op. 6(1909/1928), 라벨 치건(바이올린+피아노/관현악),
--                 민둥산(1867 원곡/림스키 편곡)은 판본이 갈린다. 아래 셋을 정했다
--
-- 시드 곡이 이미 쥐고 있던 29 개는 202608050163 에서 옮겼다. 여기는 나머지 59 개다.
-- 슈타미츠 신포니아 D장조(111)는 어느 곡인지 특정하지 못해 뺐다.

INSERT INTO piece_identifiers (piece_id, namespace, external_id)
SELECT * FROM (
    SELECT 62 AS p, 'musicbrainz_work' AS n, 'dc2c37a8-4ec1-348c-8f68-c4a5dbfc6a7f' AS v     -- Orfeo ed Euridice, Wq. 30: Ballet in D minor “Dance of t
    UNION ALL SELECT 63, 'musicbrainz_work', 'a7b15806-035a-39be-9bba-47b06b61e3cc'          -- Orfeo ed Euridice, Wq. 30: Atto III. Aria “Che farò senz
    UNION ALL SELECT 103, 'musicbrainz_work', 'e8996fa5-8493-4984-9690-b3bea2fc27c3'         -- Solfeggio for keyboard in C minor, Wq 117 no. 2, H 220
    UNION ALL SELECT 107, 'musicbrainz_work', '3a700d83-b704-4d6b-9a31-5953178d9553'         -- Symphony in B-flat major (Lucio Silla Overture), op. 18 
    UNION ALL SELECT 108, 'musicbrainz_work', '99a42b4d-4edd-407b-a0f1-7d36e8c87ea1'         -- Sinfonia Concertante C‐Dur T289/4 für Flöte, Oboe, Violi
    UNION ALL SELECT 109, 'musicbrainz_work', '9c46cacc-9284-4816-9996-9969230809e7'         -- Concerto for Viola in C minor
    UNION ALL SELECT 110, 'musicbrainz_work', '73a26450-b76a-42d6-a8c4-eb94948a7f81'         -- Clarinet Concerto in B-flat major
    UNION ALL SELECT 112, 'musicbrainz_work', '3c67b597-4521-415b-ac32-c816de36097a'         -- Trumpet Concerto in D
    UNION ALL SELECT 115, 'musicbrainz_work', '52373e56-faab-4c9e-a7e7-51358b0241f7'         -- Sonata in G minor, op. 50 no. 3 “Didone abbandonata”
    UNION ALL SELECT 165, 'musicbrainz_work', 'f6f5be9e-9f7d-49e5-a579-edfb0d9b1229'         -- Violin Concerto no. 2 in B minor, op. 7, MS 48
    UNION ALL SELECT 166, 'musicbrainz_work', '86f174b7-2b36-4807-aa07-a730c20e7bf8'         -- Concerto for Violin and Orchestra in D major, op. 6, MS 
    UNION ALL SELECT 168, 'musicbrainz_work', '937398a2-d307-3ccd-a390-78d1b73c6457'         -- Guillaume Tell : Ouverture
    UNION ALL SELECT 169, 'musicbrainz_work', 'baa339e5-c2db-45da-a0ff-f9ea200f9178'         -- La gazza ladra: Ouverture
    UNION ALL SELECT 171, 'musicbrainz_work', '53234371-d49a-39c0-814e-2469c1cd8dc5'         -- La Damnation de Faust : Première Partie : Scène 3. March
    UNION ALL SELECT 172, 'musicbrainz_work', '3f4b1135-f5df-4887-b95d-8e67198d0238'         -- Le Carnaval romain, ouverture pour orchestre, op. 9
    UNION ALL SELECT 175, 'musicbrainz_work', 'd705f4e5-9292-4ad5-81c7-c4796454d649'         -- A Farewell to Saint Petersburg: No. 10. The Lark (Жаворо
    UNION ALL SELECT 176, 'musicbrainz_work', 'd866c709-fc3a-4e7d-a3af-3f27145937cd'         -- Piano Trio in G minor, op. 17
    UNION ALL SELECT 177, 'musicbrainz_work', '8f4e1205-4860-455a-8f68-d941a09aaca4'         -- Concerto for Piano and Orchestra in A minor, op. 7
    UNION ALL SELECT 178, 'musicbrainz_work', '7643c480-ab02-4c9c-aac4-da711ba87be5'         -- Drei Romanzen für Pianoforte und Violine, op. 22
    UNION ALL SELECT 179, 'musicbrainz_work', '4dfff025-0499-420c-8b35-cfda9e234847'         -- Sonata for Violin and Piano in A major, M. 8, CFF 123
    UNION ALL SELECT 180, 'musicbrainz_work', '1f83b1af-010a-4fa4-92ad-d81b02865194'         -- Symphonie en ré mineur op. 48
    UNION ALL SELECT 181, 'musicbrainz_work', '5b979859-257c-4562-a5a3-8aeba2204241'         -- Messe solennelle en la majeur, op. 12 : V. Panis Angelic
    UNION ALL SELECT 182, 'musicbrainz_work', '9d9a08ad-40c7-4291-b7c1-3c5120dac2c8'         -- Symphony no. 4 in E-flat major, WAB 104 "Romantische"
    UNION ALL SELECT 183, 'musicbrainz_work', 'e080651c-3566-451b-a151-c8a2032ac0f7'         -- Symphony no. 7 in E-major, WAB 107
    UNION ALL SELECT 184, 'musicbrainz_work', '59bb5205-fbec-3a26-b106-544cb887e268'         -- Locus iste, WAB 23
    UNION ALL SELECT 185, 'musicbrainz_work', '6763c20d-f2df-3347-8a0e-7abad42a5a56'         -- An der schönen blauen Donau, op. 314
    UNION ALL SELECT 188, 'musicbrainz_work', '2a7a816c-3c28-3609-be5d-7663b3337fee'         -- Geschichten aus dem Wienerwald, op. 325
    UNION ALL SELECT 189, 'musicbrainz_work', 'fef21cee-269d-45cb-b41e-f90980979aca'         -- Pictures at an Exhibition
    UNION ALL SELECT 190, 'musicbrainz_work', 'e624d7dc-5abc-4439-87f7-65bc1095bf57'         -- Tableaux d’une exposition
    UNION ALL SELECT 191, 'musicbrainz_work', '7cd45975-951c-3f4a-9c07-5bdfb59abddc'         -- Une nuit sur le mont chauve (림스키코르사코프 편곡)
    UNION ALL SELECT 197, 'musicbrainz_work', '90379c91-2dce-4ba4-9900-dd32763ee0b4'         -- Symphony no. 9 in E minor, Op. 95 “From the New World”
    UNION ALL SELECT 198, 'musicbrainz_work', '7c7657b6-86af-3a86-9c20-21e88c92544c'         -- Cello Concerto in B minor, op. 104
    UNION ALL SELECT 200, 'musicbrainz_work', '22cb232b-1587-455a-a3b2-248ae605771c'         -- String Quartet no. 12 in F major, op. 96, B. 179 “Americ
    UNION ALL SELECT 201, 'musicbrainz_work', '134f4e53-e0d5-3ec7-aa86-5d3456379c4b'         -- Humoresque no. 7 for Piano in G-flat major, B. 187/7, op
    UNION ALL SELECT 202, 'musicbrainz_work', '4bf36cb5-817b-4ef4-b0e4-63e00fa27dc5'         -- Scheherazade, op. 35
    UNION ALL SELECT 204, 'musicbrainz_work', '18d5c524-e250-4b8d-b773-4f724fe636c2'         -- Каприччио на испанские темы, op. 34
    UNION ALL SELECT 205, 'musicbrainz_work', '840155b0-c12d-365c-bd5f-029136aa816e'         -- Russian Easter Festival Overture, op. 36
    UNION ALL SELECT 206, 'musicbrainz_work', 'ccb56514-45cd-470c-abb6-d314b5bb150a'         -- Requiem, op. 48
    UNION ALL SELECT 208, 'musicbrainz_work', 'd4a90ba5-9493-41e3-aae4-2e882ad8a24a'         -- Sicilienne, op. 78
    UNION ALL SELECT 209, 'musicbrainz_work', 'a57e0d98-ad45-3e10-a58b-6835a3e83884'         -- Après un rêve, op. 7 no. 1
    UNION ALL SELECT 216, 'musicbrainz_work', 'adcdc472-8b19-4e6f-aa4e-be8c6aea5f8a'         -- Symphony no. 5
    UNION ALL SELECT 219, 'musicbrainz_work', '14514e77-f06c-4d24-a4d5-9a5962acae64'         -- Das Lied von der Erde
    UNION ALL SELECT 222, 'musicbrainz_work', '6b73c1be-7e55-48f2-bfdf-16f88e0a1d25'         -- La Mer, trois esquisses symphoniques pour orchestre, L. 
    UNION ALL SELECT 227, 'musicbrainz_work', '17eea09b-0497-370c-a0a2-4f7f2d49300f'         -- Rhapsody on a Theme of Paganini, op. 43
    UNION ALL SELECT 228, 'musicbrainz_work', '24b1c94b-2779-3964-bc2e-3c5d4137f3f9'         -- 14 Romances, op. 34 no. 14: Vocalise
    UNION ALL SELECT 349, 'musicbrainz_work', '2088dbfb-b916-4d29-8883-cd5fd60c6c28'         -- Carmina Burana: Cantiones profanæ cantoribus et choris c
    UNION ALL SELECT 350, 'musicbrainz_work', '53833e21-6318-33b3-b3d8-7bf1fc0b7373'         -- Carmina Burana: Fortuna imperatrix mundi: I. O Fortuna
    UNION ALL SELECT 354, 'musicbrainz_work', 'f4e481ae-e994-4ca5-aff0-d2d8c1d06ccf'         -- Etude no. 6
    UNION ALL SELECT 366, 'musicbrainz_work', '1c4e8c99-711e-4e23-aca4-96cd7e998197'         -- Lyrische Suite
    UNION ALL SELECT 370, 'musicbrainz_work', '3c33dcc9-6204-4f93-bc9b-065c3ffb2406'         -- The Unanswered Question, S. 50
    UNION ALL SELECT 374, 'musicbrainz_work', 'e039120f-9a72-3d38-b885-5f9a6779e2c9'         -- Libertango
    UNION ALL SELECT 375, 'musicbrainz_work', 'f124195b-b3f2-3b47-af5c-f86e5cb7adff'         -- Oblivion
    UNION ALL SELECT 376, 'musicbrainz_work', '532643e5-b743-30b0-a623-1906b75d6524'         -- Adiós Nonino
    UNION ALL SELECT 377, 'musicbrainz_work', 'a289bd55-5684-4cbd-8482-3ac980ad0da9'         -- Las cuatro estaciones porteñas
    UNION ALL SELECT 379, 'musicbrainz_work', 'eb07cf62-985a-3f73-9595-2c45b95e1004'         -- Gnossienne no. 1 - Lent
    UNION ALL SELECT 380, 'musicbrainz_work', '9c6277dc-e1ae-31fa-aedb-db69491a0a45'         -- Je te veux
    UNION ALL SELECT 381, 'musicbrainz_work', '4f10d0d0-d644-463e-8791-c65b65d6ff36'         -- Sabre Dance, from the ballet Gayaneh
    UNION ALL SELECT 455, 'musicbrainz_work', 'aecd9670-5296-3ac9-9eef-a808bb8d29a3'         -- 10 Preludes, op. 23: No. 5 in G minor: Alla marcia
    UNION ALL SELECT 457, 'musicbrainz_work', '7c706500-059c-31ba-af16-05e8f8dacec6'         -- Tzigane (for violin and orchestra)
) incoming
WHERE EXISTS (
    SELECT 1 FROM (SELECT id FROM pieces) target WHERE target.id = incoming.p
)
AND NOT EXISTS (
    SELECT 1 FROM (SELECT piece_id, namespace FROM piece_identifiers) existing
    WHERE existing.piece_id = incoming.p AND existing.namespace = incoming.n
);
