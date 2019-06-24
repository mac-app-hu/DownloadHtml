//
//  ImageDownloaderManage.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/23.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Foundation
import AlamofireImage
class ImageDownloaderManage {
    static let share = ImageDownloaderManage()
    private let imgDownload = ImageDownloader.default
    init() {
        imgDownload.download([])
    }
    
    public func addImages(images: [String], htmlUrl: URL) {
        //img的src有两种。一种是绝对链接，一种是相对链接，一般是以开头"/"，还有一种是以"//"开头的，这需要加上"https"或者"http"
        let scheme = htmlUrl.scheme ?? "http"
        let host = htmlUrl.host ?? ""
        
        let res = images.compactMap { (urlStr) -> ImageModel? in
//            print(urlStr)
            var resUrlStr = urlStr
            if urlStr.hasPrefix("//") {
                resUrlStr = scheme + ":" + resUrlStr
            } else if urlStr.hasPrefix("/") {
                //不是以“//”开头,但是以"/"开头,所以是相对路径
                resUrlStr = scheme + "://" + host + resUrlStr
            }
            resUrlStr = resUrlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? resUrlStr
            //这些默认是绝对路径
            if let url = URL.init(string: resUrlStr) {
                return ImageModel(url: url)
            } else {
                return nil
            }
        }
        imgDownload.download(res.map {URLRequest(url: $0.url)}, progress: { (progress) in
//            print("progress = ", progress)
        }) { (resp) in
            let lastPathComponent = resp.request?.url?.lastPathComponent ?? (Date.getGMT8DateStr() + ".png")
            if let imgData = resp.data {
                ImageFileManage.share.createFile(contents: imgData, fileName: lastPathComponent)
            }
            
            switch resp.result {
            case .failure(let err):
                print("图片下载失败", err)
            case .success(let img):
                if let imgData = img.jpegRepresentation(compressionQuality: 1.0) {
                    ImageFileManage.share.createFile(contents: imgData, fileName: lastPathComponent)
                }
            }
        }
        
    }
}
extension Date {
    /// 获取东八区的时间，格式是 yyyyMMddhhmmss
    ///
    /// - Returns: 时间的string表示
    public static func getGMT8DateStr() -> String {
        let current = Date.init()
        let format = DateFormatter.init()
        format.dateFormat = "yyyyMMddHHmmss"
        format.timeZone = TimeZone.init(abbreviation: "GMT+0800")
        //  format.timeStyle = .full
        return format.string(from: current)
    }
    ///
    ///
    /// - Returns: 时间的string表示
    public static func getYyyyMMddStr() -> String {
        let current = Date.init()
        let format = DateFormatter.init()
        return format.string(from: current)
    }
}
extension NSImage {
    public func jpegRepresentation(compressionQuality: CGFloat) -> Data? {
//        cgImage(forProposedRect: nil, context: nil, hints: nil)
        guard let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) else {
            return nil
        }
        
        let rep = NSBitmapImageRep(cgImage: cgImage)
        return rep.representation(using:.jpeg, properties: [.compressionFactor: compressionQuality])
    }
}
