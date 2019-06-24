//
//  ImageFileManage.swift
//  DownloadHtml
//
//  Created by 全宇宙最帅的人 on 2019/6/23.
//  Copyright © 2019 goodbaby. All rights reserved.
//

import Cocoa

//public let picturesPath: String = {
//    var home = NSHomeDirectory() as NSString
//    home = home.appendingPathComponent("Pictures") as NSString
//    let pictures = NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .allDomainsMask, true).first as NSString? ?? home
//    return pictures.appendingPathComponent("DownloadHtml")
//}()
//public let picturesPath = (NSSearchPathForDirectoriesInDomains(.downloadsDirectory, .allDomainsMask, true).first ?? (NSHomeDirectory() + "/Pictures")) + "DownloadHtml"
public let picturesPath =  NSHomeDirectory() + "/DownloadHtml"

struct ImageFileManage {
    static let share = ImageFileManage()
    let fm = FileManager.default
    init() {
        checkFileExists()
        
    }
    //把文件写入目录
    public func createFile(contents: Data, fileName: String){
        checkFileExists()
        let path = picturesPath + "/\(fileName)"
        if !fm.fileExists(atPath: path) {
            fm.createFile(atPath: path, contents: contents, attributes: nil)
        }
        //打开文件目录
        NSWorkspace.shared.openFile(picturesPath)
    }
    private func checkFileExists() {
        if !fm.fileExists(atPath: picturesPath) {
            do {
                try fm.createDirectory(atPath: picturesPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }
    }
}
