//
//  WireIndexPage.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
import SSExteionComponents

typealias CallAble = () -> ()

class WireIndexPage: SYTableViewController {
    
    var documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    var manager: AccountManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "列表"
        self.view.backgroundColor = UIColor.white
        self.manager = AccountManager.init(sharedDirectory: URL.init(fileURLWithPath: documentPath))
        self.createUI()
        
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
            d.cellType == TextCell.Key || d.cellType == "settingsCell",
            let dict: [String: Any] = d.cellData as? [String: Any],
            let c: TextCell = cell as? TextCell {
            c.titleLabel.text = "【TextCell】 \(dict["title"] ?? "")"
            c.titleLabel.textColor = UIColor.black
            c.titleLabel.font = FontSpec(.normal, .regular).font!
            //            c.titleLabel.backgroundColor(UIImage.shadowImage(2.0, color: UIColor.black)!)
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
                let dict: [String: Any] = c.cellData as? [String : Any] {
                if let target: CallAble = dict["target"] as? CallAble {
                    target()
                }else if let target: UIViewController.Type = dict["target"] as? UIViewController.Type {
                    let controller: UIViewController = target.init()
                    controller.title = dict["title"] as? String
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            }else if c.cellType == "settingsCell" {
                // 设置
                let settingspropertyFactory = SettingsPropertyFactory.init(userDefaults: UserDefaults.standard)
                let settingsCellDescriptorFactory = SettingsCellDescriptorFactory(settingsPropertyFactory: settingspropertyFactory)
                let rootGroup = settingsCellDescriptorFactory.rootGroup()
                let page = SettingsTableViewController.init(group: rootGroup)
                self.navigationController?.pushViewController(page, animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func createUI() {
        view.backgroundColor = UIColor.gray
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {(make) in
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
    
    func initTableData() -> TableViewConvertTable {
        var table = TableViewConvertTable()
        var section1 = TableViewConvertSection.init()
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Account", "target": {
                let a = Account.init(userName: "test", userIdentifier: UUID.init())
                let i = UIImage.init(named: "wallhaven-540738")
                a.imageData = UIImageJPEGRepresentation(i!, 0.1)
                self.manager.addOrUpdate(a)
                }]))
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "视图的张力设置", "target": ViewHuggingPage.self]))
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "MVVMPage", "target": MVVMPage.self]))
        section1.append(
            TableViewConvertCell.init(cellType: "settingsCell", cellClazz: TextCell.self, height: 44.0, cellData: ["title": "SettingsPage"]))
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "SignInViewController", "target": SignInViewController.self]))
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "PageViewController", "target": PageViewController.self]))

        table.append(section1)
        return table
    }
}

