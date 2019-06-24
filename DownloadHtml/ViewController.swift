//
//  ViewController.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/21.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Cocoa
import SnapKit
class ViewController: NSViewController {

    @IBOutlet weak var rightCustom: NSView!
    @IBOutlet weak var leftCustomView: NSView!
    @IBOutlet weak var homeButton: NSButton!
    @IBOutlet weak var downloadButton: NSButton!
//    首页，解析HTML的
    lazy var homeVC = HomeViewController()
//    下载管理图片的
    lazy var downloadVC = DownloadViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(leftCustomView.snp.centerY).offset(-25)
        }
        downloadButton.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(leftCustomView.snp.centerY).offset(25)
        }
//        设置默认值
        homeButton.state = .on
        downloadButton.state = .off
        
        addChild(homeVC)
        addChild(downloadVC)
        rightCustom.addSubview(homeVC.view, downloadVC.view)
        [homeVC.view, downloadVC.view].forEach {
            $0.snp.makeConstraints({ (make) in
                make.edges.equalToSuperview()
            })
        }
        downloadVC.view.isHidden = true
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    func selecteButon(_ index: Int) {
        [homeButton, downloadButton].forEach {
            $0?.state = .off
        }
        [homeVC.view, downloadVC.view].forEach {
            $0.isHidden = true
        }
        [homeButton, downloadButton][index].state = .on
         [homeVC.view, downloadVC.view][index].isHidden = false
        if index == 0 {
//            homeButton.state = .on
//            downloadButton.sta
        } else {
            
        }
    }
    

    @IBAction func homeButtonTap(_ sender: NSButton) {
        selecteButon(0)

        
    }
    @IBAction func downloadButtonTap(_ sender: NSButton) {
        selecteButon(1)
    }
    
}

