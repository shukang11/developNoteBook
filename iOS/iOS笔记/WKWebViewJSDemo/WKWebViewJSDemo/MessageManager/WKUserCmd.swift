//
//  WKUserCmd.swift
//  WKWebViewJSDemo
//
//  Created by tree on 2018/8/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import WebKit

class WKUserCmd: NSObject {
    let script: WKUserScript
    
    init(script: WKUserScript) {
        self.script = script
        super.init()
    }
    
    convenience init(source: String, injectionTime: WKUserScriptInjectionTime, forMainFrameOnly: Bool) {
        let o = WKUserScript.init(source: source, injectionTime: injectionTime, forMainFrameOnly: forMainFrameOnly)
        self.init(script: o)
    }
}
