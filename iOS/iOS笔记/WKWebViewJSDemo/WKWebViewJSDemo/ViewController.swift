//
//  ViewController.swift
//  WKWebViewJSDemo
//
//  Created by tree on 2018/8/15.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {
    
    let contentController: WKUserContentController = {
        let o = WKUserContentController.init()
        return o
    }()
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration.init()
        // preferences
        let p = WKPreferences.init()
        p.minimumFontSize = 10
        p.javaScriptEnabled = true
        p.javaScriptCanOpenWindowsAutomatically = false
        webConfiguration.preferences = p
        let o = WKWebView.init(frame: CGRect.zero, configuration: webConfiguration)
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 注入对象
        self.webView.configuration.userContentController.add(self as WKScriptMessageHandler, name: "baseAction")
        self.webView.frame = CGRect.init(x: 0.0, y: 64.0, width: self.view.frame.width, height: self.view.frame.height-64.0)
        self.view.addSubview(self.webView)
        
        let bundleURL = Bundle.main.bundleURL
        let sourceFloder = bundleURL.appendingPathComponent("www")
        let path = URL.init(fileURLWithPath: "index.html", relativeTo: sourceFloder)
        let request = URLRequest.init(url: path)
        self.webView.load(request)
        
    }
    
    //MARK:WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "baseAction" {
            if let params: [String: Any] = message.body as? [String : Any] {
                let cmd = "\(params["callback"] ?? "")(\"\(params["body"] ?? "")\")"
                print("\(cmd)")
                message.webView?.evaluateJavaScript(cmd, completionHandler: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        self.contentController.removeScriptMessageHandler(forName: "baseAction")
    }
}

