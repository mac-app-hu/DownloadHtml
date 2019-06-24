//
//  UIViewCategory.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/22.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import AppKit
extension NSView {
    func addSubview(_ views: NSView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
extension NSAlert {
//    展示alert,只有一个按钮
    static func showAlert(currentView: NSView,
                          _ messageText: String?,
                          _ informativeText: String? = nil,
                          _ alertStyle: NSAlert.Style = .warning,
                          buttonTitle: String...,
        completionHandler handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        let alert = NSAlert()
        if let messageText = messageText {
            alert.messageText = messageText
        }
        if let informativeText = informativeText {
            alert.informativeText = informativeText
        }
        buttonTitle.forEach {
            alert.addButton(withTitle: $0)
        }
        let window = currentView.window ?? NSWindow()
        alert.alertStyle = alertStyle
        alert.beginSheetModal(for: window, completionHandler: handler)
//        alert.runModal()
    }
    static func showWarningAlert(currentView: NSView,
                          _ messageText: String?,
                          _ informativeText: String? = nil,
        completionHandler handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        showAlert(currentView: currentView, messageText, informativeText, .warning, buttonTitle: "确定", completionHandler: handler)
    }
    static func showInfoAlert(currentView: NSView,
                                 _ messageText: String?,
                                 _ informativeText: String? = nil,
                                 completionHandler handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        showAlert(currentView: currentView, messageText, informativeText, .informational, buttonTitle: "确定", completionHandler: handler)
    }
    static func showCriticalAlert(currentView: NSView,
                              _ messageText: String?,
                              _ informativeText: String? = nil,
                              completionHandler handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        showAlert(currentView: currentView, messageText, informativeText, .critical, buttonTitle: "确定", completionHandler: handler)
    }
}
