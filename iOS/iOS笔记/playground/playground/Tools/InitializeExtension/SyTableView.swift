//
//  SyTableView.swift
//  SyncTool
//
//  Created by tree on 2018/3/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    class func tableView() -> UITableView {
        let _tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .plain)
        _tableView.setInitProperty()
        return _tableView
    }
    
    class func groupTableView() -> UITableView {
        let _tableView : UITableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        _tableView.setInitProperty()
        return _tableView
    }
    
    private func setInitProperty() {
        self.indicatorStyle = .white
        self.isScrollEnabled = true
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.clear
        self.backgroundView = nil
        self.tableFooterView = UIView.init()
        
        self.sectionHeaderHeight = 0.0
        self.sectionFooterHeight = 0.0
        
        self.separatorStyle = .singleLine

        if #available(iOS 11.0, *) {
            self.insetsContentViewsToSafeArea = true
        }
    }
}
