//
//  DynamicTableViewPage.swift
//  playground
//
//  Created by tree on 2018/11/2.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class DynamicTableViewPage: SYTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(
                    self.navigationController?.additionalSafeAreaInsets ?? UIEdgeInsets.zero
                )
            }else {
                make.edges.equalToSuperview()
            }
        }
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableData = self.getTableData()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let n = self.tableData.tableView(tableView, numberOfRowsInSection: section)
        return n
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = self.tableData.tableView(tableView, cellForRowAt: indexPath)
        if let d = self.tableData[indexPath] {
            switch d.cellType {
            case "d1":
                c.textLabel?.numberOfLines = 0
                c.textLabel?.text = d.cellData as? String
                c.textLabel?.textColor = UIColor.randomColor()
                break
            case "d2":
                if let c2: TwoViewCell = c as? TwoViewCell, let d2 = d.cellData as? [String: String] {
                    c2.firstLabel.text = d2["first"]
                    c2.secondLabel.text = d2["second"]
                }
                break
            case "d3":
                if let c3: TwoOriViewCell = c as? TwoOriViewCell,
                    let d3 = d.cellData as? String {
                    c3.titleLable.text = d3
                }
                break
            default:
                break
            }
        }
        return c
    }
}

extension DynamicTableViewPage {
    func getTableData() -> TableViewConvertTable {
        var table = TableViewConvertTable.init()
        var sect = TableViewConvertSection.init()
        sect.append({
            let c = TableViewConvertCell.init(cellType: "d2", cellClazz: TwoViewCell.self, height: 0, cellData: [
                "first": "aaa".aligenRight(totalLength: 50, pad: "*"),
                "second": "ddd".aligenRight(totalLength: 70, pad: "=")
                ])
            return c
            }())
        sect.append({
            let c = TableViewConvertCell.init(cellType: "d1", cellClazz: UITableViewCell.self, height: 0, cellData: "124".aligenRight(totalLength: 200, pad: "3"))
            return c
            }())
        sect.append({
            let c = TableViewConvertCell.init(cellType: "d3", cellClazz: TwoOriViewCell.self, height: 0, cellData: "左右动态约束")
            return c
            }())
        
//        sect.append({
//            let c = TableViewConvertCell.init(cellType: "d4", cellClazz: XIBTextCell.self, height: 0, cellData: "左右动态约束")
//            return c
//            }())
        table.append(sect)
        return table
    }
}
