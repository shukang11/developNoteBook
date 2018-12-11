//
//  ViewController.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/7/20.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

/*
 ReactiveCocoa 链式编程
 */

class ViewController: SYTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "列表"
        self.view.backgroundColor = UIColor.white
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
            d.cellType == TextCell.Key,
            let dict: [String: Any] = d.cellData as? [String: Any],
            let c: TextCell = cell as? TextCell {
            c.titleLabel.text = " \(dict["title"] ?? "")"
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
                let target: UIViewController.Type = dict["target"] as? UIViewController.Type {
                let controller: UIViewController = target.init()
                controller.title = dict["title"] as? String
                self.navigationController?.pushViewController(controller, animated: true)
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
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Demo1 输入用户名", "target": ReactiveInputDemo.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "冷信号与热信号", "target": ReactiveSignalPage.self]))
        
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "RxSwift"]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Signal", "target": SignalPage.self]))
        
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Observable - 可被监听的序列", "target": ObservablePage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Single 是 Observable 的另外一个版本", "target": SinglePage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Completable 是 Observable 的另外一个版本", "target": CompletePage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Maybe 是 Observable 的另外一个版本", "target": MaybePage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "Driver 是 Observable 的另外一个版本", "target":  DriverPage.self]))
        
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "观察者", "target":  ObserverPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "操作符", "target":  OperatorPage.self]))
        
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "示例"]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "ImagePicker - 图片选择器", "target": ImagePickerPage.self]))
        
        
        table.append(section1)
        return table
    }
}


class TextCell: UITableViewCell {
    static let Key: String = {
        return "\(self)"
    }()
    
    var titleLabel: UILabel = {
        let o = UILabel.init()
        o.textColor = UIColor.randomColor()
        return o
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if #available(iOS 11.0, *) {
            self.titleLabel.frame = safeAreaLayoutGuide.layoutFrame
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
