//
//  ViewController.swift
//  itemDetailDemo
//
//  Created by tree on 2018/3/15.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

let KSCREEN_WIDTH = UIScreen.main.bounds.width
let KSCREEN_HEIGHT = UIScreen.main.bounds.height

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UIWebViewDelegate {
    var content: UIScrollView = {
        let o = UIScrollView.init()
        o.frame = CGRect.init(x: 0.0, y: 64.0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT)
        o.contentInsetAdjustmentBehavior = .always
        return o
    }()
    
    var tableView: UITableView = {
        let o = UITableView.init()
        o.frame = CGRect.init(x: 0.0, y: 0.0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT-64.0)
        return o
    }()
    var webView: UIWebView = {
        let o = UIWebView.init()
        o.bounds = CGRect.init(x: 0.0, y: 0.0, width: KSCREEN_WIDTH, height: KSCREEN_HEIGHT-64.0)
        if let url = URL.init(string: "https://www.baidu.com") {
            o.loadRequest(URLRequest.init(url: url))
        }
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "详情"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.content)
        self.content.addSubview(self.tableView)
        self.content.addSubview(self.webView)
        self.webView.frame.origin = CGPoint.init(x: 0.0, y: KSCREEN_HEIGHT-64.0)
//        self.content.contentSize = CGSize.init(width: KSCREEN_WIDTH, height: self.tableView.frame.size.height + self.webView.frame.size.height + 64.0)
        self.content.delegate = self
        self.webView.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = tableView.dequeueReusableCell(withIdentifier: "cell")
        if c == nil { c = UITableViewCell.init(style: .default, reuseIdentifier: "cell") }
        guard let cell = c else { return UITableViewCell.init() }
        cell.textLabel?.text = "\(indexPath)"
        if indexPath.row == 19 { cell.textLabel?.text = "滑动进入下一页" }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.tableView {
            // 限定tableView动作
            print("\(scrollView.contentOffset.y)")
        }
    }
    
}

