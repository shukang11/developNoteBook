//
//  ViewController.swift
//  LocalHtmlLoadDemo
//
//  Created by tree on 2018/8/15.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    let webView: UIWebView = {
        let o = UIWebView.init()
        return o
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "加载本地HTML"
        self.webView.frame = CGRect.init(x: 0.0, y: 64.0, width: self.view.frame.width, height: self.view.frame.height-64.0)
        self.view.addSubview(self.webView)
        
        /**
         let bundlePath = Bundle.main.bundlePath
         let basePath = "\(bundlePath)/htmlCode"
         let baseURL = URL.init(fileURLWithPath: basePath, isDirectory: true)
         
         
         self.webView.loadRequest(URLRequest.init(url: URL.init(fileURLWithPath: "index.html", relativeTo: baseURL)))
         */
        if let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let floderPath = "\(documentPath)/htmlCode"
            print("\(floderPath)")
            // 如果加载不成功是因为文件夹不存在
            let baseURL = URL.init(fileURLWithPath: floderPath, isDirectory: true)
            self.webView.loadRequest(URLRequest.init(url: URL.init(fileURLWithPath: "index.html", relativeTo: baseURL)))
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

