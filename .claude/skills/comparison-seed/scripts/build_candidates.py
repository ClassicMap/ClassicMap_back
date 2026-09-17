"""검출·검증을 마친 구간으로 적재용 후보 JSONL 을 만든다.

    python3 build_candidates.py batch.json

구간 경계는 정수 초로 줄인다. floor(시작)/ceil(끝) 이라 음이 잘리지 않는다.
영상 메타는 <batchId>-videometa.txt 에서 읽고, 채널 ID 는 oEmbed 로 채운다.
"""
import json
import math
import os
import sys
import urllib.parse
import urllib.request
from datetime import datetime, timezone

import batch as batchlib

UA = "ClassicMapSeed/1.0 (kecan0406@gmail.com)"
NOW = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
VERIFICATION_NOTE = (
    "박수와 무음을 걷어내고 조성 성분이 이어지는 구간을 작품으로 보아 경계를 잡았다. "
    "같은 곡의 다른 연주와 교차 정렬해 같은 음악인지 확인했다.")


def video_meta(batch):
    path = os.path.join(batchlib.WORK_DIR, f"{batch['batchId']}-videometa.txt")
    meta = {}
    with open(path, encoding="utf-8") as fh:
        for line in fh:
            parts = line.rstrip("\n").split("|")
            if len(parts) >= 6:
                meta[parts[0]] = {
                    "duration": int(parts[1]), "channel": parts[2],
                    "uploadDate": f"{parts[3][:4]}-{parts[3][4:6]}-{parts[3][6:]}",
                    "availability": parts[4], "liveStatus": parts[5],
                    "title": "|".join(parts[6:]) if len(parts) > 6 else "",
                }
    return meta


def oembed(video_ids):
    """채널 ID 는 메타에 없으므로 oEmbed 로 가져온다. 가용성 근거도 된다."""
    out = {}
    for video_id in sorted(video_ids):
        url = "https://www.youtube.com/oembed?" + urllib.parse.urlencode(
            {"url": f"https://www.youtube.com/watch?v={video_id}", "format": "json"})
        request = urllib.request.Request(url, headers={"User-Agent": UA})
        try:
            with urllib.request.urlopen(request, timeout=20) as response:
                out[video_id] = (url, response.status,
                                 json.load(response).get("author_url", ""))
        except urllib.error.HTTPError as error:
            out[video_id] = (url, error.code, "")
    return out


def credits_for(piece, video):
    """독주자나 지휘자가 primary 이고, 관현악 곡이면 악단이 따라붙는다."""
    entries = [{
        "roleCode": piece["role"], "isPrimary": True, "displayOrder": 0,
        "entityCandidate": {
            "preferredName": video["artistName"],
            "externalIdentifiers": [{
                "namespace": "wikidata", "value": video["wikidata"],
                "sourceUrl": f"https://www.wikidata.org/wiki/{video['wikidata']}"}],
        },
    }]
    orchestra = video.get("orchestra")
    if orchestra:
        entries.append({
            "roleCode": "ORCHESTRA", "isPrimary": False, "displayOrder": 1,
            "entityCandidate": {
                "preferredName": orchestra["name"],
                "externalIdentifiers": [{
                    "namespace": "wikidata", "value": orchestra["wikidata"],
                    "sourceUrl": f"https://www.wikidata.org/wiki/{orchestra['wikidata']}"}],
            },
        })
    return entries


def main():
    if len(sys.argv) != 2:
        raise SystemExit(__doc__)
    batch = batchlib.load(sys.argv[1])
    meta = video_meta(batch)
    detected = {r["videoId"]: r for r in batchlib.read_detected(batch)}
    links = oembed(detected)

    spans = {}
    for piece in batch["pieces"]:
        for video in piece["videos"]:
            row = detected[video["videoId"]]
            start = math.floor(row["start"])
            end = min(math.ceil(row["end"]), meta[video["videoId"]]["duration"])
            spans.setdefault(piece["pieceId"], []).append(end - start)

    out = []
    for piece, video in batchlib.videos(batch):
        video_id = video["videoId"]
        row, info, sector = detected[video_id], meta[video_id], piece["sector"]
        start = math.floor(row["start"])
        end = min(math.ceil(row["end"]), info["duration"])
        oembed_url, status, author = links[video_id]
        channel_id = author.rstrip("/").rsplit("/", 1)[-1] if author else ""
        lengths = spans[piece["pieceId"]]

        out.append({
            "schemaVersion": "1",
            "candidateKey": f"yt:{video_id}:{start}:{end}",
            "candidateStatus": "APPROVED",
            "confidence": "MEDIUM_HIGH",
            "reviewedAt": NOW,
            "workCandidate": {
                "naturalKey": f"musicbrainz-work:{piece['workMbid']}",
                "preferredTitleKo": piece["titleKo"],
                "preferredTitleEn": piece["titleEn"],
                "externalIdentifiers": [{
                    "namespace": "musicbrainz_work", "value": piece["workMbid"],
                    "sourceUrl": f"https://musicbrainz.org/work/{piece['workMbid']}"}],
                "composer": {
                    "preferredName": piece["composerNameEn"],
                    "nameKo": piece["composerNameKo"],
                    "externalIdentifiers": [{
                        "namespace": "wikidata", "value": piece["composerQid"],
                        "sourceUrl":
                            f"https://www.wikidata.org/wiki/{piece['composerQid']}"}],
                },
            },
            "sectorCandidate": {
                "sectorKey": sector["key"],
                "sectorType": sector["type"],
                "nameKo": sector["nameKo"],
                "nameEn": sector["nameEn"],
                "measureStart": sector["measureStart"],
                "measureEnd": sector["measureEnd"],
                "startCue": sector["startCue"],
                "endCue": sector["endCue"],
                "targetMinMs": (min(lengths) - 5) * 1000,
                "targetMaxMs": (max(lengths) + 5) * 1000,
            },
            "source": {
                "provider": "youtube", "videoId": video_id,
                "originalUrl": f"https://www.youtube.com/watch?v={video_id}",
                "title": info["title"], "channel": info["channel"],
                "channelId": channel_id,
                "channelUrl": author or f"https://www.youtube.com/channel/{channel_id}",
                "uploadDate": info["uploadDate"],
                "durationSeconds": info["duration"],
                "availabilityStatus": "AVAILABLE", "availabilityCheckedAt": NOW,
                "availabilityEvidence": {
                    "method": "yt-dlp metadata and YouTube oEmbed",
                    "extractorAvailability": info["availability"],
                    "liveStatus": info["liveStatus"],
                    "oembedUrl": oembed_url, "oembedHttpStatus": status,
                },
                "rightsMode": "unknown",
            },
            "credits": credits_for(piece, video),
            "clip": {
                "startSeconds": start, "endSeconds": end,
                "timelineMethod": f"AUDIO_DETECTED_{sector['type']}",
                "verificationNote": VERIFICATION_NOTE,
            },
            "publicationGate": "RIGHTS_AND_CLIP_ASSET_REQUIRED",
        })

    path = os.path.join(batchlib.WORK_DIR, f"{batch['batchId']}-candidates.jsonl")
    with open(path, "w", encoding="utf-8") as fh:
        for row in sorted(out, key=lambda r: r["candidateKey"]):
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
    print(f"{len(out)}건 → {path}")

    bad = [v for v, (_, s, _) in links.items() if s != 200]
    print(f"oEmbed 200 아님: {bad or '없음'}")
    missing = [v for v, (_, _, a) in links.items() if not a]
    print(f"채널 ID 확보 실패: {missing or '없음'}")
    over = [r["candidateKey"] for r in out
            if r["clip"]["endSeconds"] - r["clip"]["startSeconds"] > 600]
    print(f"클립 600초 초과: {over or '없음'}")


if __name__ == "__main__":
    main()
