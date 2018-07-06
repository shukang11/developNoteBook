//
//  SXRViewController.swift
//  locolReact
//
//  Created by tree on 2018/5/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public class SXRViewController: UIViewController {
    
    var uri: URL
    var remoteURL: URL?
    
    var webView: WKWebView = {
        let o = WKWebView.init()
        return o
    }()
    
    convenience init(uri: URL, remoteURL: URL?) {
        self.init(uri: uri)
        self.remoteURL = remoteURL
    }
    
    init(uri: URL) {
        self.uri = uri
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        print("\(self.remoteURL?.absoluteString ?? " ")")
        self.view.addSubview(self.webView)
        self.webView.frame = self.view.bounds
        if let u = self.remoteURL {
            if let d = SXRRouteFileCache.shared.routeFileURLFor(remoteURL: u) {
                self.webView.load(URLRequest.init(url: d))
            }else {
                self.webView.load(URLRequest.init(url: u))
                if let data = NSData.init(contentsOf: u) {
                    SXRRouteFileCache.shared.saveRouteFile(data: data as Data, remoteURL: u)
                }
            }
        }
        
    }
    
}
