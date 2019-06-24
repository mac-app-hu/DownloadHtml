//
//  AppDelegate.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/21.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
       print(NSHomeDirectory())
        do {
            let picturesPath = (NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .allDomainsMask, true).first ?? (NSHomeDirectory() + "/Pictures")) + "/DownloadHtml"
            try FileManager.default.createDirectory(atPath: picturesPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
//        NSApplication.shared.
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        
    }


}

