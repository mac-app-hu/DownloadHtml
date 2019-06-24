//
//  HomeViewController.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/21.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Cocoa
import Alamofire
import hpple
import AlamofireImage
class HomeViewController: NSViewController {
    lazy var inputText: NSSearchField = {
        let input = NSSearchField.init()
        input.placeholderString = "输入HTML的链接"
        input.font = NSFont.systemFont(ofSize: 15)
        input.bezelStyle = .roundedBezel
        input.delegate = self
        return input
    }()
    lazy var searchButton: NSButton = {
        let button = NSButton.init(title: "开始查找下载", target: self, action: #selector(searchButtonTap))
        button.bezelStyle = .inline
        button.isEnabled = false
        //        button.setButtonType(.momentaryLight)
        return button
    }()
    lazy var dprogress = DProgressIndicator()
    
    let progress = NSProgressIndicator.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.wantsLayer = true
        view.layer?.backgroundColor = .init(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 1.0)
        view.addSubview(inputText, searchButton, dprogress)
        inputText.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.width.equalTo(400)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        searchButton.snp.makeConstraints { (make) in
            make.top.equalTo(inputText.snp.bottom).offset(30)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(35)
        }
        dprogress.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        //        dprogress.startAnimation()
        
    }
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    //https://www.jianshu.com/p/b6b30d38255e
    @objc func searchButtonTap() {
        inputText.resignFirstResponder()
        var urlStr = inputText.stringValue
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlStr
        guard let url = URL.init(string: urlStr) else {
            NSAlert.showCriticalAlert(currentView: view, "输入正确的HTML链接")
            return
        }
        dprogress.startAnimation()
        let task =  Alamofire.SessionManager.default.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
        task.responseData { (resp) in
            self.dprogress.stopAnimation()
            switch resp.result {
            case .failure(let err):
                NSAlert.showCriticalAlert(currentView: self.view, "HTML下载失败", err.localizedDescription)
            case .success(let value):
                let doc = TFHpple.init(htmlData: value)
                let elements = doc?.search(withXPathQuery: "//img") as? [TFHppleElement] ?? []
                //有些图片在data-original中
                let resImgs = elements.compactMap { $0.object(forKey: "src") ?? $0.object(forKey: "data-original") }
                print(resImgs)
                ImageDownloaderManage.share.addImages(images: resImgs, htmlUrl: url)
            }
            
        }
        
    }
    
}
extension HomeViewController: NSSearchFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        searchButton.isEnabled = !inputText.stringValue.isEmpty
    }
    func searchFieldDidStartSearching(_ sender: NSSearchField) {
        //        print("searchFieldDidStartSearching")
        //        searchButtonTap()
    }
    
}
