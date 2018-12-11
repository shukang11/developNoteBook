//
//  SSPath.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/8.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation

/// 一个用来管理路径结构体，存储了一些常用的地址
public struct Path {
    public static let separator = "/"
    
    public var path: String
    
    public static var fileManager = FileManager.default
    
    public init() {
        self.path = ""
    }
    
    public init(_ path: String) {
        self.path = path
    }
    
    public init<S : Collection>(components: S) where S.Iterator.Element == String {
        if components.isEmpty {
            path = "."
        }else if components.first == Path.separator && components.count > 1 {
            let p = components.joined(separator: Path.separator)
            path = p.substring(from: p.index(after: p.startIndex))
        }else {
            path = components.joined(separator: Path.separator)
        }
    }
}

extension Path : CustomStringConvertible {
    public var description: String {
        return self.path
    }
}

extension Path : Equatable {}
public func ==(lhs: Path, rhs: Path) -> Bool {
    return lhs.path == rhs.path
}
public func +(lhs: Path, rhs: Path) -> Path {
    return Path.init(lhs.path+rhs.path)
}

extension Path : Hashable {
    public var hashValue: Int {
        return path.hashValue
    }
}

extension Path {
    public func read() throws -> Data {
        return try Data(contentsOf: URL.init(fileURLWithPath: path), options: Data.ReadingOptions.init(rawValue: 0))
    }
    
    public func read(_ encoding:String.Encoding = String.Encoding.utf8) throws -> String {
        return try NSString(contentsOfFile: path, encoding: encoding.rawValue).substring(from: 0) as String
    }
    
    public func write(_ data:Data) throws {
        try data.write(to: URL.init(fileURLWithPath: path), options: Data.WritingOptions.atomic)
    }
}
extension Path {
    public static var home:Path {
        return Path(NSHomeDirectory())
    }
    public static var temporary: Path {
        return Path(NSTemporaryDirectory())
    }
    public static var openStepRootDirectory: Path {
        return Path(NSOpenStepRootDirectory())
    }
    public static var documents: Path {
        let array = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return Path(array.first!)
    }
    
    public static var caches: Path {
        let array = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return Path(array.first!)
    }
//    public static func processUniqueTemporary() throws -> Path {
//        let path = temporary.path + ProcessInfo.processInfo.globallyUniqueString
//    }
//    public static func uniqueTemporary() throws -> Path {
//        
//    }
}

//MARK: BoolValue
extension Path {
    public var isAbsolute: Bool {
        return path.hasPrefix(Path.separator)
    }
    public var isRelative: Bool {
        return !isAbsolute
    }
    
    public var exists: Bool {
        return Path.fileManager.fileExists(atPath: self.path)
    }
    
    public var isDirectory: Bool {
        var directory = ObjCBool(false)
        guard Path.fileManager.fileExists(atPath: normalize().path, isDirectory: &directory) else {
            return false
        }
        return directory.boolValue
    }
    
    public var isFile: Bool {
        var directory = ObjCBool(false)
        guard Path.fileManager.fileExists(atPath: normalize().path, isDirectory: &directory) else {
            return false
        }
        return !directory.boolValue
    }
    
    public var isSymlink: Bool {
        do {
            let _ = try Path.fileManager.destinationOfSymbolicLink(atPath: normalize().path)
            return true
        } catch {
            return false
        }
    }
    
    public var isReadable: Bool {
        return Path.fileManager.isReadableFile(atPath: normalize().path)
    }
    public var isWritable: Bool {
        return Path.fileManager.isWritableFile(atPath: normalize().path)
    }
    public func normalize() -> Path {
        return Path(self.path)
    }
    public var isExecutable: Bool {
        return Path.fileManager.isExecutableFile(atPath: self.path)
    }
    public var isDeletable: Bool {
        return Path.fileManager.isDeletableFile(atPath: self.path)
    }
}

// MARK: - file maanipulation
extension Path {
    public func mkdir() throws -> () {
        try Path.fileManager.createDirectory(atPath: self.path, withIntermediateDirectories: false, attributes: nil)
    }
    public func mkpath() throws -> () {
        try Path.fileManager.createDirectory(atPath: self.path, withIntermediateDirectories: true, attributes: nil)
    }
    public func delete() throws -> () {
        try Path.fileManager.removeItem(atPath: self.path)
    }
    public func remove(_ dstination: Path) throws -> () {
        try Path.fileManager.moveItem(atPath: self.path, toPath: dstination.path)
    }
    public func copy(_ destination: Path) throws -> () {
        try Path.fileManager.copyItem(atPath: self.path, toPath: destination.path)
    }
    public func link(_ destination: Path) throws -> () {
        try Path.fileManager.linkItem(atPath: self.path, toPath: destination.path)
    }
    public func symlink(_ destination: Path) throws -> () {
        try Path.fileManager.createSymbolicLink(atPath: self.path, withDestinationPath: destination.path)
    }
}
extension Path {
    public static var current: Path {
        get {
            return self.init(Path.fileManager.currentDirectoryPath)
        }
        set {
            _ = Path.fileManager.changeCurrentDirectoryPath(newValue.description)
        }
    }
}
//组件
extension Path {
    public var lastComponent: String {
        return NSString(string: path).lastPathComponent
    }
    public var lastComponentWithoutExtension: String {
        return NSString(string: lastComponent).deletingPathExtension
    }
    public var components: [String] {
        return NSString(string: path).pathComponents
    }
    public var `extension`: String? {
        let pathExtension = NSString(string: path).pathExtension
        if  pathExtension.isEmpty {
            return nil
        }
        
        return pathExtension
    }

}
