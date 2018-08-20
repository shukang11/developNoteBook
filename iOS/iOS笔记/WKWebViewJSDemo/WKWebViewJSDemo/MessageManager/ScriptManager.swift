//
//  ScriptManager.swift
//  WKWebViewJSDemo
//
//  Created by tree on 2018/8/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import WebKit

class ScriptManager: NSObject, WKScriptMessageHandler {
    
    private var cmds: [WKUserCmd] = []
    
    //MARK:WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
}
