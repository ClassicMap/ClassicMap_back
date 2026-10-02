-- 오디오가 영상보다 짧게 끊긴 클립 14개를 다시 만든 파일로 바꾼다.
-- 2026-09-16 무렵 yt-dlp 구간 받기로 만든 긴 클립에서 오디오 트랙이 중간에 끊겨 있었다(영상은 끝까지).
-- 정렬 지도를 만들다 찾았다. seed_pipeline/curation/alignment-2026-10-02/README.md 에 목록이 있다.
-- 클리퍼의 지금 방식(원본을 통째로 받아 로컬에서 자르기)으로 같은 storageKey 에 다시 만들었고,
-- 오디오·영상 길이가 0.2초 안쪽으로 맞는 것을 ffprobe 로, 공개 주소의 Range(206)와 해시를 응답 머리로 확인했다. 예전 파일은 클립 캐시의
-- replaced-20261002/ 에 남겨 두었다.
-- 저장 키는 그대로라 해시·크기·검증 기록만 바꾼다. 지금 해시가 예전 해시일 때만 바꾸므로 다시 돌려도 같다.
-- 이 클립의 음량 곡선·정렬 지도는 예전 해시로 잰 것이라 API 가 내보내지 않는다. 다시 재서 넣는다.

-- 피아노 소나타 14번 C#단조 "월광" · 3악장 Presto agitato · 발렌티나 리시차 (performance 193, 오디오 328초 → 400초)
UPDATE clip_assets
SET sha256 = 'ee581f60dd7dc55083376e152a27df029f71cf7688bbde17c1bd3321f0271c9f',
    file_size = 31243537,
    duration_ms = 400035,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"zucBfXpCA6s-2000-400000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":2000,"durationMs":400000,"fileSize":31243537,"probedDurationMs":400035,"sha256":"ee581f60dd7dc55083376e152a27df029f71cf7688bbde17c1bd3321f0271c9f","assetValidatedAt":"2026-10-02T03:45:30.103Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:45:30.103',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 111
  AND performance_id = 193
  AND storage_path LIKE '%/zucBfXpCA6s-2000-400000-v1-copy.mp4'
  AND sha256 = 'dca9e4e4b32598aff1c0a637123640bf17396888ee839b9b9f337fea70052477';

-- 피아노 소나타 8번 C단조 "비창" · 2악장 Adagio cantabile · 이고르 레비트 (performance 178, 오디오 219초 → 291초)
UPDATE clip_assets
SET sha256 = 'f9221c603d8703b20f558cdd926026b8c17c0a7496abdd03e88dc504084814c8',
    file_size = 68726858,
    duration_ms = 291120,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"_evNH3kzylg-4000-291000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":4000,"durationMs":291000,"fileSize":68726858,"probedDurationMs":291120,"sha256":"f9221c603d8703b20f558cdd926026b8c17c0a7496abdd03e88dc504084814c8","assetValidatedAt":"2026-10-02T03:45:12.528Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:45:12.528',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 102
  AND performance_id = 178
  AND storage_path LIKE '%/_evNH3kzylg-4000-291000-v1-copy.mp4'
  AND sha256 = 'eae6845fbe1141a50178d454d39ed31033022bd98fb98ca133e69fd683641728';

-- 피아노 협주곡 3번 D단조 · 3악장 - 클라이맥스 · 유자 왕 (performance 230, 오디오 244초 → 301초)
UPDATE clip_assets
SET sha256 = 'a2f0cad6203663a572db96c777bfe052e03ec18c9268adc4c12c50e5b933d6aa',
    file_size = 40836591,
    duration_ms = 301120,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"5bX_yRzCuM4-2317000-301000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":2317000,"durationMs":301000,"fileSize":40836591,"probedDurationMs":301120,"sha256":"a2f0cad6203663a572db96c777bfe052e03ec18c9268adc4c12c50e5b933d6aa","assetValidatedAt":"2026-10-02T03:45:56.571Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:45:56.571',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 142
  AND performance_id = 230
  AND storage_path LIKE '%/5bX_yRzCuM4-2317000-301000-v1-copy.mp4'
  AND sha256 = '98f9fa587da2d162888f6eb2ae3b42acdc7e1c7d3cb31c10ad6f8d6341d32060';

-- 폴로네즈 6번 A♭장조 "영웅" · 전곡 · 조성진 (performance 132, 오디오 318초 → 408초)
UPDATE clip_assets
SET sha256 = 'd6ab25103725f50face3f8dc4254f909ff57d4d251cf8d4528a263d16c1ea2a5',
    file_size = 31671935,
    duration_ms = 408080,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"d3IKMiv8AHw-5000-408000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":5000,"durationMs":408000,"fileSize":31671935,"probedDurationMs":408080,"sha256":"d6ab25103725f50face3f8dc4254f909ff57d4d251cf8d4528a263d16c1ea2a5","assetValidatedAt":"2026-10-02T03:46:06.569Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:46:06.569',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 62
  AND performance_id = 132
  AND storage_path LIKE '%/d3IKMiv8AHw-5000-408000-v1-copy.mp4'
  AND sha256 = 'c0d2a4af62a7e96cc689acf86af8bd5a9ef6a527e9417bfe880d442bf5571196';

-- 헝가리 광시곡 2번 · 전곡 · 발렌티나 리시차 (performance 215, 오디오 526초 → 565초)
UPDATE clip_assets
SET sha256 = '02ee521b6739f88fe08871b041844cffcb7cea79aa96d056902b798d16005c59',
    file_size = 73263099,
    duration_ms = 565080,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"LdH1hSWGFGU-8000-565000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":8000,"durationMs":565000,"fileSize":73263099,"probedDurationMs":565080,"sha256":"02ee521b6739f88fe08871b041844cffcb7cea79aa96d056902b798d16005c59","assetValidatedAt":"2026-10-02T03:46:18.512Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:46:18.512',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 133
  AND performance_id = 215
  AND storage_path LIKE '%/LdH1hSWGFGU-8000-565000-v1-copy.mp4'
  AND sha256 = '7c5915bcfc70cccab4b1295dde13af79e5dbf5dd379d9acc869a31556eb22329';

-- 초절기교 연습곡 4번 D단조 "마제파" · 전곡 · 다닐 트리포노프 (performance 212, 오디오 384초 → 466초)
UPDATE clip_assets
SET sha256 = '1cfcafc92d656e3b673d593ff277226f677df8b924bb1730646d114456a67bd0',
    file_size = 53803327,
    duration_ms = 466040,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"CXGeOHdiHrE-1000-466000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":1000,"durationMs":466000,"fileSize":53803327,"probedDurationMs":466040,"sha256":"1cfcafc92d656e3b673d593ff277226f677df8b924bb1730646d114456a67bd0","assetValidatedAt":"2026-10-02T03:46:24.598Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:46:24.598',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 130
  AND performance_id = 212
  AND storage_path LIKE '%/CXGeOHdiHrE-1000-466000-v1-copy.mp4'
  AND sha256 = 'e8f5e7cf882a60a9d1ce9acb9f0b6736e415b98a34b4556621429e0723095ab2';

-- 초절기교 연습곡 4번 D단조 "마제파" · 전곡 · 하오첸 장 (performance 213, 오디오 339초 → 429초)
UPDATE clip_assets
SET sha256 = '821311c2eba9578494d68fa1b9037e2b284f35010e49c5db71bee479114d2d4b',
    file_size = 38939071,
    duration_ms = 429033,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"KhspEZLSlGs-4000-429000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":4000,"durationMs":429000,"fileSize":38939071,"probedDurationMs":429033,"sha256":"821311c2eba9578494d68fa1b9037e2b284f35010e49c5db71bee479114d2d4b","assetValidatedAt":"2026-10-02T03:46:33.451Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:46:33.451',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 131
  AND performance_id = 213
  AND storage_path LIKE '%/KhspEZLSlGs-4000-429000-v1-copy.mp4'
  AND sha256 = 'bfb83a03c1e31925c79aa97a7a40eef6cda5b16844eee0b6001105e484a9dbb0';

-- 오페레타 <박쥐> 서곡 · 전곡 · 헤르베르트 폰 카라얀 (performance 164, 오디오 437초 → 488초)
UPDATE clip_assets
SET sha256 = 'b0dd0d9244d40b6eeaee02a57b121dac6b1a4157e57e2648caf8246b41ecd589',
    file_size = 20204073,
    duration_ms = 488120,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"JZgFCtOcDsQ-5000-488000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":5000,"durationMs":488000,"fileSize":20204073,"probedDurationMs":488120,"sha256":"b0dd0d9244d40b6eeaee02a57b121dac6b1a4157e57e2648caf8246b41ecd589","assetValidatedAt":"2026-10-02T03:46:48.405Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:46:48.405',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 88
  AND performance_id = 164
  AND storage_path LIKE '%/JZgFCtOcDsQ-5000-488000-v1-copy.mp4'
  AND sha256 = '02dc02d1edc00d3378d06808d29cd1ba7000ee305ab0b9428d50589d9ccf9e38';

-- 오페레타 <박쥐> 서곡 · 전곡 · 카를로스 클라이버 (performance 167, 오디오 426초 → 441초)
UPDATE clip_assets
SET sha256 = '3b6b1f895e53b5503c90a90e105ef04bb91cc4d4e36cc1cdbf64cb63233e3088',
    file_size = 23657233,
    duration_ms = 441040,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"TjvpwesDVQE-4000-441000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":4000,"durationMs":441000,"fileSize":23657233,"probedDurationMs":441040,"sha256":"3b6b1f895e53b5503c90a90e105ef04bb91cc4d4e36cc1cdbf64cb63233e3088","assetValidatedAt":"2026-10-02T03:47:02.501Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:47:02.501',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 91
  AND performance_id = 167
  AND storage_path LIKE '%/TjvpwesDVQE-4000-441000-v1-copy.mp4'
  AND sha256 = '36a69c8428ca09689c4b7d9113995b36d2e964a2fe7fc26247d54afefbe63642';

-- 물의 유희 · 전곡 · 조성진 (performance 169, 오디오 294초 → 329초)
UPDATE clip_assets
SET sha256 = 'f2f5cbc16ac8b5cdead6279b6772451a2c737b9897a34dc5080c74a24156b80f',
    file_size = 69676692,
    duration_ms = 329020,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"Z1QrFd7lNcU-2000-329000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":2000,"durationMs":329000,"fileSize":69676692,"probedDurationMs":329020,"sha256":"f2f5cbc16ac8b5cdead6279b6772451a2c737b9897a34dc5080c74a24156b80f","assetValidatedAt":"2026-10-02T03:47:10.157Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:47:10.157',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 93
  AND performance_id = 169
  AND storage_path LIKE '%/Z1QrFd7lNcU-2000-329000-v1-copy.mp4'
  AND sha256 = 'a9bc24658137d177f627dfe5669bd500ef59ed7f1f418927f20fccaf473a4c33';

-- 짐노페디 1번 · 전곡 · 올가 셰프스 (performance 137, 오디오 143초 → 202초)
UPDATE clip_assets
SET sha256 = '8cb334d9c36d6d5c187164d09eec37dbee237aa86b1e5858799aa21f9e823217',
    file_size = 37344607,
    duration_ms = 202080,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"5IYsHVGxRiE-20000-202000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":20000,"durationMs":202000,"fileSize":37344607,"probedDurationMs":202080,"sha256":"8cb334d9c36d6d5c187164d09eec37dbee237aa86b1e5858799aa21f9e823217","assetValidatedAt":"2026-10-02T03:47:29.096Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:47:29.096',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 67
  AND performance_id = 137
  AND storage_path LIKE '%/5IYsHVGxRiE-20000-202000-v1-copy.mp4'
  AND sha256 = '650d1f4da74ede903ceaebb1718cf7fa97ea41d00b2f899799fad08e703e1866';

-- 피아노 소나타 16번 C장조 "쉬운 소나타" · 1악장 Allegro · 랑랑 (performance 206, 오디오 226초 → 280초)
UPDATE clip_assets
SET sha256 = '5d0578e0be8a381f470ffd8eb0d092c0bd3ad6f77e97f2d10ad085a54529ea64',
    file_size = 45294332,
    duration_ms = 280080,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"5O9XIvkC-rk-4000-280000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":4000,"durationMs":280000,"fileSize":45294332,"probedDurationMs":280080,"sha256":"5d0578e0be8a381f470ffd8eb0d092c0bd3ad6f77e97f2d10ad085a54529ea64","assetValidatedAt":"2026-10-02T03:47:37.124Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:47:37.124',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 129
  AND performance_id = 206
  AND storage_path LIKE '%/5O9XIvkC-rk-4000-280000-v1-copy.mp4'
  AND sha256 = 'bdac4033b5f0e382245e68fbc4ce04c647db73c510dfeedc2af0c6ca73d3b541';

-- 전주곡 15번 D♭장조 "빗방울" · 전곡 · 조성진 (performance 136, 오디오 246초 → 299초)
UPDATE clip_assets
SET sha256 = '431153f1ae5bc568109d81c496ecd5aa2c6b84491fa6081738406b51b33a93c8',
    file_size = 19824996,
    duration_ms = 299080,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"pCx5g4FnAXU-2000-299000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":2000,"durationMs":299000,"fileSize":19824996,"probedDurationMs":299080,"sha256":"431153f1ae5bc568109d81c496ecd5aa2c6b84491fa6081738406b51b33a93c8","assetValidatedAt":"2026-10-02T03:47:49.087Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:47:49.087',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 66
  AND performance_id = 136
  AND storage_path LIKE '%/pCx5g4FnAXU-2000-299000-v1-copy.mp4'
  AND sha256 = '972f86c815fee8bd55b59265ead66c1110a529693323be8a76010f44fc3d0fad';

-- 연습곡 Op. 10, No. 3 "이별의 곡" · 전곡 · 드미트리 시시킨 (performance 134, 오디오 216초 → 257초)
UPDATE clip_assets
SET sha256 = 'fcad21b69edc9d71dcf31291bdc5dcffb71214b8b61806d54b7177357e6f5c1e',
    file_size = 22332396,
    duration_ms = 257040,
    ffprobe_result = CAST('{"metadataVersion":1,"storageKey":"emvuer7jsf0-0-257000-v1-copy.mp4","encodingProfileVersion":"v1-copy","startMs":0,"durationMs":257000,"fileSize":22332396,"probedDurationMs":257040,"sha256":"fcad21b69edc9d71dcf31291bdc5dcffb71214b8b61806d54b7177357e6f5c1e","assetValidatedAt":"2026-10-02T03:48:00.521Z","videoCodec":"h264","audioCodec":"aac"}' AS JSON),
    asset_validated_at = '2026-10-02 03:48:00.521',
    range_verified_at = '2026-10-02 03:49:04.000'
WHERE id = 64
  AND performance_id = 134
  AND storage_path LIKE '%/emvuer7jsf0-0-257000-v1-copy.mp4'
  AND sha256 = '1577cbb273381aacbb20d56227f2e3ade0994be61cdbf87b624b1c0f854f6fd9';
