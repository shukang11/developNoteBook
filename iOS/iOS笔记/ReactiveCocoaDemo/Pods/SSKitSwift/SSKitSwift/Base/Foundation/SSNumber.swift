//
//  SSNumber.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation

public extension NSNumber {
    static func fromString(_ numString: String) -> NSNumber {
        let str: String = numString.trimString.lowercased()
        if (str.length == 0) { return NSNumber.init()}
        let dic:[String: Any] = ["true" : NSNumber.init(value: true),
                                 "yes" : NSNumber.init(value: true),
                                 "false":NSNumber.init(value: false),
                                 "no" : NSNumber.init(value: false),
                                 "nil" : NSNull.init(),
                                 "null" : NSNull.init(),
                                 "<null>":NSNull.init()]
        print("\(dic)")
        return NSNumber.init(value: 0)
    }
}
