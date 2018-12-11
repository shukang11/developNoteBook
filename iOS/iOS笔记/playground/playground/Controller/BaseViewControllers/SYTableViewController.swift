//
//  SYTableViewController.swift
//  SyncTool
//
//  Created by tree on 2018/3/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

// 继承于SYViewController ，同时实现了TableView拓展协议
class SYTableViewController: SYViewController, TableExtAble {
    //MARK:property
    var tableData: TableViewConvertTable = TableViewConvertTable()
    
    override lazy var tableView: UITableView = {
        let o = UITableView.tableView()
        o.delegate = self
        o.dataSource = self
        return o
    }()
    
    override lazy var groupTableView: UITableView = {
        let o = UITableView.groupTableView()
        o.delegate = self
        o.dataSource = self
        return o
    }()
    
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        
    }
}

extension SYTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell.init(style: .default, reuseIdentifier: nil)
    }
}

extension SYTableViewController: UITableViewDelegate {
    
}
