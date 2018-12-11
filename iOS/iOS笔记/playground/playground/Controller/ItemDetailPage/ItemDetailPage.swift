//
//  ItemDetailPage.swift
//  playground
//
//  Created by tree on 2018/6/4.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class ItemDetailPage: SYViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK:property
    var detailVM: ItemDetailViewModel = {
        let o = ItemDetailViewModel.init()
        return o
    }()
    
    var contentView: UIScrollView = {
        let o = UIScrollView.init()
        o.bounces = true
        return o
    }()
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailVM.datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        guard let c = cell else { return UITableViewCell.init() }
        let item = self.detailVM.datas[row]
        c.textLabel?.text = item.title
        c.imageView?.kf.setImage(with: URL(string: item.imageURL))
        c.detailTextLabel?.text = item.desc
        return c
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.tableView {
            if ((scrollView.contentSize.height - scrollView.contentOffset.y) < (self.view.ss_height - 100.0)) {
                self.contentView.setContentOffset(CGPoint.init(x: 0.0, y: self.tableView.ss_height), animated: true)
            }
        }else if scrollView == self.webView.scrollView {
            if scrollView.contentOffset.y < -170.0 {
                self.contentView.setContentOffset(CGPoint.init(x: 0.0, y: 0.0), animated: true)
            }
        }
        
    }
    //MARK:customMethod
    private func createUI() {
        view.addSubview(contentView)
        contentView.backgroundColor = UIColor.randomColor()
        
        contentView.addSubview(self.tableView)
        contentView.addSubview(self.webView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.contentView.snp.makeConstraints {(make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(
                    self.navigationController?.additionalSafeAreaInsets ?? UIEdgeInsets.zero
                )
            }else {
                make.edges.equalToSuperview()
            }
        }
        self.webView.backgroundColor = UIColor.randomColor()
        self.webView.scrollView.delegate = self
        self.webView.snp.makeConstraints { (make) in
            make.size.equalTo(self.view.ss_size)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.tableView.snp.bottom)
        }
        
        self.detailVM.request { (error) in
            if error == nil {
                self.tableView.reloadData()
            }
        }
        if let url = URL.init(string: "https://www.baidu.com") {
            self.webView.loadRequest(URLRequest.init(url: url))
        }
    }
}


