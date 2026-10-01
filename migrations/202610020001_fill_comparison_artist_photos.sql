-- 비교 화면에서 이니셜로 보이던 연주자 사진을 채운다.
--
-- 출처 순서: Apple Music 아티스트 사진 → Wikidata(P18)·위키백과 사진(Wikimedia Commons) → 공식 사이트·소속사 보도용 사진.
-- 2026-10-02 에 후보를 모아 한 장씩 눈으로 확인했다. 앨범 표지, 동명이인, 얼굴이 안 보이는 사진은 뺐다.
-- 지금 사진이 비어 있거나 열리지 않는 DuckDuckGo 프록시 주소일 때만 바꾼다. 누가 이미 고쳤으면 건드리지 않는다.
-- Commons 사진은 entity_images 에 작가·라이선스를 남긴다(연주자에 authority 가 있을 때).

-- 422 헤르베르트 폰 카라얀 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/2e/50/05/2e50059e-8013-f9d7-bc76-5743d5891e6c/pr_source.png/600x600bb.jpg'
WHERE id = 422
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 594 클라우디오 아바도 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/45/c8/9e/45c89ea0-b1eb-fde7-2af8-dbf6a2e4b037/mzl.nmelcrxn.jpg/600x600bb.jpg'
WHERE id = 594
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 605 레너드 번스타인 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/55/03/b9/5503b920-c3b7-e7d0-d1f4-eacac7fca992/pr_source.png/600x600bb.jpg'
WHERE id = 605
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 581 샤를 뒤투아 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/8f/37/30/8f373054-0a42-5c5e-d334-ccb865f5e351/mzl.yretwtqq.jpg/600x600bb.jpg'
WHERE id = 581
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 427 리카르도 무티 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/7a/e3/05/7ae30558-7a48-7a27-0b4c-60c0aa17fcfb/pr_source.png/600x600bb.jpg'
WHERE id = 427
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 370 블라디미르 아슈케나지 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/49/6a/87/496a87d2-5314-3362-2dd8-5e79163e80f3/mzl.rwieujrx.jpg/600x600bb.jpg'
WHERE id = 370
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 408 베르나르트 하이팅크 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/cb/6a/cd/cb6acda3-4b8c-518b-de76-a5b70303ab55/mzl.hmltygqf.jpg/600x600bb.jpg'
WHERE id = 408
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 573 장이브 티보데 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/83/9e/20/839e2041-ceea-a061-9a5c-f23eed268394/mzl.jmwvbgyn.jpg/600x600bb.jpg'
WHERE id = 573
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 575 오자와 세이지 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/85/69/15/85691593-54cf-ed97-c4d9-e725b0e57af3/mzl.hemuealy.jpg/600x600bb.jpg'
WHERE id = 575
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 630 마이클 틸슨 토머스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/1c/be/bc/1cbebc2d-4085-ea27-44cf-01d8e69e87f1/pr_source.png/600x600bb.jpg'
WHERE id = 630
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 632 다니엘 바렌보임 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/18/f1/fc/18f1fc88-fc39-e51b-7144-831c27623425/mza_13354598310532190852.png/600x600bb.jpg'
WHERE id = 632
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 574 주빈 메타 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/76/81/52/768152f6-4a5f-cfbc-5f14-aea9da0d5b58/mzl.hibsaqzn.jpg/600x600bb.jpg'
WHERE id = 574
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 607 에머슨 현악 4중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/df/8a/f6/df8af6c0-0408-73cc-fe87-53e8eef773cd/mzl.ekkgcpgg.jpg/600x600bb.jpg'
WHERE id = 607
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 634 앙드레 프레빈 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/c5/0d/a1/c50da1f9-e1ec-6815-c7eb-4b3519417500/mzl.mxqsukxb.jpg/600x600bb.jpg'
WHERE id = 634
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 601 카를 뵘 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/b3/5e/05/b35e0550-8285-4cfb-3b45-700a28295f03/mzl.sspptdrz.jpg/600x600bb.jpg'
WHERE id = 601
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 563 파스칼 로제 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/56/2b/6c/562b6cdc-82fe-2d4d-8af2-25a67a0f7626/pr_source.png/600x600bb.jpg'
WHERE id = 563
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 567 발렌티나 리시차 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/5e/03/da/5e03daa9-fce4-efcb-3188-9ff88fc74b62/mzl.cvpkvtze.jpg/600x600bb.jpg'
WHERE id = 567
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 561 카를로스 클라이버 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/f0/65/f4/f065f447-f50b-4632-f3da-01784591e856/mzl.zqiukguo.jpg/600x600bb.jpg'
WHERE id = 561
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 562 드미트리 시시킨 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/df/15/91/df1591e6-0378-23bd-7f3a-6eba145869ba/mzl.htyxhano.jpg/600x600bb.jpg'
WHERE id = 562
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 564 카티아 부니아티슈빌리 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/26/e6/63/26e663e3-e6ea-b4d3-8f7b-236f1f679b44/mzl.lqlrllhr.jpg/600x600bb.jpg'
WHERE id = 564
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 569 알리스 사라 오트 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/5c/41/6d/5c416d67-eef3-335f-e319-4be8759a8a4d/file_cropped.png/600x600bb.jpg'
WHERE id = 569
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 648 르노 카퓌송 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/4d/b3/d3/4db3d374-83af-5393-c507-a86153d93a12/mzl.xibforfw.jpg/600x600bb.jpg'
WHERE id = 648
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 734 므스티슬라프 로스트로포비치 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/94/51/51/94515123-7933-eace-4a51-5c3162f9ad45/mza_6543927750014925754.png/600x600bb.jpg'
WHERE id = 734
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 571 메나헴 프레슬러 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/0b/54/b7/0b54b73d-d429-b60e-9ba1-05360c5090a3/mzl.gscyeetk.jpg/600x600bb.jpg'
WHERE id = 571
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 399 마리아 조앙 피레스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/64/72/1e/64721ed6-ecb4-4384-bdb7-641b40c93c1c/file_cropped.png/600x600bb.jpg'
WHERE id = 399
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 570 알도 치콜리니 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/23/0a/55/230a55a4-191a-d6f8-424f-0a657e30e276/pr_source.png/600x600bb.jpg'
WHERE id = 570
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 642 알반 베르크 4중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/a5/50/c6/a550c63b-47a2-0167-9107-8b715b4b24d2/mzl.ivhxklon.jpg/600x600bb.jpg'
WHERE id = 642
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 716 하워드 셸리 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/44/73/8a/44738a83-b030-5fd9-5ca4-a22670d0305e/mzl.aittuyhj.png/600x600bb.jpg'
WHERE id = 716
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 649 디트리히 피셔디스카우 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/2d/64/f9/2d64f918-a18f-48dd-3af2-79703e970ff1/mzl.lmrmpuka.jpg/600x600bb.jpg'
WHERE id = 649
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 653 마티아스 괴르네 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/a8/47/1e/a8471e81-8a72-f39e-86fd-54d8957918e3/mzl.spelhtcx.jpg/600x600bb.jpg'
WHERE id = 653
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 602 쿠르트 마주어 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/70/bf/b5/70bfb50b-cab9-5c75-3af4-b22ec1b8d852/mzl.caiesjof.jpg/600x600bb.jpg'
WHERE id = 602
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 627 잔안드레아 노세다 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/f6/af/76/f6af769b-164c-aa0c-4056-2d03e3e6353e/mzl.ahwouosh.png/600x600bb.jpg'
WHERE id = 627
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 775 레너드 슬래트킨 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features123/v4/a8/65/bf/a865bf73-f00a-3aab-a451-0e4af701d02a/mzl.vqyjiqzs.png/600x600bb.jpg'
WHERE id = 775
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 736 로린 마젤 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/36/48/77/36487750-01fb-fc24-50a3-6d4009fe2a3e/mzl.ngklpaga.jpg/600x600bb.jpg'
WHERE id = 736
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 752 유진 오르만디 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/e1/40/fa/e140fa15-998b-2425-7b40-7a07588ebca5/mzl.oizlyelr.jpg/600x600bb.jpg'
WHERE id = 752
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 782 제임스 러바인 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/33/92/f8/3392f8e4-6300-efc0-5ff0-d9cbf6ab757f/mzl.jkcwpfta.jpg/600x600bb.jpg'
WHERE id = 782
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 371 레이프 오베 안스네스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/ef/32/4c/ef324ce3-652a-8c89-3c62-a7edf0481219/mzl.ppxcwies.jpg/600x600bb.jpg'
WHERE id = 371
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 665 니콜라우스 아르농쿠르 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/7e/45/c7/7e45c770-e31c-0dec-f9f4-1738cb59688a/mzl.ssklndst.jpg/600x600bb.jpg'
WHERE id = 665
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 640 아마데우스 4중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/5f/f6/6b/5ff66b5b-aa6e-2f82-37bc-5c856278912f/mzl.gkhbatzy.jpg/600x600bb.jpg'
WHERE id = 640
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 724 네마냐 라둘로비치 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/77/ec/2b/77ec2ba6-caa9-0ef2-a6ec-9d246a86e91d/ami-identity-170167eb2f5411e64e8f07349d7ac953-2026-01-26T13-14-31.748Z_cropped.png/600x600bb.jpg'
WHERE id = 724
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 681 크리스티안 게르하허 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features114/v4/dc/83/e6/dc83e6b4-675e-62cf-e125-e13e247c988b/mzl.ibblfyik.jpg/600x600bb.jpg'
WHERE id = 681
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 641 타카치 4중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/2b/cb/7a/2bcb7a25-0ed5-6741-8b36-7889559a1573/mzl.vogtmmgg.png/600x600bb.jpg'
WHERE id = 641
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 603 존 엘리엇 가디너 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/2f/a9/03/2fa903c6-b1f0-b560-e2d6-fbbea49d795d/mzl.hffieddx.jpg/600x600bb.jpg'
WHERE id = 603
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 674 플라시도 도밍고 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/3f/3b/d2/3f3bd2e8-9a7a-5552-9abf-800805a7baf2/mzl.lkujlxzv.png/600x600bb.jpg'
WHERE id = 674
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 749 키리 테 카나와 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/4f/f8/aa/4ff8aae7-c44d-20fe-90a1-98cd865a1b2f/mzl.txtcnkwk.jpg/600x600bb.jpg'
WHERE id = 749
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 565 니콜라이 루간스키 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/82/4a/6f/824a6faf-45b3-390a-dbfc-46814c71c99c/mzl.etlxqjpe.jpeg/600x600bb.jpg'
WHERE id = 565
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 622 앤드루 리턴 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/05/2d/37/052d377e-26c0-11cc-71cf-0081202fff9c/mzl.aeupdcsa.png/600x600bb.jpg'
WHERE id = 622
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 372 글렌 굴드 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/10/95/19/109519c7-1f5b-6711-48f4-5a7e79c6c07e/mza_862272063677079459.png/600x600bb.jpg'
WHERE id = 372
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 647 제러미 뎅크 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/d4/f1/59/d4f15958-b397-312d-e59a-1c1609471a9c/mzl.xzmduyxh.jpg/600x600bb.jpg'
WHERE id = 647
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 824 기돈 크레메르 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/68/47/e0/6847e0c0-aceb-038e-826c-6936d620288b/mzl.symapawu.jpg/600x600bb.jpg'
WHERE id = 824
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 817 네메 예르비 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/9c/28/58/9c2858dd-b75c-b684-1f59-2e55d9045f21/mzl.yjqxamkm.jpg/600x600bb.jpg'
WHERE id = 817
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 576 백건우 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/73/00/9e/73009e37-f150-9400-4b57-98caa477af52/pr_source.png/600x600bb.jpg'
WHERE id = 576
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 721 프레데리카 폰 슈타데 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/e8/7e/b2/e87eb2f8-6d81-a978-70e2-dda042fd7b34/mzl.sxkhkbmq.jpg/600x600bb.jpg'
WHERE id = 721
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 663 에디타 그루베로바 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/00/ee/c8/00eec82b-5b9f-da1a-764e-045d5f96e4ff/pr_source.png/600x600bb.jpg'
WHERE id = 663
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 590 윈턴 마샐리스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/d5/bb/ad/d5bbad45-cb3e-6334-ac5d-72442a0e822c/pr_source.png/600x600bb.jpg'
WHERE id = 590
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 707 시프리앵 카차리스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features114/v4/d2/d3/0b/d2d30bf4-5c75-cc67-db45-d73334160a12/mzl.aebqgedd.jpg/600x600bb.jpg'
WHERE id = 707
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 708 제임스 골웨이 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/86/b4/6b/86b46b9b-ed94-b486-b0ac-306360729544/mzl.rnwmyfie.jpg/600x600bb.jpg'
WHERE id = 708
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 695 앤서니 홀스테드 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/90/cd/1d/90cd1ded-f69e-8ebc-8284-82b7f24707ca/mza_17213936884851569093.png/600x600bb.jpg'
WHERE id = 695
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 696 사이먼 스탠디지 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/85/db/75/85db75b4-dfa4-3b3f-b681-817bf72ae27a/mzl.gxrpfcxl.jpg/600x600bb.jpg'
WHERE id = 696
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 726 안드레아스 오텐잠머 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/ae/7a/80/ae7a804d-6299-faf8-932a-aecaa89d65ac/pr_source.png/600x600bb.jpg'
WHERE id = 726
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 651 브린 터펠 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/7e/34/1f/7e341f1a-193d-c9e2-c4f0-96dba7e8e34b/mzl.cfmbvmwu.jpg/600x600bb.jpg'
WHERE id = 651
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 584 스미노 하야토 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features211/v4/36/4e/84/364e84b3-378f-d48a-1914-41c5f10e100e/mzl.wehdzqps.jpg/600x600bb.jpg'
WHERE id = 584
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 473 볼프강 자발리슈 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features114/v4/23/1f/7c/231f7c48-2cda-84cc-86cd-575d42ac3890/pr_source.png/600x600bb.jpg'
WHERE id = 473
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 759 이사타 카네메이슨 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features114/v4/3a/48/71/3a4871d8-c893-0cad-e8fd-c374fad1221f/mzl.ixoxgvsy.jpg/600x600bb.jpg'
WHERE id = 759
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 773 리사 바티아슈빌리 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/be/3a/03/be3a0364-2e2b-4c06-dd42-4cd0520333b8/mzl.uimgkxqs.jpg/600x600bb.jpg'
WHERE id = 773
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 825 호세 카레라스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/f7/28/59/f7285959-3415-a9de-81b4-96d70e68d26f/mzl.gmtmhzja.jpg/600x600bb.jpg'
WHERE id = 825
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 546 비토리오 그리골로 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features114/v4/4b/56/0b/4b560bf5-47d8-621e-17c5-c21380635969/mzl.ggkypfeb.jpg/600x600bb.jpg'
WHERE id = 546
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 741 몬테베르디 합창단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages211/v4/27/9e/4e/279e4e1c-2eb2-b33a-a041-0e3a83704db8/bc5f8907-4aec-49cc-97cf-464259901c5a_ami-identity-25ff60290a56b2481a3098830bab80d0-2024-04-08T10-52-11.308Z_cropped.png/600x600bb.jpg'
WHERE id = 741
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 738 프리츠 라이너 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/58/36/85/5836851a-3359-3db8-068a-7353e3c89059/mzl.amgrbhmt.jpg/600x600bb.jpg'
WHERE id = 738
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 612 잔루카 카시올리 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features71/v4/e0/3d/88/e03d8819-197d-e312-c58d-ade70867c4a3/mzl.zgmilspg.jpg/600x600bb.jpg'
WHERE id = 612
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 613 피터 서킨 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/61/50/04/61500481-6941-d463-daa0-436e213f891c/mzl.bwmwbesa.jpg/600x600bb.jpg'
WHERE id = 613
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 661 칼 데이비스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/81/0c/78/810c78da-74bb-98f9-ee05-5b93a390659c/mzl.itxyfhxx.jpg/600x600bb.jpg'
WHERE id = 661
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 804 길 샤함 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/5e/a7/1e/5ea71e06-a369-7dd1-337f-eaaae466bc39/pr_source.png/600x600bb.jpg'
WHERE id = 804
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 799 피에르 불레즈 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/91/0c/40/910c4034-e538-8500-b918-f7707c4a842c/mzl.ugzsysxc.jpg/600x600bb.jpg'
WHERE id = 799
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 803 이탈리아 4중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ab/07/5e/ab075e14-1aaf-6b84-876b-8dd291dd794a/mza_1909425759633556237.png/600x600bb.jpg'
WHERE id = 803
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 786 피에르로랑 에마르 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/13/f8/14/13f81449-a4dc-8af4-8b41-dacbd9d42347/pr_source.png/600x600bb.jpg'
WHERE id = 786
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 819 앨리슨 발솜 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/80/37/37/80373750-33ae-38f5-aa78-a5df05a5a470/mzl.rkulhgcf.jpg/600x600bb.jpg'
WHERE id = 819
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 820 에벤 4중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/9e/9e/60/9e9e60f4-fa6d-ccfa-19f1-5d36f7ba4b98/mzl.qsmhzsle.jpg/600x600bb.jpg'
WHERE id = 820
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 821 줄리언 로이드 웨버 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/49/34/29/493429ec-937f-6f6a-9e94-1591b02dd319/mzl.zjjmbphb.png/600x600bb.jpg'
WHERE id = 821
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 828 아라벨라 슈타인바허 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/b5/32/e7/b532e71c-0a98-7ebb-6408-35589cecd249/mzm.pqketbnv.jpeg/600x600bb.jpg'
WHERE id = 828
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 826 카렐 크라이엔호프 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features124/v4/94/1e/ff/941eff64-47f6-665d-34fe-a91a1f94b23b/pr_source.png/600x600bb.jpg'
WHERE id = 826
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 572 올가 셰프스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/10/3a/a9/103aa974-41c8-b809-bbd6-cc674c58b264/mzl.zlhwpthj.jpg/600x600bb.jpg'
WHERE id = 572
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 600 벤 골드샤이더 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages221/v4/13/3e/e8/133ee82d-87a1-e165-ed39-a7caeb6435ec/ami-identity-6c37264695d923f4812d58c4d4ec05da-2026-09-09T09-25-35.264Z_cropped.png/600x600bb.jpg'
WHERE id = 600
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 566 다비드 프레 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/08/41/74/08417426-07eb-42e2-b19c-8dc0100e98b4/mzl.ukhlzqwi.jpg/600x600bb.jpg'
WHERE id = 566
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 614 엘리자베트 레온스카야 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/0a/b5/9e/0ab59edf-56c2-57d5-042e-7d0159e16c2b/mzl.wgdlxzbg.jpg/600x600bb.jpg'
WHERE id = 614
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 664 게오르그 솔티 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/da/Sir_George_Solti_6_Allan_Allan_Warren.jpg/500px-Sir_George_Solti_6_Allan_Allan_Warren.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 664
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Sir_George_Solti_6_Allan_Allan_Warren.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/da/Sir_George_Solti_6_Allan_Allan_Warren.jpg/500px-Sir_George_Solti_6_Allan_Allan_Warren.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Allan warren', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Allan warren · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 664 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/da/Sir_George_Solti_6_Allan_Allan_Warren.jpg/500px-Sir_George_Solti_6_Allan_Allan_Warren.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 577 네빌 마리너 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ac/Neville-Marriner.jpg/500px-Neville-Marriner.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 577
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Neville-Marriner.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ac/Neville-Marriner.jpg/500px-Neville-Marriner.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Araceli Merino', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Araceli Merino · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 577 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/ac/Neville-Marriner.jpg/500px-Neville-Marriner.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 629 콜린 데이비스 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Sir_Colin_Davis.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 629
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Sir_Colin_Davis.jpg', 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Sir_Colin_Davis.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Colindavis.jpg: Urregoluis at en.wikipedia / *derivative work: Rabanus Flavus (talk)', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', 'Colindavis.jpg: Urregoluis at en.wikipedia / *derivative work: Rabanus Flavus (talk) · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 629 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/b/b3/Sir_Colin_Davis.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 568 윤디 리 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a8/Yundi_in_2019%2C_with_Steinway_Piano_%28cropped%29.jpg/500px-Yundi_in_2019%2C_with_Steinway_Piano_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 568
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Yundi_in_2019,_with_Steinway_Piano_(cropped).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a8/Yundi_in_2019%2C_with_Steinway_Piano_%28cropped%29.jpg/500px-Yundi_in_2019%2C_with_Steinway_Piano_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'ING远航ING', 'Attribution', '', 'ING远航ING · Attribution', TRUE, 'PUBLISHED'
FROM artists WHERE id = 568 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a8/Yundi_in_2019%2C_with_Steinway_Piano_%28cropped%29.jpg/500px-Yundi_in_2019%2C_with_Steinway_Piano_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 373 에밀 길렐스 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Emil_Gilels_by_Aram_Alban.jpg/500px-Emil_Gilels_by_Aram_Alban.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 373
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Emil_Gilels_by_Aram_Alban.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Emil_Gilels_by_Aram_Alban.jpg/500px-Emil_Gilels_by_Aram_Alban.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Aram Alban', 'Public domain', '', 'Aram Alban · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 373 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Emil_Gilels_by_Aram_Alban.jpg/500px-Emil_Gilels_by_Aram_Alban.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 583 파보 예르비 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/Frankfurter_Rundfunk-Symphonie-Orchester3_%28cropped%29.jpg/500px-Frankfurter_Rundfunk-Symphonie-Orchester3_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 583
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Frankfurter_Rundfunk-Symphonie-Orchester3_(cropped).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/Frankfurter_Rundfunk-Symphonie-Orchester3_%28cropped%29.jpg/500px-Frankfurter_Rundfunk-Symphonie-Orchester3_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Quincena Musical · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 583 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3b/Frankfurter_Rundfunk-Symphonie-Orchester3_%28cropped%29.jpg/500px-Frankfurter_Rundfunk-Symphonie-Orchester3_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 639 램버트 오키스 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5b/Lambert_Orkis_2021.jpg/500px-Lambert_Orkis_2021.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 639
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lambert_Orkis_2021.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5b/Lambert_Orkis_2021.jpg/500px-Lambert_Orkis_2021.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Quincena Musical · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 639 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5b/Lambert_Orkis_2021.jpg/500px-Lambert_Orkis_2021.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 369 안나 페도로바 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a9/AnnaFedorova.jpg/500px-AnnaFedorova.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 369
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:AnnaFedorova.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a9/AnnaFedorova.jpg/500px-AnnaFedorova.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'J. Bernardo Arcos Mijailidis', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'J. Bernardo Arcos Mijailidis · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 369 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a9/AnnaFedorova.jpg/500px-AnnaFedorova.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 636 데이비드 진먼 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d2/Tijdens_het_concert%2C_dirigent_Zinman_%28m_staand%29%2C_Bestanddeelnr_924-6523_%28cropped%29.jpg/500px-Tijdens_het_concert%2C_dirigent_Zinman_%28m_staand%29%2C_Bestanddeelnr_924-6523_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 636
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Tijdens_het_concert,_dirigent_Zinman_(m_staand),_Bestanddeelnr_924-6523_(cropped).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d2/Tijdens_het_concert%2C_dirigent_Zinman_%28m_staand%29%2C_Bestanddeelnr_924-6523_%28cropped%29.jpg/500px-Tijdens_het_concert%2C_dirigent_Zinman_%28m_staand%29%2C_Bestanddeelnr_924-6523_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Anefo · CC0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 636 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d2/Tijdens_het_concert%2C_dirigent_Zinman_%28m_staand%29%2C_Bestanddeelnr_924-6523_%28cropped%29.jpg/500px-Tijdens_het_concert%2C_dirigent_Zinman_%28m_staand%29%2C_Bestanddeelnr_924-6523_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 628 제임스 콘론 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d1/American_Conductor_James_Conlon.jpg/500px-American_Conductor_James_Conlon.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 628
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:American_Conductor_James_Conlon.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d1/American_Conductor_James_Conlon.jpg/500px-American_Conductor_James_Conlon.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Todd Rosenberg', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Todd Rosenberg · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 628 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/d1/American_Conductor_James_Conlon.jpg/500px-American_Conductor_James_Conlon.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 770 살바토레 아카르도 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4d/Salvatore_Accardo_%28cropped%29.JPG/500px-Salvatore_Accardo_%28cropped%29.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 770
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Salvatore_Accardo_(cropped).JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4d/Salvatore_Accardo_%28cropped%29.JPG/500px-Salvatore_Accardo_%28cropped%29.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Original:  Roberto de silva / Derivative work:  Danyele', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Original:  Roberto de silva / Derivative work:  Danyele · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 770 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4d/Salvatore_Accardo_%28cropped%29.JPG/500px-Salvatore_Accardo_%28cropped%29.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 810 로리스 체크나보리안 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/26/Loris_Tjeknavorian.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 810
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Loris_Tjeknavorian.jpg', 'https://upload.wikimedia.org/wikipedia/commons/2/26/Loris_Tjeknavorian.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Fakhradin Fakhraddini', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', 'Fakhradin Fakhraddini · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 810 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/26/Loris_Tjeknavorian.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 719 테레사 베르간사 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Teresa_Berganza_1957.jpg/500px-Teresa_Berganza_1957.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 719
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Teresa_Berganza_1957.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Teresa_Berganza_1957.jpg/500px-Teresa_Berganza_1957.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Indeciso42 at the Italian Wikipedia project.', 'Public domain', '', 'Indeciso42 at the Italian Wikipedia project. · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 719 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Teresa_Berganza_1957.jpg/500px-Teresa_Berganza_1957.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 720 베셀리나 카사로바 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/da/Vessi_OffenbachKonzert07_5.JPG/500px-Vessi_OffenbachKonzert07_5.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 720
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Vessi_OffenbachKonzert07_5.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/da/Vessi_OffenbachKonzert07_5.JPG/500px-Vessi_OffenbachKonzert07_5.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'The original uploader was Epinions Smorg at English Wikipedia.

(Original text: SP)', 'Attribution', '', 'The original uploader was Epinions Smorg at English Wikipedia.

(Original text: SP) · Attribution', TRUE, 'PUBLISHED'
FROM artists WHERE id = 720 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/da/Vessi_OffenbachKonzert07_5.JPG/500px-Vessi_OffenbachKonzert07_5.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 662 에리카 미클로샤 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/48/Miklosa_Erika.jpg/500px-Miklosa_Erika.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 662
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Miklosa_Erika.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/48/Miklosa_Erika.jpg/500px-Miklosa_Erika.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Unknown authorUnknown author', 'CC BY-SA 2.5', 'https://creativecommons.org/licenses/by-sa/2.5', 'Unknown authorUnknown author · CC BY-SA 2.5', TRUE, 'PUBLISHED'
FROM artists WHERE id = 662 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/48/Miklosa_Erika.jpg/500px-Miklosa_Erika.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 591 아돌프 허세스 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f3/Herseth.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 591
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Herseth.jpg', 'https://upload.wikimedia.org/wikipedia/commons/f/f3/Herseth.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Trphira', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Trphira · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 591 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/f/f3/Herseth.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 592 모리스 앙드레 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Maurice_Andr%C3%A9_%281969%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 592
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Maurice_Andr%C3%A9_(1969).jpg', 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Maurice_Andr%C3%A9_%281969%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'MC_Alain_&_Maurice_André_StD_1969.jpg: Centre Musical International Jean-Sébastien Bach
derivative work: Rabanus Flavus (talk)', 'CC BY-SA 1.0', 'https://creativecommons.org/licenses/by-sa/1.0', 'MC_Alain_&_Maurice_André_StD_1969.jpg: Centre Musical International Jean-Sébastien Bach
derivative work: Rabanus Flavus (talk) · CC BY-SA 1.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 592 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Maurice_Andr%C3%A9_%281969%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 689 한스크리스토프 라데만 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Hanschristophrademann_2018_04_24_%282%29_%28cropped%29.jpg/500px-Hanschristophrademann_2018_04_24_%282%29_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 689
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Hanschristophrademann_2018_04_24_(2)_(cropped).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Hanschristophrademann_2018_04_24_%282%29_%28cropped%29.jpg/500px-Hanschristophrademann_2018_04_24_%282%29_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Z thomas', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Z thomas · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 689 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/7f/Hanschristophrademann_2018_04_24_%282%29_%28cropped%29.jpg/500px-Hanschristophrademann_2018_04_24_%282%29_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 692 카를 뮌힝거 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/56/Bundesarchiv_B_145_Bild-F026295-0025%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg/500px-Bundesarchiv_B_145_Bild-F026295-0025%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 692
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bundesarchiv_B_145_Bild-F026295-0025,_Bonn,_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/56/Bundesarchiv_B_145_Bild-F026295-0025%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg/500px-Bundesarchiv_B_145_Bild-F026295-0025%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Jens Gathmann', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', 'Jens Gathmann · CC BY-SA 3.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 692 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/56/Bundesarchiv_B_145_Bild-F026295-0025%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg/500px-Bundesarchiv_B_145_Bild-F026295-0025%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 693 에두아르트 판 베이눔 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Eduard_van_Beinum_%281946%29.jpg/500px-Eduard_van_Beinum_%281946%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 693
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Eduard_van_Beinum_(1946).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Eduard_van_Beinum_%281946%29.jpg/500px-Eduard_van_Beinum_%281946%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Koos Raucamp / Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Koos Raucamp / Anefo · CC0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 693 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Eduard_van_Beinum_%281946%29.jpg/500px-Eduard_van_Beinum_%281946%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 404 Eduard Brunner · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c6/Eduard_Brunner.jpg/500px-Eduard_Brunner.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 404
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Eduard_Brunner.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c6/Eduard_Brunner.jpg/500px-Eduard_Brunner.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Margret Herdt, Osnabrück', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Margret Herdt, Osnabrück · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 404 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c6/Eduard_Brunner.jpg/500px-Eduard_Brunner.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 731 갈리나 비슈넵스카야 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8b/Galina_Vishnevskaya.jpg/500px-Galina_Vishnevskaya.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 731
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Galina_Vishnevskaya.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8b/Galina_Vishnevskaya.jpg/500px-Galina_Vishnevskaya.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Alexey Yushenkov', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Alexey Yushenkov · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 731 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8b/Galina_Vishnevskaya.jpg/500px-Galina_Vishnevskaya.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 737 조르주 프레트르 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0e/Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg/500px-Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 737
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0e/Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg/500px-Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Ermell', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Ermell · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 737 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0e/Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg/500px-Georges_Pretre_1989_Garmisch-19890625-RM-113345.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 740 모라 림파니 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/60/Dame_Moura_Limpany_Allan_Warren.jpg/500px-Dame_Moura_Limpany_Allan_Warren.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 740
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Dame_Moura_Limpany_Allan_Warren.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/60/Dame_Moura_Limpany_Allan_Warren.jpg/500px-Dame_Moura_Limpany_Allan_Warren.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Allan warren', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Allan warren · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 740 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/60/Dame_Moura_Limpany_Allan_Warren.jpg/500px-Dame_Moura_Limpany_Allan_Warren.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 739 루돌프 피르쿠슈니 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/31/Rudolf_Firku%C5%A1n%C3%BD_1960.jpg/500px-Rudolf_Firku%C5%A1n%C3%BD_1960.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 739
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rudolf_Firku%C5%A1n%C3%BD_1960.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/31/Rudolf_Firku%C5%A1n%C3%BD_1960.jpg/500px-Rudolf_Firku%C5%A1n%C3%BD_1960.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Joop van Bilsen for Anefo', 'CC BY-SA 3.0 nl', 'https://creativecommons.org/licenses/by-sa/3.0/nl/deed.en', 'Joop van Bilsen for Anefo · CC BY-SA 3.0 nl', TRUE, 'PUBLISHED'
FROM artists WHERE id = 739 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/31/Rudolf_Firku%C5%A1n%C3%BD_1960.jpg/500px-Rudolf_Firku%C5%A1n%C3%BD_1960.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 753 바버라 헨드릭스 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f1/Barbara_Henricks_%28Flickr%29.jpg/500px-Barbara_Henricks_%28Flickr%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 753
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Barbara_Henricks_(Flickr).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f1/Barbara_Henricks_%28Flickr%29.jpg/500px-Barbara_Henricks_%28Flickr%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Wouter Hogendorp', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Wouter Hogendorp · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 753 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f1/Barbara_Henricks_%28Flickr%29.jpg/500px-Barbara_Henricks_%28Flickr%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 557 Christopher O'Riley · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1a/From_the_Top_%28NPR%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 557
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:From_the_Top_(NPR).jpg', 'https://upload.wikimedia.org/wikipedia/commons/1/1a/From_the_Top_%28NPR%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'NEA photographer David Balsom', 'Public domain', '', 'NEA photographer David Balsom · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 557 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/1/1a/From_the_Top_%28NPR%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 805 데이비드 크라카워 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e2/David_Krakauer_Treibhaus_2009.JPG/500px-David_Krakauer_Treibhaus_2009.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 805
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:David_Krakauer_Treibhaus_2009.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e2/David_Krakauer_Treibhaus_2009.JPG/500px-David_Krakauer_Treibhaus_2009.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Svíčková', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Svíčková · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 805 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e2/David_Krakauer_Treibhaus_2009.JPG/500px-David_Krakauer_Treibhaus_2009.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 806 이본 로리오 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Loriod_Caen.jpg/500px-Loriod_Caen.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 806
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Loriod_Caen.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Loriod_Caen.jpg/500px-Loriod_Caen.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Agence26', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Agence26 · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 806 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Loriod_Caen.jpg/500px-Loriod_Caen.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 798 크리스토프 폰 도흐나니 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/22/Christoph-von-Dohn%C3%A1nyi-cropped.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 798
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Christoph-von-Dohn%C3%A1nyi-cropped.png', 'https://upload.wikimedia.org/wikipedia/commons/2/22/Christoph-von-Dohn%C3%A1nyi-cropped.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Christian Michelides', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Christian Michelides · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 798 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/2/22/Christoph-von-Dohn%C3%A1nyi-cropped.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 801 아르디티 4중주단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/eb/Arditti_Quartet_%287936697196%29.jpg/500px-Arditti_Quartet_%287936697196%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 801
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Arditti_Quartet_(7936697196).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/eb/Arditti_Quartet_%287936697196%29.jpg/500px-Arditti_Quartet_%287936697196%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Quincena Musical', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Quincena Musical · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 801 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/eb/Arditti_Quartet_%287936697196%29.jpg/500px-Arditti_Quartet_%287936697196%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 785 미하엘 길렌 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/03/Urauff%C3%BChrung_der_Oper_%22Ein_Traumspiel%22_von_Komponist_Aribert_Reimann_%28Kiel_35.663%29_%28cropped_to_Michael_Gielen%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 785
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Urauff%C3%BChrung_der_Oper_%22Ein_Traumspiel%22_von_Komponist_Aribert_Reimann_(Kiel_35.663)_(cropped_to_Michael_Gielen).jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/03/Urauff%C3%BChrung_der_Oper_%22Ein_Traumspiel%22_von_Komponist_Aribert_Reimann_%28Kiel_35.663%29_%28cropped_to_Michael_Gielen%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Magnussen, Friedrich (1914-1987)', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', 'Magnussen, Friedrich (1914-1987) · CC BY-SA 3.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 785 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/03/Urauff%C3%BChrung_der_Oper_%22Ein_Traumspiel%22_von_Komponist_Aribert_Reimann_%28Kiel_35.663%29_%28cropped_to_Michael_Gielen%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 809 겐나디 로즈데스트벤스키 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/81/Rozhdestvensky.jpg/500px-Rozhdestvensky.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 809
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Rozhdestvensky.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/81/Rozhdestvensky.jpg/500px-Rozhdestvensky.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Leo Medvedev/Лев Леонидович Медведев', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Leo Medvedev/Лев Леонидович Медведев · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 809 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/81/Rozhdestvensky.jpg/500px-Rozhdestvensky.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 549 루지에로 리치 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8a/Ruggiero_Ricci_%28Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele%2C_1932%29_%E2%80%93_crop.jpg/500px-Ruggiero_Ricci_%28Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele%2C_1932%29_%E2%80%93_crop.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 549
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Ruggiero_Ricci_(Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele,_1932)_%E2%80%93_crop.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8a/Ruggiero_Ricci_%28Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele%2C_1932%29_%E2%80%93_crop.jpg/500px-Ruggiero_Ricci_%28Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele%2C_1932%29_%E2%80%93_crop.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Aladár Székely', 'Public domain', '', 'Aladár Székely · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 549 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8a/Ruggiero_Ricci_%28Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele%2C_1932%29_%E2%80%93_crop.jpg/500px-Ruggiero_Ricci_%28Sz%C3%A9kely_Alad%C3%A1r_felv%C3%A9tele%2C_1932%29_%E2%80%93_crop.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 598 배리 터크웰 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0c/Barry_Tuckwell_%28BT03%29_%28Photographer%3DTerry_Lane%29.jpg/500px-Barry_Tuckwell_%28BT03%29_%28Photographer%3DTerry_Lane%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 598
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Barry_Tuckwell_(BT03)_(Photographer%3DTerry_Lane).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0c/Barry_Tuckwell_%28BT03%29_%28Photographer%3DTerry_Lane%29.jpg/500px-Barry_Tuckwell_%28BT03%29_%28Photographer%3DTerry_Lane%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Terry Lane', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Terry Lane · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 598 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0c/Barry_Tuckwell_%28BT03%29_%28Photographer%3DTerry_Lane%29.jpg/500px-Barry_Tuckwell_%28BT03%29_%28Photographer%3DTerry_Lane%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 623 클라라 하스킬 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c3/Clara_Haskil_59.jpg/500px-Clara_Haskil_59.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 623
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Clara_Haskil_59.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c3/Clara_Haskil_59.jpg/500px-Clara_Haskil_59.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Indeciso42 at the Italian Wikipedia project.', 'Public domain', '', 'Indeciso42 at the Italian Wikipedia project. · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 623 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c3/Clara_Haskil_59.jpg/500px-Clara_Haskil_59.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 585 마린 올솝 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ce/a7/e1/cea7e18d-9aab-9179-895d-3df033667140/mzl.qfwfdomm.png/600x600bb.jpg'
WHERE id = 585
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 617 말러 체임버 오케스트라 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/67/15/9a/67159a23-d7d9-b2c9-b3d4-851190c9ff3b/pr_source.png/600x600bb.jpg'
WHERE id = 617
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 619 다니엘 하딩 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/82/f3/8d/82f38d61-ad7d-9a9f-b568-36fde6be8a14/mzl.skmryvbi.png/600x600bb.jpg'
WHERE id = 619
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 621 유럽 체임버 오케스트라 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/b6/d1/9c/b6d19cf7-308d-b37b-a33b-9f8b094d66af/pr_source.png/600x600bb.jpg'
WHERE id = 621
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 780 런던 필하모닉 오케스트라 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/98/52/4a/98524a9e-9b61-95ef-f188-f71a98e6cb7c/mza_10592736941068631586.png/600x600bb.jpg'
WHERE id = 780
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 755 미셸 달베르토 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/48/ff/e8/48ffe837-29f1-d85e-a64f-5c26113325e5/mzl.guyghtun.jpg/600x600bb.jpg'
WHERE id = 755
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 814 왕립 스코틀랜드 국립 관현악단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/06/3a/27/063a27cf-8206-6291-c80c-de458c852b8b/mzl.nqhcrldh.jpg/600x600bb.jpg'
WHERE id = 814
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 644 린 하렐 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/a8/d9/ba/a8d9ba58-1293-23b1-6ab6-d3db7bb2ded2/pr_source.png/600x600bb.jpg'
WHERE id = 644
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 631 스웨덴 체임버 오케스트라 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/c4/41/88/c441884b-f57e-50bd-0e4a-6d5b07236afb/mzl.bwzjcrim.png/600x600bb.jpg'
WHERE id = 631
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 710 트레버 피노크 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/cb/f1/bd/cbf1bd94-6b07-2dca-84ec-0bd19d498ac0/mzl.xxwyxtpg.jpg/600x600bb.jpg'
WHERE id = 710
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 705 RIAS 실내합창단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/a0/08/9d/a0089d36-f55b-1817-a8e8-f8c687379dd5/mzl.ajcsawiu.jpg/600x600bb.jpg'
WHERE id = 705
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 697 베를린 고음악 아카데미 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features112/v4/c3/6d/41/c36d41f6-5c07-ee28-4d17-db1b7ed08741/mzl.oxlwwvyc.jpg/600x600bb.jpg'
WHERE id = 697
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 704 아카데미 오브 에인션트 뮤직 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages113/v4/50/0e/e4/500ee45d-5cf4-5d78-0686-e3879d4a1976/0c082f99-55e1-44e5-bb01-d388ccfa2c05_ami-identity-fe94bf321a7975fdd0bddad3a41d73d4-2023-01-24T12-52-52.931Z_cropped.png/600x600bb.jpg'
WHERE id = 704
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 683 그레이엄 존슨 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features/v4/d1/f6/27/d1f6279d-bcb9-0793-c817-a5ed1cc06002/mzl.xdqzmstp.png/600x600bb.jpg'
WHERE id = 683
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 652 맬컴 마티노 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features114/v4/a5/bb/09/a5bb099d-0503-21da-bb3e-12087ca88a5c/mzl.tmhpjzdr.png/600x600bb.jpg'
WHERE id = 652
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 684 크리스토프 에셴바흐 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/33/cd/d5/33cdd5cc-4027-6a91-01a7-72577c71c2a2/mzl.ukqwwlwk.jpg/600x600bb.jpg'
WHERE id = 684
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 678 안젤라 게오르기우 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/fa/0d/a0/fa0da089-1ab6-f545-3a8f-9369014eb10f/mzl.hzgmosuo.jpg/600x600bb.jpg'
WHERE id = 678
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 676 로베르토 알라냐 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/a2/cf/e0/a2cfe015-dc02-1a52-9aa0-1daee81e5331/mzl.xqgvmepj.jpg/600x600bb.jpg'
WHERE id = 676
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 680 산타 체칠리아 국립음악원 관현악단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/6c/1d/cc/6c1dcccf-1488-a4b9-e650-8a60cebe183f/mzl.kurhskzl.jpg/600x600bb.jpg'
WHERE id = 680
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 777 로런스 포스터 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/da/d8/40/dad840e8-17ce-acf1-d984-c1a27040b8b4/mzl.xnjnmbad.png/600x600bb.jpg'
WHERE id = 777
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 769 파블로 페란데스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/1a/0e/38/1a0e38d3-4a43-f4fc-a933-90b5cccdd788/pr_source.png/600x600bb.jpg'
WHERE id = 769
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 767 보자르 삼중주단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features125/v4/6a/f1/3b/6af13b24-4963-4594-ff41-15f22e8b7fb9/pr_source.png/600x600bb.jpg'
WHERE id = 767
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 762 로열 리버풀 필하모닉 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/ca/a7/11/caa71170-ba6a-0e94-0697-30e58223eb22/mzl.iunphlyj.jpg/600x600bb.jpg'
WHERE id = 762
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 744 스티븐 레이턴 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features/v4/65/ae/b5/65aeb539-e11f-d72e-d5a4-1b5cd7b0320b/mzl.lwykdmuo.png/600x600bb.jpg'
WHERE id = 744
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 757 캐스린 스톳 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features122/v4/18/ad/ee/18adee00-19fc-691d-a9af-21ef00371895/mzl.xmbbayfu.jpg/600x600bb.jpg'
WHERE id = 757
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 754 알렉상드르 타로 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features221/v4/8f/4b/6f/8f4b6f6e-3b7d-8a23-9f09-e9dd110549c0/mzl.ujrqtvan.jpg/600x600bb.jpg'
WHERE id = 754
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 831 로저 비뇰스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features4/v4/c8/10/c7/c810c7bb-aa87-f0fd-0ad2-cc55cb5a84e8/mzl.mrucuvey.png/600x600bb.jpg'
WHERE id = 831
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 795 버밍엄 시립교향악단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/8c/cb/01/8ccb01e5-09a4-1474-0926-74cb4448ca04/mza_17060152648662637850.png/600x600bb.jpg'
WHERE id = 795
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 792 런던 심포니 합창단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/9c/03/10/9c0310f5-c982-42f5-fa6c-400ca93200e0/mzl.xpzxiwse.png/600x600bb.jpg'
WHERE id = 792
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 808 파리 국립오페라 관현악단 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/f1/41/33/f1413363-d4b1-8abf-24dd-d9ba1f0c1607/mza_589639368945842121.png/600x600bb.jpg'
WHERE id = 808
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 788 댈러스 심포니 오케스트라 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/AMCArtistImages211/v4/02/08/b8/0208b896-36a1-e2af-8560-e3aa774c1217/ami-identity-5b3ba4da7aaeca5e89b2bc19cbd5159a-2025-11-21T13-42-06.827Z_cropped.png/600x600bb.jpg'
WHERE id = 788
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 643 미하엘 바렌보임 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features116/v4/d1/97/65/d19765cf-952b-5c4b-be37-bac42d167910/mzl.fxfgerqr.jpg/600x600bb.jpg'
WHERE id = 643
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 645 빅토리아 물로바 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/f6/18/c4/f618c432-c006-f2c9-6b65-229cacbf5b81/mzl.kwhcczhx.jpg/600x600bb.jpg'
WHERE id = 645
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 626 토마스 헹엘브로크 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features115/v4/e7/7b/7d/e77b7dee-b776-20a2-de41-c93dff78414d/mzl.fqfkdrmo.jpg/600x600bb.jpg'
WHERE id = 626
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 615 테오도르 쿠렌치스 · apple
UPDATE artists SET image_url = 'https://is1-ssl.mzstatic.com/image/thumb/Features126/v4/33/0a/40/330a4097-9477-3e95-ad9e-9c815fe8083c/mzl.nwzbnfyw.jpg/600x600bb.jpg'
WHERE id = 615
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');

-- 324 보스턴 심포니 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg/500px-Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 324
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg/500px-Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Nathaniel Stebbins', 'Public domain', '', 'Nathaniel Stebbins · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 324 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg/500px-Nathaniel_Livermore_Stebbins_Boston_Symphony_Orchestra_1891.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 578 아카데미 오브 세인트 마틴 인 더 필즈 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/df/Academy_of_St._Martin_in_the_Fields.JPG/500px-Academy_of_St._Martin_in_the_Fields.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 578
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Academy_of_St._Martin_in_the_Fields.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/df/Academy_of_St._Martin_in_the_Fields.JPG/500px-Academy_of_St._Martin_in_the_Fields.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Gudrun Meyer', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Gudrun Meyer · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 578 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/df/Academy_of_St._Martin_in_the_Fields.JPG/500px-Academy_of_St._Martin_in_the_Fields.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 364 몬트리올 심포니 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f6/Orchestre_symphonique_de_Montreal_1934.jpg/500px-Orchestre_symphonique_de_Montreal_1934.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 364
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Orchestre_symphonique_de_Montreal_1934.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f6/Orchestre_symphonique_de_Montreal_1934.jpg/500px-Orchestre_symphonique_de_Montreal_1934.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Wm. Notman & Son', 'Public domain', '', 'Wm. Notman & Son · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 364 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f6/Orchestre_symphonique_de_Montreal_1934.jpg/500px-Orchestre_symphonique_de_Montreal_1934.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 357 필라델피아 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg/500px-Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 357
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg/500px-Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', '北京驱动文化传媒有限公司', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '北京驱动文化传媒有限公司 · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 357 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/26/Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg/500px-Charles_Dutoit_and_the_Philadelphia_Orchestra_concert_in_Tianjin.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 327 라이프치히 게반트하우스 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/ba/AN_Totale-Konzert_02-06-17_0519_AdobeRGB%284275%29.jpg/500px-AN_Totale-Konzert_02-06-17_0519_AdobeRGB%284275%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 327
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:AN_Totale-Konzert_02-06-17_0519_AdobeRGB(4275).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/ba/AN_Totale-Konzert_02-06-17_0519_AdobeRGB%284275%29.jpg/500px-AN_Totale-Konzert_02-06-17_0519_AdobeRGB%284275%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Jens Gerber', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Jens Gerber · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 327 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/ba/AN_Totale-Konzert_02-06-17_0519_AdobeRGB%284275%29.jpg/500px-AN_Totale-Konzert_02-06-17_0519_AdobeRGB%284275%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 587 안드레스 오로스코에스트라다 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/04/Andres_Orozco_Estrada.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 587
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Andres_Orozco_Estrada.jpg', 'https://upload.wikimedia.org/wikipedia/commons/0/04/Andres_Orozco_Estrada.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Bastisinger', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Bastisinger · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 587 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/04/Andres_Orozco_Estrada.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 349 오슬로 필하모닉 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e0/Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg/500px-Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 349
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e0/Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg/500px-Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Hans A. Rosbach', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Hans A. Rosbach · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 349 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e0/Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg/500px-Oslo-Filharmonien_-_Johan_Svendsen_Norsk_kunstnerkarneval_-_Vasily_Petrenko_conducting-_20110219-1.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 588 북서독일 필하모니 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c1/Nordwestdeutsche_Philharmonie%2C_Kurhaus_Bad_Hamm%2C_tuning_before_Mahler%27s_First_Symphony.jpg/500px-Nordwestdeutsche_Philharmonie%2C_Kurhaus_Bad_Hamm%2C_tuning_before_Mahler%27s_First_Symphony.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 588
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Nordwestdeutsche_Philharmonie,_Kurhaus_Bad_Hamm,_tuning_before_Mahler%27s_First_Symphony.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c1/Nordwestdeutsche_Philharmonie%2C_Kurhaus_Bad_Hamm%2C_tuning_before_Mahler%27s_First_Symphony.jpg/500px-Nordwestdeutsche_Philharmonie%2C_Kurhaus_Bad_Hamm%2C_tuning_before_Mahler%27s_First_Symphony.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Gerda Arendt', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Gerda Arendt · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 588 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c1/Nordwestdeutsche_Philharmonie%2C_Kurhaus_Bad_Hamm%2C_tuning_before_Mahler%27s_First_Symphony.jpg/500px-Nordwestdeutsche_Philharmonie%2C_Kurhaus_Bad_Hamm%2C_tuning_before_Mahler%27s_First_Symphony.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 677 로열 오페라하우스 관현악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/61/Oedipe_%28opera%29_at_Royal_Opera_House_in_London_-_standing_ovations.jpg/500px-Oedipe_%28opera%29_at_Royal_Opera_House_in_London_-_standing_ovations.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 677
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Oedipe_(opera)_at_Royal_Opera_House_in_London_-_standing_ovations.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/61/Oedipe_%28opera%29_at_Royal_Opera_House_in_London_-_standing_ovations.jpg/500px-Oedipe_%28opera%29_at_Royal_Opera_House_in_London_-_standing_ovations.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Walej', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Walej · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 677 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/61/Oedipe_%28opera%29_at_Royal_Opera_House_in_London_-_standing_ovations.jpg/500px-Oedipe_%28opera%29_at_Royal_Opera_House_in_London_-_standing_ovations.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 580 카펠라 이스트로폴리타나 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/29/Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg/500px-Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 580
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/29/Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg/500px-Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Gryffindor', 'CC BY 2.5', 'https://creativecommons.org/licenses/by/2.5', 'Gryffindor · CC BY 2.5', TRUE, 'PUBLISHED'
FROM artists WHERE id = 580 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/29/Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg/500px-Slovensk%C3%A1_Filharm%C3%B3nia_Bratislava_October_2006_041.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 597 뮌헨 체임버 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ed/MUENCHENERKAMMERORCHESTER2008.JPG/500px-MUENCHENERKAMMERORCHESTER2008.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 597
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:MUENCHENERKAMMERORCHESTER2008.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ed/MUENCHENERKAMMERORCHESTER2008.JPG/500px-MUENCHENERKAMMERORCHESTER2008.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Andreas Fleischmann', 'CC BY-SA 2.0 de', 'https://creativecommons.org/licenses/by-sa/2.0/de/deed.en', 'Andreas Fleischmann · CC BY-SA 2.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 597 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ed/MUENCHENERKAMMERORCHESTER2008.JPG/500px-MUENCHENERKAMMERORCHESTER2008.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 747 베를린 방송합창단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fc/Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg/500px-Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 747
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fc/Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg/500px-Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'A.Savin', 'FAL', 'http://artlibre.org/licence/lal/en', 'A.Savin · FAL', TRUE, 'PUBLISHED'
FROM artists WHERE id = 747 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fc/Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg/500px-Berliner_Philharmoniker_at_Brandenburg_Gate_asv2019-08-24_img08.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 343 파리 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/83/Klaus_M%C3%A4kel%C3%A4.jpg/500px-Klaus_M%C3%A4kel%C3%A4.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 343
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Klaus_M%C3%A4kel%C3%A4.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/83/Klaus_M%C3%A4kel%C3%A4.jpg/500px-Klaus_M%C3%A4kel%C3%A4.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Clevnax', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Clevnax · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 343 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/83/Klaus_M%C3%A4kel%C3%A4.jpg/500px-Klaus_M%C3%A4kel%C3%A4.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 669 뮌헨 방송관현악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b3/2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg/500px-2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 669
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b3/2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg/500px-2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Stefan Brending (2eight)', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', 'Stefan Brending (2eight) · CC BY-SA 3.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 669 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b3/2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg/500px-2018_Sternstunden-Gala_-_Muenchner_Rundfunkorchester_-_by_2eight_-_8SC4525.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 604 이스라엘 필하모닉 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/88/Israel_Philharmonic_Orchestra.jpg/500px-Israel_Philharmonic_Orchestra.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 604
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Israel_Philharmonic_Orchestra.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/88/Israel_Philharmonic_Orchestra.jpg/500px-Israel_Philharmonic_Orchestra.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Yeugene', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Yeugene · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 604 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/88/Israel_Philharmonic_Orchestra.jpg/500px-Israel_Philharmonic_Orchestra.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 637 볼티모어 심포니 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/db/Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore%2C_November_2024.jpg/500px-Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore%2C_November_2024.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 637
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore,_November_2024.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/db/Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore%2C_November_2024.jpg/500px-Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore%2C_November_2024.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Ser Amantio di Nicolao', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Ser Amantio di Nicolao · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 637 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/d/db/Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore%2C_November_2024.jpg/500px-Baltimore_Symphony_Orchestra_prior_to_a_concert_at_Strathmore%2C_November_2024.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 713 포츠담 실내악 아카데미 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/cd/Kammerakademie_Potsdam_Querformat.jpg/500px-Kammerakademie_Potsdam_Querformat.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 713
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kammerakademie_Potsdam_Querformat.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/cd/Kammerakademie_Potsdam_Querformat.jpg/500px-Kammerakademie_Potsdam_Querformat.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Wikikap', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Wikikap · CC BY 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 713 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/cd/Kammerakademie_Potsdam_Querformat.jpg/500px-Kammerakademie_Potsdam_Querformat.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 650 제럴드 무어 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/14/Gerald-Moore-1968.jpg/500px-Gerald-Moore-1968.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 650
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gerald-Moore-1968.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/14/Gerald-Moore-1968.jpg/500px-Gerald-Moore-1968.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'AnonymousUnknown author', 'Public domain', '', 'AnonymousUnknown author · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 650 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/14/Gerald-Moore-1968.jpg/500px-Gerald-Moore-1968.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 682 게롤트 후버 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/23/Gerold_Huber.jpg/500px-Gerold_Huber.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 682
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Gerold_Huber.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/23/Gerold_Huber.jpg/500px-Gerold_Huber.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Orgelputzer', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', 'Orgelputzer · CC BY 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 682 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/23/Gerold_Huber.jpg/500px-Gerold_Huber.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 811 아르메니아 필하모닉 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8d/Eduard-Topchyan.jpg/500px-Eduard-Topchyan.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 811
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Eduard-Topchyan.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8d/Eduard-Topchyan.jpg/500px-Eduard-Topchyan.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', '23artashes', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', '23artashes · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 811 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/8d/Eduard-Topchyan.jpg/500px-Eduard-Topchyan.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 722 유타 심포니 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/54/Utah_symphony_at_Abravanel_Hall.jpg/500px-Utah_symphony_at_Abravanel_Hall.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 722
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Utah_symphony_at_Abravanel_Hall.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/54/Utah_symphony_at_Abravanel_Hall.jpg/500px-Utah_symphony_at_Abravanel_Hall.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Ricardo630', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Ricardo630 · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 722 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/54/Utah_symphony_at_Abravanel_Hall.jpg/500px-Utah_symphony_at_Abravanel_Hall.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 688 샤를로테 마르히오노 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b0/Charlotte_Margiono_%281968%29%2C_Bestanddeelnr_921-7963.jpg/500px-Charlotte_Margiono_%281968%29%2C_Bestanddeelnr_921-7963.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 688
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Charlotte_Margiono_(1968),_Bestanddeelnr_921-7963.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b0/Charlotte_Margiono_%281968%29%2C_Bestanddeelnr_921-7963.jpg/500px-Charlotte_Margiono_%281968%29%2C_Bestanddeelnr_921-7963.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Eric Koch for Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Eric Koch for Anefo · CC0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 688 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b0/Charlotte_Margiono_%281968%29%2C_Bestanddeelnr_921-7963.jpg/500px-Charlotte_Margiono_%281968%29%2C_Bestanddeelnr_921-7963.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 402 캐슬린 배틀 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Kathleen_Battle.jpg/500px-Kathleen_Battle.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 402
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Kathleen_Battle.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Kathleen_Battle.jpg/500px-Kathleen_Battle.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Kingkongphoto & www.celebrity-photos.com from Laurel  Maryland, USA', 'CC BY-SA 2.0', 'https://creativecommons.org/licenses/by-sa/2.0', 'Kingkongphoto & www.celebrity-photos.com from Laurel  Maryland, USA · CC BY-SA 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 402 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/66/Kathleen_Battle.jpg/500px-Kathleen_Battle.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 686 셰릴 스튜더 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/34/Cheryl_Studer_in_Die_Fledermaus.jpg/500px-Cheryl_Studer_in_Die_Fledermaus.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 686
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Cheryl_Studer_in_Die_Fledermaus.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/34/Cheryl_Studer_in_Die_Fledermaus.jpg/500px-Cheryl_Studer_in_Die_Fledermaus.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Eddy Seesing', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Eddy Seesing · CC BY 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 686 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/34/Cheryl_Studer_in_Die_Fledermaus.jpg/500px-Cheryl_Studer_in_Die_Fledermaus.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 666 취리히 오페라 관현악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/21/Philharmonia_Z%C3%BCrich_II.jpg/500px-Philharmonia_Z%C3%BCrich_II.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 666
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Philharmonia_Z%C3%BCrich_II.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/21/Philharmonia_Z%C3%BCrich_II.jpg/500px-Philharmonia_Z%C3%BCrich_II.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Dominic Büttner', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', 'Dominic Büttner · CC BY-SA 3.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 666 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/21/Philharmonia_Z%C3%BCrich_II.jpg/500px-Philharmonia_Z%C3%BCrich_II.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 620 크리스티안 차하리아스 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Christian_Zacharias_%282862528424%29.jpg/500px-Christian_Zacharias_%282862528424%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 620
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Christian_Zacharias_(2862528424).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Christian_Zacharias_%282862528424%29.jpg/500px-Christian_Zacharias_%282862528424%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'MITO SettembreMusica', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'MITO SettembreMusica · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 620 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Christian_Zacharias_%282862528424%29.jpg/500px-Christian_Zacharias_%282862528424%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 633 잉글리시 체임버 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/42/Arimany-EnglishChamberOrchestra-008.jpg/500px-Arimany-EnglishChamberOrchestra-008.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 633
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Arimany-EnglishChamberOrchestra-008.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/42/Arimany-EnglishChamberOrchestra-008.jpg/500px-Arimany-EnglishChamberOrchestra-008.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Claudiarimany', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Claudiarimany · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 633 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/42/Arimany-EnglishChamberOrchestra-008.jpg/500px-Arimany-EnglishChamberOrchestra-008.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 701 슈투트가르트 체임버 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/83/Bundesarchiv_B_145_Bild-F026295-0021%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg/500px-Bundesarchiv_B_145_Bild-F026295-0021%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 701
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Bundesarchiv_B_145_Bild-F026295-0021,_Bonn,_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/83/Bundesarchiv_B_145_Bild-F026295-0021%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg/500px-Bundesarchiv_B_145_Bild-F026295-0021%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Jens Gathmann', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', 'Jens Gathmann · CC BY-SA 3.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 701 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/83/Bundesarchiv_B_145_Bild-F026295-0021%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg/500px-Bundesarchiv_B_145_Bild-F026295-0021%2C_Bonn%2C_Konzert_Landesvertretung_Baden-W%C3%BCrttemberg.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 700 네덜란드 체임버 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/38/Amsterdam_-_Beurs_van_Berlage_-_1723.jpg/500px-Amsterdam_-_Beurs_van_Berlage_-_1723.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 700
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Amsterdam_-_Beurs_van_Berlage_-_1723.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/38/Amsterdam_-_Beurs_van_Berlage_-_1723.jpg/500px-Amsterdam_-_Beurs_van_Berlage_-_1723.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Jorge Royan', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Jorge Royan · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 700 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/38/Amsterdam_-_Beurs_van_Berlage_-_1723.jpg/500px-Amsterdam_-_Beurs_van_Berlage_-_1723.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 654 안드레아스 헤플리거 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e6/Andreas_haefliger.jpg/500px-Andreas_haefliger.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 654
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Andreas_haefliger.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e6/Andreas_haefliger.jpg/500px-Andreas_haefliger.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'ProfTatic', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'ProfTatic · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 654 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e6/Andreas_haefliger.jpg/500px-Andreas_haefliger.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 673 일레아나 코트루바슈 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99%2C_Liceu_1981-82_%28cropped%29.jpg/500px-Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99%2C_Liceu_1981-82_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 673
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99,_Liceu_1981-82_(cropped).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99%2C_Liceu_1981-82_%28cropped%29.jpg/500px-Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99%2C_Liceu_1981-82_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Gran Teatre del Liceu / Antoni Bofill', 'Public domain', '', 'Gran Teatre del Liceu / Antoni Bofill · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 673 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/1/17/Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99%2C_Liceu_1981-82_%28cropped%29.jpg/500px-Pl%C3%A1cido_Domingo_%26_Ileana_Cotruba%C8%99%2C_Liceu_1981-82_%28cropped%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 670 카를로 리치 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Carlo_Rizzi_%282013%29.jpg/500px-Carlo_Rizzi_%282013%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 670
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Carlo_Rizzi_(2013).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Carlo_Rizzi_%282013%29.jpg/500px-Carlo_Rizzi_%282013%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Quincena Musical de San Sebastián', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Quincena Musical de San Sebastián · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 670 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f0/Carlo_Rizzi_%282013%29.jpg/500px-Carlo_Rizzi_%282013%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 778 빈 교향악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/Belvedere_%28Vienna%29%2C_2021-06-06%2C_Ode_an_die_Freude%2C_Beethoven%2C_2.png/500px-Belvedere_%28Vienna%29%2C_2021-06-06%2C_Ode_an_die_Freude%2C_Beethoven%2C_2.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 778
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Belvedere_(Vienna),_2021-06-06,_Ode_an_die_Freude,_Beethoven,_2.png', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/Belvedere_%28Vienna%29%2C_2021-06-06%2C_Ode_an_die_Freude%2C_Beethoven%2C_2.png/500px-Belvedere_%28Vienna%29%2C_2021-06-06%2C_Ode_an_die_Freude%2C_Beethoven%2C_2.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Wladimir1932', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Wladimir1932 · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 778 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f5/Belvedere_%28Vienna%29%2C_2021-06-06%2C_Ode_an_die_Freude%2C_Beethoven%2C_2.png/500px-Belvedere_%28Vienna%29%2C_2021-06-06%2C_Ode_an_die_Freude%2C_Beethoven%2C_2.png?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 779 NDR 방송교향악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/25/Auff%C3%BChrung_des_Konzerts_f%C3%BCr_Klarinette_und_Orchester_%282018%29_von_Thorsten_Encke_mit_der_Klarinettistin_Sharon_Kam_und_der_NDR_Radiophilharmonie_in_Hannover_am_11._Januar_2019%2C_Konzert_am_Tag_nach_der_Urauff%C3%BChrung_%2810%29.jpg/500px-thumbnail.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 779
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Auff%C3%BChrung_des_Konzerts_f%C3%BCr_Klarinette_und_Orchester_(2018)_von_Thorsten_Encke_mit_der_Klarinettistin_Sharon_Kam_und_der_NDR_Radiophilharmonie_in_Hannover_am_11._Januar_2019,_Konzert_am_Tag_nach_der_Urauff%C3%BChrung_(10).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/25/Auff%C3%BChrung_des_Konzerts_f%C3%BCr_Klarinette_und_Orchester_%282018%29_von_Thorsten_Encke_mit_der_Klarinettistin_Sharon_Kam_und_der_NDR_Radiophilharmonie_in_Hannover_am_11._Januar_2019%2C_Konzert_am_Tag_nach_der_Urauff%C3%BChrung_%2810%29.jpg/500px-thumbnail.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Klaaschwotzer', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Klaaschwotzer · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 779 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/25/Auff%C3%BChrung_des_Konzerts_f%C3%BCr_Klarinette_und_Orchester_%282018%29_von_Thorsten_Encke_mit_der_Klarinettistin_Sharon_Kam_und_der_NDR_Radiophilharmonie_in_Hannover_am_11._Januar_2019%2C_Konzert_am_Tag_nach_der_Urauff%C3%BChrung_%2810%29.jpg/500px-thumbnail.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 735 라리사 게르기예바 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e8/%D0%93%D0%B5%D1%80%D0%B3%D0%B8%D0%B5%D0%B2%D0%B0_%D0%9B%D0%B0%D1%80%D0%B8%D1%81%D0%B0_%D0%90%D0%B1%D0%B8%D1%81%D0%B0%D0%BB%D0%BE%D0%B2%D0%BD%D0%B0.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 735
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:%D0%93%D0%B5%D1%80%D0%B3%D0%B8%D0%B5%D0%B2%D0%B0_%D0%9B%D0%B0%D1%80%D0%B8%D1%81%D0%B0_%D0%90%D0%B1%D0%B8%D1%81%D0%B0%D0%BB%D0%BE%D0%B2%D0%BD%D0%B0.jpg', 'https://upload.wikimedia.org/wikipedia/commons/e/e8/%D0%93%D0%B5%D1%80%D0%B3%D0%B8%D0%B5%D0%B2%D0%B0_%D0%9B%D0%B0%D1%80%D0%B8%D1%81%D0%B0_%D0%90%D0%B1%D0%B8%D1%81%D0%B0%D0%BB%D0%BE%D0%B2%D0%BD%D0%B0.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Лариса Абисаловна Гергиева', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', 'Лариса Абисаловна Гергиева · CC BY 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 735 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/e/e8/%D0%93%D0%B5%D1%80%D0%B3%D0%B8%D0%B5%D0%B2%D0%B0_%D0%9B%D0%B0%D1%80%D0%B8%D1%81%D0%B0_%D0%90%D0%B1%D0%B8%D1%81%D0%B0%D0%BB%D0%BE%D0%B2%D0%BD%D0%B0.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 766 버나드 그린하우스 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ad/Photographie_Bernard_Greenhouse.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 766
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Photographie_Bernard_Greenhouse.jpg', 'https://upload.wikimedia.org/wikipedia/commons/a/ad/Photographie_Bernard_Greenhouse.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', '', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'CC0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 766 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/a/ad/Photographie_Bernard_Greenhouse.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 761 홀리 매시슨 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a9/191001Turn_of_the_Screw144.jpg/500px-191001Turn_of_the_Screw144.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 761
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:191001Turn_of_the_Screw144.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a9/191001Turn_of_the_Screw144.jpg/500px-191001Turn_of_the_Screw144.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Marty Melville', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Marty Melville · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 761 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a9/191001Turn_of_the_Screw144.jpg/500px-191001Turn_of_the_Screw144.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 764 태즈메이니아 심포니 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Federation_Concert_Hall.jpg/500px-Federation_Concert_Hall.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 764
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Federation_Concert_Hall.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Federation_Concert_Hall.jpg/500px-Federation_Concert_Hall.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Barrylb', 'Public domain', '', 'Barrylb · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 764 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/ec/Federation_Concert_Hall.jpg/500px-Federation_Concert_Hall.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 745 시그바르스 클라바 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/55/Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg/500px-Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 745
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/55/Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg/500px-Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Kārlis Dambrāns', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Kārlis Dambrāns · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 745 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/55/Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg/500px-Dziesmu_un_deju_sv%C4%93tku_g%C4%81jiens_2018_Sigvards_K%C4%BCava.jpeg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 751 루치아 포프 · wikidata
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/66/Lucia_Popp_small.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled'
WHERE id = 751
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Lucia_Popp_small.JPG', 'https://upload.wikimedia.org/wikipedia/commons/6/66/Lucia_Popp_small.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled', 'Ludwig Wegmann', 'CC BY-SA 3.0 de', 'https://creativecommons.org/licenses/by-sa/3.0/de/deed.en', 'Ludwig Wegmann · CC BY-SA 3.0 de', TRUE, 'PUBLISHED'
FROM artists WHERE id = 751 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/6/66/Lucia_Popp_small.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail_unscaled';

-- 748 로스앤젤레스 마스터 코랄 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4e/Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles%2C_California_LCCN2013631489.tif/lossy-page1-500px-Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles%2C_California_LCCN2013631489.tif.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 748
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles,_California_LCCN2013631489.tif', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4e/Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles%2C_California_LCCN2013631489.tif/lossy-page1-500px-Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles%2C_California_LCCN2013631489.tif.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Carol M. Highsmith', 'Public domain', '', 'Carol M. Highsmith · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 748 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4e/Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles%2C_California_LCCN2013631489.tif/lossy-page1-500px-Detail_of_the_Walt_Disney_Center_Concert_Hall_in_downtown_Los_Angeles%2C_California_LCCN2013631489.tif.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 638 빈 방송 교향악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/75/ORF_Radiokulturhaus.jpg/500px-ORF_Radiokulturhaus.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 638
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:ORF_Radiokulturhaus.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/75/ORF_Radiokulturhaus.jpg/500px-ORF_Radiokulturhaus.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Der gelehrte hermes', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Der gelehrte hermes · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 638 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/75/ORF_Radiokulturhaus.jpg/500px-ORF_Radiokulturhaus.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 787 SWR 바덴바덴·프라이부르크 교향악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/31/SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg/500px-SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 787
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:SWR_Sinfonieorchester_Baden-Baden_und_Freiburg,_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/31/SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg/500px-SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'SWR Kommunikation', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'SWR Kommunikation · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 787 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/31/SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg/500px-SWR_Sinfonieorchester_Baden-Baden_und_Freiburg%2C_Chefdirigent_Fran%C3%A7ois-Xavier_Roth.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 796 세인트루이스 교향악단 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/78/St._Louis_Symphony_Orchestra.jpg/500px-St._Louis_Symphony_Orchestra.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 796
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:St._Louis_Symphony_Orchestra.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/78/St._Louis_Symphony_Orchestra.jpg/500px-St._Louis_Symphony_Orchestra.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Sanders', 'Public domain', '', 'Sanders · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 796 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/78/St._Louis_Symphony_Orchestra.jpg/500px-St._Louis_Symphony_Orchestra.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 812 자샤 괴첼 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/89/SaschaGoetzel.jpg/500px-SaschaGoetzel.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 812
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:SaschaGoetzel.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/89/SaschaGoetzel.jpg/500px-SaschaGoetzel.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Klassiker', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Klassiker · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 812 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/89/SaschaGoetzel.jpg/500px-SaschaGoetzel.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 610 제프리 파슨스 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c3/Elisabeth_Schwarzkopf_in_Concertgebouw%2C_Amsterdam_%28pianist_Geoffrey_Parsons%29%2C_Bestanddeelnr_929-0174.jpg/500px-Elisabeth_Schwarzkopf_in_Concertgebouw%2C_Amsterdam_%28pianist_Geoffrey_Parsons%29%2C_Bestanddeelnr_929-0174.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 610
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Elisabeth_Schwarzkopf_in_Concertgebouw,_Amsterdam_(pianist_Geoffrey_Parsons),_Bestanddeelnr_929-0174.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c3/Elisabeth_Schwarzkopf_in_Concertgebouw%2C_Amsterdam_%28pianist_Geoffrey_Parsons%29%2C_Bestanddeelnr_929-0174.jpg/500px-Elisabeth_Schwarzkopf_in_Concertgebouw%2C_Amsterdam_%28pianist_Geoffrey_Parsons%29%2C_Bestanddeelnr_929-0174.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Rob Croes / Anefo', 'CC0', 'http://creativecommons.org/publicdomain/zero/1.0/deed.en', 'Rob Croes / Anefo · CC0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 610 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/c3/Elisabeth_Schwarzkopf_in_Concertgebouw%2C_Amsterdam_%28pianist_Geoffrey_Parsons%29%2C_Bestanddeelnr_929-0174.jpg/500px-Elisabeth_Schwarzkopf_in_Concertgebouw%2C_Amsterdam_%28pianist_Geoffrey_Parsons%29%2C_Bestanddeelnr_929-0174.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 618 세인트폴 체임버 오케스트라 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/67/Hamm_Building_%28Saint_Paul%2C_Minnesota_-_2008%29.jpg/500px-Hamm_Building_%28Saint_Paul%2C_Minnesota_-_2008%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 618
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Hamm_Building_(Saint_Paul,_Minnesota_-_2008).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/67/Hamm_Building_%28Saint_Paul%2C_Minnesota_-_2008%29.jpg/500px-Hamm_Building_%28Saint_Paul%2C_Minnesota_-_2008%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Appraiser', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Appraiser · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 618 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/6/67/Hamm_Building_%28Saint_Paul%2C_Minnesota_-_2008%29.jpg/500px-Hamm_Building_%28Saint_Paul%2C_Minnesota_-_2008%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 362 피츠버그 심포니 · wikidata
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Heinz_Hall_at_Night.jpg/500px-Heinz_Hall_at_Night.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 362
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Heinz_Hall_at_Night.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Heinz_Hall_at_Night.jpg/500px-Heinz_Hall_at_Night.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Tom Nguyen from Rockville, MD', 'CC BY 2.0', 'https://creativecommons.org/licenses/by/2.0', 'Tom Nguyen from Rockville, MD · CC BY 2.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 362 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/f3/Heinz_Hall_at_Night.jpg/500px-Heinz_Hall_at_Night.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 586 포트워스 심포니 오케스트라 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3c/Basshall.JPG/500px-Basshall.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 586
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Basshall.JPG', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3c/Basshall.JPG/500px-Basshall.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Phlyr at English Wikipedia', 'CC BY-SA 3.0', 'http://creativecommons.org/licenses/by-sa/3.0/', 'Phlyr at English Wikipedia · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 586 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3c/Basshall.JPG/500px-Basshall.JPG?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 658 라 스칼라 극장 관현악단 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Milano_-_Teatro_alla_Scala_3924.jpg/500px-Milano_-_Teatro_alla_Scala_3924.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 658
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Milano_-_Teatro_alla_Scala_3924.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Milano_-_Teatro_alla_Scala_3924.jpg/500px-Milano_-_Teatro_alla_Scala_3924.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Lucalari84', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Lucalari84 · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 658 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/04/Milano_-_Teatro_alla_Scala_3924.jpg/500px-Milano_-_Teatro_alla_Scala_3924.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 672 바이에른 국립관현악단 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a2/M%C3%BCnchen_Nationaltheater.jpg/500px-M%C3%BCnchen_Nationaltheater.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 672
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:M%C3%BCnchen_Nationaltheater.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a2/M%C3%BCnchen_Nationaltheater.jpg/500px-M%C3%BCnchen_Nationaltheater.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Photo: Andreas Praefcke', 'Public domain', '', 'Photo: Andreas Praefcke · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 672 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/a/a2/M%C3%BCnchen_Nationaltheater.jpg/500px-M%C3%BCnchen_Nationaltheater.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 671 밀라노 주세페 베르디 교향악단 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0f/Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg/500px-Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 671
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_,_2023,_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0f/Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg/500px-Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Angelica Concari © Orchestra Sinfonica di Milano', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Angelica Concari © Orchestra Sinfonica di Milano · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 671 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/0/0f/Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg/500px-Orchestra_Sinfonica_di_Milano_nella_Nona_Sinfonia_di_Gustav_Mahler_%2C_2023%2C_%C2%A9_Orchestra_Sinfonica_di_Milano.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 657 라 스칼라 극장 합창단 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3f/Milan_-_Scala_-_Facade.jpg/500px-Milan_-_Scala_-_Facade.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 657
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Milan_-_Scala_-_Facade.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3f/Milan_-_Scala_-_Facade.jpg/500px-Milan_-_Scala_-_Facade.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Jean-Christophe BENOIST', 'CC BY 3.0', 'https://creativecommons.org/licenses/by/3.0', 'Jean-Christophe BENOIST · CC BY 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 657 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/3/3f/Milan_-_Scala_-_Facade.jpg/500px-Milan_-_Scala_-_Facade.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 763 BBC 콘서트 오케스트라 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2e/BBC_Concert_Orchestra_logo.jpg/500px-BBC_Concert_Orchestra_logo.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 763
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:BBC_Concert_Orchestra_logo.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2e/BBC_Concert_Orchestra_logo.jpg/500px-BBC_Concert_Orchestra_logo.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'BBC', 'Public domain', '', 'BBC · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 763 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/2/2e/BBC_Concert_Orchestra_logo.jpg/500px-BBC_Concert_Orchestra_logo.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 746 빈 국립오페라 합창연합 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/45/Fierrabras_0240_Michelides.jpg/500px-Fierrabras_0240_Michelides.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 746
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Fierrabras_0240_Michelides.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/45/Fierrabras_0240_Michelides.jpg/500px-Fierrabras_0240_Michelides.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Christian Michelides', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Christian Michelides · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 746 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/45/Fierrabras_0240_Michelides.jpg/500px-Fierrabras_0240_Michelides.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 789 댈러스 심포니 합창단 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e4/Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg/500px-Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 789
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e4/Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg/500px-Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'LA2', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'LA2 · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 789 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/e/e4/Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg/500px-Dallas_Symphony_Chorus_20180612_%C3%96rebro.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 830 네덜란드 실내합창단 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/85/Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_%282054%29.jpg/500px-Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_%282054%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 830
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_(2054).jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/85/Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_%282054%29.jpg/500px-Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_%282054%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Petra Hajská', 'CC BY-SA 4.0', 'https://creativecommons.org/licenses/by-sa/4.0', 'Petra Hajská · CC BY-SA 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 830 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/8/85/Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_%282054%29.jpg/500px-Nederlands_Kamerkoor_by_Petra_Hajsk%C3%A1_%282054%29.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 823 쿠아르테토 라티노아메리카노 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/76/Cuarteto_Latinoamericano%2C_photo_by_Segio_Yazbek.jpg/500px-Cuarteto_Latinoamericano%2C_photo_by_Segio_Yazbek.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 823
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Cuarteto_Latinoamericano,_photo_by_Segio_Yazbek.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/76/Cuarteto_Latinoamericano%2C_photo_by_Segio_Yazbek.jpg/500px-Cuarteto_Latinoamericano%2C_photo_by_Segio_Yazbek.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'Sbitran', 'CC BY-SA 3.0', 'https://creativecommons.org/licenses/by-sa/3.0', 'Sbitran · CC BY-SA 3.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 823 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/7/76/Cuarteto_Latinoamericano%2C_photo_by_Segio_Yazbek.jpg/500px-Cuarteto_Latinoamericano%2C_photo_by_Segio_Yazbek.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 318 베를린 필하모닉 오케스트라 · wikipedia
UPDATE artists SET image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5c/Berlin_Philharmonie_asv2018-05_img1.jpg/500px-Berlin_Philharmonie_asv2018-05_img1.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail'
WHERE id = 318
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Berlin_Philharmonie_asv2018-05_img1.jpg', 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5c/Berlin_Philharmonie_asv2018-05_img1.jpg/500px-Berlin_Philharmonie_asv2018-05_img1.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail', 'A.Savin', 'FAL', 'http://artlibre.org/licence/lal/en', 'A.Savin · FAL', TRUE, 'PUBLISHED'
FROM artists WHERE id = 318 AND authority_entity_id IS NOT NULL AND image_url = 'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/5c/Berlin_Philharmonie_asv2018-05_img1.jpg/500px-Berlin_Philharmonie_asv2018-05_img1.jpg?utm_source=commons.wikimedia.org&utm_campaign=imageinfo&utm_content=thumbnail';

-- 797 라살 4중주단 · wikipedia
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Donaueschingen-_Donaueschinger_Musiktage%3B_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694d.jpeg'
WHERE id = 797
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Donaueschingen-_Donaueschinger_Musiktage;_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694d.jpeg', 'https://upload.wikimedia.org/wikipedia/commons/0/06/Donaueschingen-_Donaueschinger_Musiktage%3B_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694d.jpeg', 'Willy Pragher', 'CC BY 4.0', 'https://creativecommons.org/licenses/by/4.0', 'Willy Pragher · CC BY 4.0', TRUE, 'PUBLISHED'
FROM artists WHERE id = 797 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/0/06/Donaueschingen-_Donaueschinger_Musiktage%3B_La_Salle_Quartet_-_LABW_-_Staatsarchiv_Freiburg_W_134_Nr._079694d.jpeg';

-- 822 존 윌리엄스 · wikipedia
UPDATE artists SET image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Guitarist_John_Williams_in_performance_%28Cordoba%2C_1986%29.jpg'
WHERE id = 822
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://commons.wikimedia.org/wiki/File:Guitarist_John_Williams_in_performance_(Cordoba,_1986).jpg', 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Guitarist_John_Williams_in_performance_%28Cordoba%2C_1986%29.jpg', 'Kealow', 'Public domain', '', 'Kealow · Public domain', TRUE, 'PUBLISHED'
FROM artists WHERE id = 822 AND authority_entity_id IS NOT NULL AND image_url = 'https://upload.wikimedia.org/wikipedia/commons/d/d1/Guitarist_John_Williams_in_performance_%28Cordoba%2C_1986%29.jpg';

-- 609 바버라 보니 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/609.jpg'
WHERE id = 609
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.samling.org.uk/leaders/barbara-bonney/', 'https://kang1027.com/classicmap/artist-photos/609.jpg', '', '', '', 'Samling Artist Programme', TRUE, 'PUBLISHED'
FROM artists WHERE id = 609 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/609.jpg';

-- 550 Ernst Ottensamer · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/550.jpg'
WHERE id = 550
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.mdw.ac.at/', 'https://kang1027.com/classicmap/artist-photos/550.jpg', '', '', '', '© N. Auenhammer', TRUE, 'PUBLISHED'
FROM artists WHERE id = 550 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/550.jpg';

-- 625 배리 워즈워스 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/625.jpg'
WHERE id = 625
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.rbo.org.uk/people/barry-wordsworth', 'https://kang1027.com/classicmap/artist-photos/625.jpg', '', '', '', 'Royal Ballet and Opera', TRUE, 'PUBLISHED'
FROM artists WHERE id = 625 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/625.jpg';

-- 709 파트리크 갈루아 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/709.jpg'
WHERE id = 709
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.patrick-gallois.com/', 'https://kang1027.com/classicmap/artist-photos/709.jpg', '', '', '', 'patrick-gallois.com', TRUE, 'PUBLISHED'
FROM artists WHERE id = 709 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/709.jpg';

-- 691 미하엘 슈나이더 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/691.jpg'
WHERE id = 691
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.lastagione.de/orchester.html', 'https://kang1027.com/classicmap/artist-photos/691.jpg', '', '', '', 'La Stagione Frankfurt', TRUE, 'PUBLISHED'
FROM artists WHERE id = 691 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/691.jpg';

-- 690 마이클 알렉산더 윌런스 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/690.jpg'
WHERE id = 690
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://koelnerakademie.de/about/conductor/', 'https://kang1027.com/classicmap/artist-photos/690.jpg', '', '', '', 'Kölner Akademie', TRUE, 'PUBLISHED'
FROM artists WHERE id = 690 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/690.jpg';

-- 694 프란츠요제프 마이어 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/694.jpg'
WHERE id = 694
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.bach-cantatas.com/Bio/Maier-Franzjosef.htm', 'https://kang1027.com/classicmap/artist-photos/694.jpg', '', '', '', 'Bach Cantatas Website', TRUE, 'PUBLISHED'
FROM artists WHERE id = 694 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/694.jpg';

-- 723 볼프람 크리스트 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/723.jpg'
WHERE id = 723
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.lucernefestival.ch/', 'https://kang1027.com/classicmap/artist-photos/723.jpg', '', '', '', '© Reiner Pfisterer', TRUE, 'PUBLISHED'
FROM artists WHERE id = 723 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/723.jpg';

-- 725 루보미르 말리 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/725.jpg'
WHERE id = 725
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://operaplus.cz/mistr-violy-lubomir-maly-slavi-osmdesatiny/', 'https://kang1027.com/classicmap/artist-photos/725.jpg', '', '', '', 'Opera Plus (YouTube 캡처)', TRUE, 'PUBLISHED'
FROM artists WHERE id = 725 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/725.jpg';

-- 718 산드로 데 팔마 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/718.jpg'
WHERE id = 718
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.chigihall.it/sandro-de-palma/', 'https://kang1027.com/classicmap/artist-photos/718.jpg', '', '', '', 'Chigi Hall', TRUE, 'PUBLISHED'
FROM artists WHERE id = 718 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/718.jpg';

-- 717 존 매케이브 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/717.jpg'
WHERE id = 717
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'http://www.johnmccabe.com/', 'https://kang1027.com/classicmap/artist-photos/717.jpg', '', '', '', 'John Scott / British Bandsman', TRUE, 'PUBLISHED'
FROM artists WHERE id = 717 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/717.jpg';

-- 606 보로딘 콰르텟 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/606.jpg'
WHERE id = 606
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://borodinquartet.org/meet-the-quartet/', 'https://kang1027.com/classicmap/artist-photos/606.jpg', '', '', '', 'borodinquartet.org', TRUE, 'PUBLISHED'
FROM artists WHERE id = 606 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/606.jpg';

-- 655 라파엘 프뤼베크 데 부르고스 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/655.jpg'
WHERE id = 655
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.thestrad.com/conductor-and-former-violinist-rafael-fruhbeck-de-burgos-has-died-aged-80/1652.article', 'https://kang1027.com/classicmap/artist-photos/655.jpg', '', '', '', 'The Strad', TRUE, 'PUBLISHED'
FROM artists WHERE id = 655 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/655.jpg';

-- 771 슈무엘 아슈케나시 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/771.jpg'
WHERE id = 771
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://simc.jp/en/profile/shmuel_ashkenasi/', 'https://kang1027.com/classicmap/artist-photos/771.jpg', '', '', '', 'Sendai International Music Competition', TRUE, 'PUBLISHED'
FROM artists WHERE id = 771 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/771.jpg';

-- 772 크리스토프 바라티 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/772.jpg'
WHERE id = 772
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://kristofbarati.com/', 'https://kang1027.com/classicmap/artist-photos/772.jpg', '', '', '', 'Photo: Marco Borggreve', TRUE, 'PUBLISHED'
FROM artists WHERE id = 772 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/772.jpg';

-- 732 갈리나 고르차코바 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/732.jpg'
WHERE id = 732
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.opusklassiek.nl/solisten/gorchakova.htm', 'https://kang1027.com/classicmap/artist-photos/732.jpg', '', '', '', 'OpusKlassiek', TRUE, 'PUBLISHED'
FROM artists WHERE id = 732 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/732.jpg';

-- 733 율리아 숙마노바 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/733.jpg'
WHERE id = 733
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://juliasukmanova.com/', 'https://kang1027.com/classicmap/artist-photos/733.jpg', '', '', '', 'juliasukmanova.com', TRUE, 'PUBLISHED'
FROM artists WHERE id = 733 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/733.jpg';

-- 758 라그나 시르머 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/758.jpg'
WHERE id = 758
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://ragna-schirmer.com/', 'https://kang1027.com/classicmap/artist-photos/758.jpg', '', '', '', '© Ragna Schirmer', TRUE, 'PUBLISHED'
FROM artists WHERE id = 758 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/758.jpg';

-- 760 루시 파럼 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/760.jpg'
WHERE id = 760
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://lucyparham.com/', 'https://kang1027.com/classicmap/artist-photos/760.jpg', '', '', '', 'lucyparham.com (Benjamin Ealovega 또는 Sven Arnstein)', TRUE, 'PUBLISHED'
FROM artists WHERE id = 760 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/760.jpg';

-- 742 폴리포니 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/742.jpg'
WHERE id = 742
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.polyphony.co.uk/about', 'https://kang1027.com/classicmap/artist-photos/742.jpg', '', '', '', 'Photo: Marcin Urban', TRUE, 'PUBLISHED'
FROM artists WHERE id = 742 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/742.jpg';

-- 833 쾰른 신 필하모닉 오케스트라 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/833.jpg'
WHERE id = 833
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.colognenewphilharmonic.com/orchester/', 'https://kang1027.com/classicmap/artist-photos/833.jpg', '', '', '', 'colognenewphilharmonic.com', TRUE, 'PUBLISHED'
FROM artists WHERE id = 833 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/833.jpg';

-- 807 샐리 휘트웰 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/807.jpg'
WHERE id = 807
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'http://www.plexuscollective.com/sally-whitwell', 'https://kang1027.com/classicmap/artist-photos/807.jpg', '', '', '', 'PLEXUS', TRUE, 'PUBLISHED'
FROM artists WHERE id = 807 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/807.jpg';

-- 827 세르히오 티엠포 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/827.jpg'
WHERE id = 827
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.sergiotiempo.net/', 'https://kang1027.com/classicmap/artist-photos/827.jpg', '', '', '', 'sergiotiempo.net', TRUE, 'PUBLISHED'
FROM artists WHERE id = 827 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/827.jpg';

-- 816 리디아 모르드코비치 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/816.jpg'
WHERE id = 816
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.chandos.net/artists/Lydia_Mordkovitch/2633', 'https://kang1027.com/classicmap/artist-photos/816.jpg', '', '', '', 'Chandos', TRUE, 'PUBLISHED'
FROM artists WHERE id = 816 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/816.jpg';

-- 818 스탠리 블랙 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/818.jpg'
WHERE id = 818
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.chandos.net/composers/Stanley_Black/8661', 'https://kang1027.com/classicmap/artist-photos/818.jpg', '', '', '', 'Chandos', TRUE, 'PUBLISHED'
FROM artists WHERE id = 818 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/818.jpg';

-- 599 귄터 회그너 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/599.jpg'
WHERE id = 599
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.wienerphilharmoniker.at/de/magazin/professor-gunter-hogner-verstorben/6019', 'https://kang1027.com/classicmap/artist-photos/599.jpg', '', '', '', 'Wiener Philharmoniker', TRUE, 'PUBLISHED'
FROM artists WHERE id = 599 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/599.jpg';

-- 611 루트 치자크 · web
UPDATE artists SET image_url = 'https://kang1027.com/classicmap/artist-photos/611.jpg'
WHERE id = 611
  AND (image_url IS NULL OR image_url = '' OR image_url LIKE 'https://external-content.duckduckgo.com/%');
INSERT IGNORE INTO entity_images (authority_entity_id, image_kind, source_url, file_url, author, license, license_url, credit_line, is_primary, editorial_status)
SELECT authority_entity_id, 'profile', 'https://www.hfmsaar.de/lehrende/ruth-ziesak', 'https://kang1027.com/classicmap/artist-photos/611.jpg', '', '', '', 'HfM Saar', TRUE, 'PUBLISHED'
FROM artists WHERE id = 611 AND authority_entity_id IS NOT NULL AND image_url = 'https://kang1027.com/classicmap/artist-photos/611.jpg';
