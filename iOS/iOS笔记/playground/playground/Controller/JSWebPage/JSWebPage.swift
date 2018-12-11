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
        guard let pa = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
//        let targetPath = "\(pa)/20160528 171009.m4a"
        let targetPath = "\(pa)/wallhaven-540738.png"

//        if let filePath = Bundle.main.path(forResource: "20160528 171009.m4a", ofType: nil), let pa = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
//            let targetPath = "\(pa)/20160528 171009.m4a"
//            let data = NSData.init(contentsOf: URL.init(fileURLWithPath: filePath))
//            data?.write(to: URL.init(fileURLWithPath: targetPath), atomically: false)
//            print("\(targetPath)")
//        }
        if let jsContext: JSContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext/*,
            let path = Bundle.main.path(forResource: "20160528 171009.m4a", ofType: nil)*/ {
                let path = targetPath
                
            let arg = "_privateF(\"\(path)\");"
            print("\(arg)")
            jsContext.evaluateScript(arg)
        }
        //oc 调用 js")
    }
}
