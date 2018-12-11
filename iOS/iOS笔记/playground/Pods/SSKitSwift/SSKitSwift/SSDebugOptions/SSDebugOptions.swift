//
//  SSDebugOptions.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/2/4.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation

public func DLog<T>(_ message:T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent), \(method)[\(line)],: \(message)")
    #endif
}

