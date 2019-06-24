//
//  DownloadViewController.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/21.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Cocoa
import AlamofireImage
class DownloadViewController: NSViewController {
    lazy var opeFileButton: NSButton = {
        let button = NSButton.init(title: "打开下载目录", target: self, action: #selector(opeFileButtonTap))
        button.bezelStyle = .inline
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = .init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        view.addSubview(opeFileButton)
        // Do view setup here.
//       let imgUrl = "https://raw.githubusercontent.com/HanksHu/publicWork/master/pics/gallery1.webp"
//        guard let url = URL(string: imgUrl) else {
//            print("输入正确的图片url")
//            return
//        }
//        let urlRequest = URLRequest(url: url)
//        ImageDownloader.default.download(urlRequest) { (resp) in
//            switch resp.result {
//            case .success(let img):
//                print("图片下载成功", imgUrl)
//            case .failure(let err):
//                print("图片下载失败", err)
//            }
////            resp.
//        }
        
        opeFileButton.snp.makeConstraints { (make) in
            make.top.equalTo(130)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
        }
    }
    @objc func opeFileButtonTap() {
        //打开文件目录
        NSWorkspace.shared.openFile(picturesPath)
    }
    
}
