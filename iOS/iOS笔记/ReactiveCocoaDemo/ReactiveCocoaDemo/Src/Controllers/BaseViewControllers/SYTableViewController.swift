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
