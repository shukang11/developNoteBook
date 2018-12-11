//
//  WebBridge.swift
//  playground
//
//  Created by tree on 2018/11/1.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import WebKit
import JavaScriptCore

typealias webBridgeRespCallBack = ([String: Any])->(Any)
class WebBridge {
    
    var webView: WKWebView
    
    var callbackpool: [String: webBridgeRespCallBack] = [:]
    
    init(_ webView: WKWebView) {
        self.webView = webView
    }
    
    func evaluate(url: URL) -> Bool {
        if (url.absoluteString.contains("test")) {
            let command = "Butils.fireEvent('\(0)')"
            webView.evaluateJavaScript(command, completionHandler: nil)
            return true
        }
        return false
    }
}
