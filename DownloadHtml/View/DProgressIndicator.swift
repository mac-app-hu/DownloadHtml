//
//  DProgressIndicator.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/23.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Cocoa

class DProgressIndicator: NSView {
    let progressIndicator = NSProgressIndicator.init()
    let effectView = NSVisualEffectView()
    
    open func startAnimation() {
        isHidden = false
        progressIndicator.startAnimation(nil)
    }
    open func stopAnimation() {
        progressIndicator.stopAnimation(nil)
        isHidden = true
    }
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        isHidden = true
        addGestureRecognizer(NSClickGestureRecognizer.init(target: self, action: #selector(clickTap(_:))))
        effectView.blendingMode = .withinWindow
        effectView.state = .active
        
        progressIndicator.style = .spinning
        progressIndicator.isBezeled = true
        progressIndicator.controlTint = .defaultControlTint
        progressIndicator.controlSize = .regular
        //        progress.usesThreadedAnimation = true
        addSubview(effectView, progressIndicator)
        effectView.snp.makeConstraints { (make) in
//            make.edges.equalTo(NSEdgeInsets.init(top: 50, left: 50, bottom: 50, right: 50))
            make.center.equalToSuperview()
            make.width.height.equalTo(200)
        }
        progressIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(50)
        }
    }
    @objc func clickTap(_ sender: NSClickGestureRecognizer) {
//        print("NSClickGestureRecognizer")
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
