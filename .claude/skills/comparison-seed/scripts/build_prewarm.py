"""적재된 연주로 클립 선생성 매니페스트를 만든다.

    python3 build_prewarm.py batch.json <migration-id> <performanceId:videoId:start:end> ...

performance 정보는 적재 뒤 DB 에서 읽어 인자로 넘긴다. 예:
    python3 build_prewarm.py batch.json 202608050055 201:xN-JCdM4or0:5:184

rightsMode 를 licensed_self_hosted 로 적지만 실제 이용 허락을 받은 것이 아니다.
그 사실을 rightsEvidence 에 남긴다.
"""
import json
import os
import sys
from datetime import datetime, timezone

import batch as batchlib

NOW = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def main():
    if len(sys.argv) < 4:
        raise SystemExit(__doc__)
    batch = batchlib.load(sys.argv[1])
    migration = sys.argv[2]
    evidence = (f"내부 기술 검증 단계의 자체 호스팅 표기입니다. 마이그레이션 {migration} 에서 "
                "rights_mode 를 licensed_self_hosted 로 바꾸지만 실제 이용 허락을 받은 것이 "
                "아니며, 외부 공개 전 권리자 확인이 필요합니다.")

    path = os.path.join(batchlib.WORK_DIR, f"{batch['batchId']}-prewarm.jsonl")
    count = 0
    with open(path, "w", encoding="utf-8") as fh:
        for spec in sys.argv[3:]:
            performance_id, video_id, start, end = spec.split(":")
            if int(end) - int(start) > 600:
                raise SystemExit(f"{video_id}: 클립이 600초를 넘음")
            fh.write(json.dumps({
                "performanceId": int(performance_id), "videoId": video_id,
                "start": int(start), "end": int(end),
                "candidateStatus": "APPROVED", "rightsMode": "licensed_self_hosted",
                "rightsReviewedAt": NOW, "rightsEvidence": evidence,
            }, ensure_ascii=False) + "\n")
            count += 1
    print(f"{count}건 → {path}")


if __name__ == "__main__":
    main()
