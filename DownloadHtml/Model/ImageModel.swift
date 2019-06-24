//
//  ImageModel.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/23.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Foundation
class ImageModel {
    var url: URL
    var imgUrl: String { return url.absoluteString}
//    创建时间
    var createDate: Date
    init(url: URL) {
        self.url = url
        createDate = Date()
    }
}
