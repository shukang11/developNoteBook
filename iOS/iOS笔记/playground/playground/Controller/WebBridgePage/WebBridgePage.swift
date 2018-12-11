//
//  WebBridgePage.swift
//  playground
//
//  Created by tree on 2018/11/1.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import WebKit

class WebBridgePage: SYViewController {
    
    lazy var bridge: WebBridge = {
        let o = WebBridge.init(webView)
        return o
    }()
    
    lazy var webView: WKWebView = {
        let o = WKWebView.init()
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)
        self.webView.backgroundColor = UIColor.randomColor()
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        self.webView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(
                    self.navigationController?.additionalSafeAreaInsets ?? UIEdgeInsets.zero
                )
            }else {
                make.edges.equalToSuperview()
            }
        }
        
        if let path = Bundle.main.path(forResource: "bridgeIndex.html", ofType: nil) {
            let url = URL.init(fileURLWithPath: path)
            self.webView.load(URLRequest.init(url: url))
        }
    }
}


extension WebBridgePage: WKNavigationDelegate {
    //MARK: 加载前判断是否需要加载
    // 是否允许跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            DLog("\(url)")
            if (self.bridge.evaluate(url: url) == true) {
                // 此处需要完善原生端的base，主要是可以对js端的各种回应
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    
    
    //MARK:下载指定内容的回调
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    //MARK: 下载后载入视图
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = webView.title
    }
}


extension WebBridgePage: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        guard let target = navigationAction.targetFrame else {return nil }
        if target.isMainFrame {
            webView.load(target.request)
        }
        return nil
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        DLog("webViewDidClose call close() successed")
    }
    
    // 显示确认按钮
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .default, handler: { (_) -> Void in
            completionHandler(false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
