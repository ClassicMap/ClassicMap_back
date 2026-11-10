// macOS Vision 으로 그림마다 얼굴 상자(없으면 상반신 상자)를 찾는다.
// 사용: swift faces.swift <그림 파일...>  → 한 줄 하나 JSON {file,width,height,faces:[[x,y,w,h]...],bodies:[...]}
// 좌표는 0~1, 원점은 왼쪽 위.
import AppKit
import Foundation
import Vision

func boxes(_ observations: [VNDetectedObjectObservation]?) -> [[Double]] {
    (observations ?? []).map { obs in
        let r = obs.boundingBox
        return [Double(r.minX), Double(1 - r.maxY), Double(r.width), Double(r.height), Double(obs.confidence)]
    }
}

for path in CommandLine.arguments.dropFirst() {
    let url = URL(fileURLWithPath: path)
    guard let image = NSImage(contentsOf: url),
          let cg = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        print("{\"file\":\"\(url.lastPathComponent)\",\"error\":\"load\"}")
        continue
    }
    let handler = VNImageRequestHandler(cgImage: cg, options: [:])
    let faceRequest = VNDetectFaceRectanglesRequest()
    let bodyRequest = VNDetectHumanRectanglesRequest()
    bodyRequest.upperBodyOnly = true
    try? handler.perform([faceRequest, bodyRequest])
    let faces = boxes(faceRequest.results)
    let bodies = boxes(bodyRequest.results)
    let payload: [String: Any] = [
        "file": url.lastPathComponent,
        "width": cg.width,
        "height": cg.height,
        "faces": faces,
        "bodies": bodies,
    ]
    if let data = try? JSONSerialization.data(withJSONObject: payload),
       let line = String(data: data, encoding: .utf8) {
        print(line)
    }
}
