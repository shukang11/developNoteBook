//
//  Utils.swift
//  playground
//
//  Created by tree on 2018/12/11.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

public enum FileType: String {

    case unknown = ""
    case jpg = "FFD8FF"
    case png = "89504E47"
    case gif = "47494638"
    case tif = "49492A00"
    case bmp = "424D"

    static let allTypes: [FileType] = [
        .jpg,
        .png,
        .gif,
        .tif,
        .bmp
    ]

    static func allTypePreMap() -> [FileType: String] {
        var map: [FileType: String] = [:]
        let allTypes = FileType.allTypes
        for type in allTypes {
            map.updateValue(type.rawValue, forKey: type)
        }
        return map
    }

    static func typeWithPrefix(_ prefix: String) -> FileType {
        print("\(prefix)")
        let allMap = FileType.allTypePreMap()
        for (type, key) in allMap {
            if prefix.starts(with: key) {
                return type
            }
        }
        return .unknown
    }
}

class ReadKitUtil {
    static func encodeStringFile(_ url: URL) -> String? {
        if let content = try? String.init(contentsOf: url) {
            return content
        }
        // GBK
        let cfGBKEncoding = CFStringEncodings.GB_18030_2000
        let gbkEncoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfGBKEncoding.rawValue))
        if let content = try? NSString.init(contentsOf: url, encoding: gbkEncoding) {
            return content as String
        }
        return nil
    }

    static func seperateChapters(_ chapters: inout [String], content: String) {
        chapters.removeAll()
        let parten = "第[0-9一二三四五六七八九十百千]*[章回].*"
        guard let reg = try? NSRegularExpression.init(pattern: parten, options: .caseInsensitive) else { return }
        let match = reg.matches(in: content, options: .reportCompletion, range: NSRange.init(location: 0, length: content.count))

        var lastRange = NSRange.init(location: 0, length: 0)
        let contentN = content as NSString
        for result in match.enumerated() {
            let range = result.element.range
            let index = result.offset

            if index == 0 {
                let sub = contentN.substring(with: NSRange.init(location: 0, length: range.location))
                chapters.append(sub)
            }

            if index > 0 {
                let sub = contentN.substring(with: lastRange)
                chapters.append(sub)
            }

            if index == match.count - 1 {
                let r = NSRange.init(location: range.location, length: contentN.length - range.location)
                let sub = contentN.substring(with: r)
                chapters.append(sub)
            }
            lastRange = range
        }
    }

    static func fileType(_ data: Data) -> FileType {
        let fileOffset = [UInt8](data)
        let offset = fileOffset[0...30]
        var prefix = ""
        for o in offset {
            prefix.append("\(String(format: "%0X", o))")
        }
        return FileType.typeWithPrefix(prefix)
    }
}
