//
//  JSWebPage.swift
//  playground
//
//  Created by tree on 2018/6/28.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import JavaScriptCore


class JSWebPage: SYViewController, UIWebViewDelegate {
    //MARK:property
    var webView: UIWebView = {
        let o = UIWebView.init()
        return o
    }()
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createUI()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        self.view.addSubview(self.webView)
        self.webView.backgroundColor = UIColor.randomColor()
        self.webView.delegate = self
        self.webView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(
                    self.navigationController?.additionalSafeAreaInsets ?? UIEdgeInsets.zero
                )
            }else {
                make.edges.equalToSuperview()
            }
        }
        if let path = Bundle.main.path(forResource: "jsContentPage", ofType: "html") {
            let url = URL.init(fileURLWithPath: path)
            self.webView.loadRequest(URLRequest.init(url: url))
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let fileName = "20160528 171009.m4a"
//        let fileName = "wallhaven-540738.png"
        guard let sourcePath = Bundle.main.path(forResource: fileName, ofType: nil) else { return }
        let sourceURL = URL(fileURLWithPath: sourcePath)
        var targetPath = ""
        if #available(iOS 10.0, *) {
            let targetURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            try? FileManager.default.copyItem(at: sourceURL, to: targetURL)
            targetPath = targetURL.absoluteString.replaceString(replace: "file://", by: "")
        }
        if let jsContext: JSContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext {
                let path = targetPath
            let arg = "_privateF(\"\(path)\");"
            print("\(arg)")
            jsContext.evaluateScript(arg)
        }
        //oc 调用 js")
    }
}
