//
//  TopViewController.swift
//  SyncTool
//
//  Created by tree on 2018/3/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class func topViewController(from base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController)
        -> UIViewController? {
            if let nav = base as? UINavigationController {
                return topViewController(from: nav.visibleViewController)
            }
            if let tab = base as? UITabBarController,
                let selected = tab.selectedViewController {
                return topViewController(from: selected)
            }
            if let presented = base?.presentedViewController {
                return topViewController(from: presented)
            }
            return base
    }
}

public struct Log {
    static func assertionFailure(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) {
        Swift.assertionFailure("[LineSDK] \(message())", file: file, line: line)
    }
    
    static func fatalError(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Never {
        Swift.fatalError("[LineSDK] \(message())", file: file, line: line)
    }
    
    static func print(_ items: Any...) {
        let s = items.reduce("") { result, next in
            return result + String(describing: next)
        }
        Swift.print("[LineSDK] \(s)")
    }
}
