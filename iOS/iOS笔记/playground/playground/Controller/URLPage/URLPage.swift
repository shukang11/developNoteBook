//
//  URLPage.swift
//  playground
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

let URLPushedPageLink = URL.init(string: "/page/URLPushedPage")!

class URLPage: SYTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createMainUI()
        
//        URLRouterManager.shared.register(URL.init(string: "/page/:pageClazz")!) { (params) in
//            guard let clz = params[RouterManager.URLRouteURLKey] as? String else { return }
//            
//        }
    }
    
    func createMainUI() -> Void {
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
        self.tableData = initTableData()
    }
    
    //MARK:delegate&dataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.tableView(tableView, numberOfRowsInSection:section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableData.tableView(tableView, heightForRowAt:indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableData.tableView(tableView, cellForRowAt: indexPath)
        let data = self.tableData[indexPath]
        if let d = data,
            d.cellType == TextCell.Key,
            let dict: [String: Any] = d.cellData as? [String: Any],
            let c: TextCell = cell as? TextCell {
            c.titleLabel.text = "【TextCell】 \(dict["title"] ?? "")"
            c.titleLabel.textColor = UIColor.black
            return c
        }
        else if let d = data, d.cellType == "1111" {
            cell.textLabel?.text = "UITableViewCell \(d.cellData as? String ?? "")"
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let c = self.tableData[indexPath] {
            if c.cellType == TextCell.Key,
                let dict: [String: Any] = c.cellData as? [String : Any],
                let target: String = dict["link"] as? String {
                self.startController(destination: target, extras: [
                    "title": "Pushed",
                    "privateV": "setted"
                    ])
            }
        }
    }
    
}

extension URLPage {
    func initTableData() -> TableViewConvertTable {
        var table = TableViewConvertTable()
        var section1 = TableViewConvertSection.init()
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "SingalPush", "link": "URLPushedPage"])
        )
        table.append(section1)
        return table
    }
}
