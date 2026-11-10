-- 공용에 쓸 초상이 없던 작곡가의 얼굴 그림(애플 뮤직·스포티파이 아티스트 그림).
-- 원본: seed_pipeline/curation/entity-images-2026-11-10/ (gen_sql.py 로 만든다).
-- 초상·커버가 둘 다 비었을 때만 채운다. 그림은 각 서비스 서버를 그대로 가리킨다.
-- 권리자가 요청하면 그 작곡가의 avatar_url·cover_image_url 을 비운다.
-- composer 139 Jonathan Dove (https://music.apple.com/us/artist/109817485)
UPDATE composers SET avatar_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/fa/78/28/fa782882-0db5-8c1c-5ecb-ed7d7cb79874/mza_5532827681103775034.png/600x600bb.jpg', cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/fa/78/28/fa782882-0db5-8c1c-5ecb-ed7d7cb79874/mza_5532827681103775034.png/600x600bb.jpg'
WHERE id = 139 AND english_name = 'Jonathan Dove'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
-- composer 154 Mina Kubota (https://music.apple.com/us/artist/276212591)
UPDATE composers SET avatar_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/7b/34/ae/7b34ae13-e73e-dcac-0897-6b8d163a0f25/pr_source.png/600x600bb.jpg', cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Music112/v4/7b/34/ae/7b34ae13-e73e-dcac-0897-6b8d163a0f25/pr_source.png/600x600bb.jpg'
WHERE id = 154 AND english_name = 'Mina Kubota'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
-- composer 162 브렛 딘 (https://open.spotify.com/artist/3AcoRiEByWyGqrwM43nW4U)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/ab6772690000c46c49fa80c57e7e76d926c9bf45', cover_image_url = 'https://i.scdn.co/image/ab6772690000c46c49fa80c57e7e76d926c9bf45'
WHERE id = 162 AND english_name = 'Brett Dean'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
-- composer 203 J. A. C. Redford (https://music.apple.com/us/artist/494605)
UPDATE composers SET avatar_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/cd/77/ef/cd77ef55-838e-a994-fdf1-9f9d4195e059/ami-identity-5d8f02531bd6d8b9054b4409abc37db9-2026-07-24T15-20-38.040Z_cropped.png/600x600bb.jpg', cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/cd/77/ef/cd77ef55-838e-a994-fdf1-9f9d4195e059/ami-identity-5d8f02531bd6d8b9054b4409abc37db9-2026-07-24T15-20-38.040Z_cropped.png/600x600bb.jpg'
WHERE id = 203 AND english_name = 'J. A. C. Redford'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
-- composer 261 핏 스베르츠 (https://open.spotify.com/artist/2W1GQ7L5sCyUjewbnEr7ov)
UPDATE composers SET avatar_url = 'https://i.scdn.co/image/ab6761610000e5eb05e394ef3224d6dac7b29913', cover_image_url = 'https://i.scdn.co/image/ab6761610000e5eb05e394ef3224d6dac7b29913'
WHERE id = 261 AND english_name = 'Piet Swerts'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
-- composer 341 호아킨 로드리고 (https://music.apple.com/us/artist/293516)
UPDATE composers SET avatar_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/ff/fd/4a/fffd4aa7-bc0b-3ac9-d335-3edfc02c0f20/mza_8323668349852141167.png/600x600bb.jpg', cover_image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/ff/fd/4a/fffd4aa7-bc0b-3ac9-d335-3edfc02c0f20/mza_8323668349852141167.png/600x600bb.jpg'
WHERE id = 341 AND english_name = 'Joaquín Rodrigo'
  AND (avatar_url IS NULL OR avatar_url = '') AND (cover_image_url IS NULL OR cover_image_url = '');
