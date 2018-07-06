//
//  SxrRouteFileCache.swift
//  网络缓存
//
//  Created by tree on 2018/5/18.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

public class SXRRouteFileCache: NSObject {
    
    static let routeMapFileName = "routes.json"
    
    static var `shared` = SXRRouteFileCache()
    
    /// 缓存路径
    private var cachePath: String?
    
    /// 资源的路径
    var resourcePath: String?

    public var cacheFileSize: Int {
        get {
            if let path = cachePath {
                return self.fileSizeAt(path)
            }
            return 0
        }
    }
    
    private override init() {
        if let idf = Bundle.main.bundleIdentifier {
            let cache = idf.appending(".sxr")
            if let c = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first?.appending("/\(cache)") {
                self.cachePath = c
                try? FileManager.default.createDirectory(atPath: c, withIntermediateDirectories: true, attributes: nil)
                print("\(c)")
            }
        }
        self.resourcePath = ""
    }
    
    public func cleanCache() -> Void {
        if let c = self.cachePath {
            try? FileManager.default.removeItem(atPath: c)
            try? FileManager.default.createDirectory(atPath: c, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    /// 将路由信息存储到本地
    ///
    /// - Parameter data: 远端的路由表信息
    public func saveRouteMap(data: Data?) -> Void {
        if let path = self.cachePath?.appending("/\(SXRRouteFileCache.routeMapFileName)") {
            guard let d = data else {
                try? FileManager.default.removeItem(atPath: path)
                return
            }
            (d as NSData).write(toFile: path, atomically: true)
        }
    }
    
    public func routeMap() -> Data? {
        if let path = self.cachePath?.appending("/\(SXRRouteFileCache.routeMapFileName)") {
            if FileManager.default.fileExists(atPath: path) {
                return try? NSData.init(contentsOfFile: path) as Data
            }
        }
        return nil
    }
    
    /// 将远端的文件缓存到本地
    ///
    public func saveRouteFile(data: Data?, remoteURL: URL) -> Void {
        if let filepath = self.cachedRouteFilePathFor(remoteURL: remoteURL) {
            guard let d = data as NSData? else {
                try? FileManager.default.removeItem(atPath: filepath)
                return
            }
            d.write(toFile: filepath, atomically: true)
        }
    }
    
    /// 根据远端URL获得本地缓存的数据
    ///
    public func dataFor(remoteURL: URL) -> Data? {
        if let filepath = self.cachedRouteFilePathFor(remoteURL: remoteURL) {
            if FileManager.default.fileExists(atPath: filepath) == true {
                return NSData.init(contentsOfFile: filepath) as Data?
            }
        }
        return nil
    }
    
    /// 根据远端URL查找本地的缓存
    ///
    func routeFileURLFor(remoteURL:URL) -> URL? {
        if let filepath = self.cachedRouteFilePathFor(remoteURL: remoteURL) {
            if FileManager.default.fileExists(atPath: filepath) == true {
                return URL.init(fileURLWithPath: filepath)
            }
        }
        return nil
    }
    //MARK:-
    //MARK:private
    
    /// 将远端的地址转换成本地的路径
    ///
    private func cachedRouteFilePathFor(remoteURL: URL) -> String? {
        var md5 = "\(remoteURL.hashValue)"
        let ext = remoteURL.pathExtension
        if ext.count > 0 { md5.append(".\(ext)") }
        return self.cachePath?.appending("/\(md5)")
    }
    
    private func fileSizeAt(_ path: String) -> Int {
        var totolsize = 0
        if let contents = try? FileManager.default.contentsOfDirectory(atPath: path) {
            for item in contents {
                let itemPath = path.appending("/\(item)")
                if let attrs = try? FileManager.default.attributesOfItem(atPath: itemPath) {
                    if let type = attrs[.type] as? FileAttributeType {
                        if type == .typeDirectory {
                            totolsize += self.fileSizeAt(itemPath)
                        }else if let size = attrs[.size] as? Int {
                            totolsize += size
                        }
                    }
                }
            }
        }
        return totolsize
    }
}

