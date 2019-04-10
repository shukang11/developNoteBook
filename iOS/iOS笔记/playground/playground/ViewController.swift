//
//  ViewController.swift
//  playground
//
//  Created by tree on 2018/4/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

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
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "高斯模糊", "target": BlurPage.self])
        )
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: UITableView.self, height: 44.0, cellData: ["title": "Block", "target": BlockPage.self])
        )
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "异步绘制Async", "target": AsyncPage.self])
        )
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "延迟加载TableView", "target": LazyLoadPage.self])
        )
        section1.append(
            TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "详情页布局1", "target": ItemDetailPage.self])
        )
        section1.append(
        TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "**公钥加密", "target": CerEncoderPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "JS传值", "target": JSWebPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "多线程异步统一回调", "target": MutilDownloadPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "自动布局动画", "target": AutoLayoutAnimationPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "贝塞尔曲线", "target": BenzierViewController.self]))
        
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "AudioFileStream", "target": AudioFileStreamPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "**解析器示例", "target": InterpreterPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "路由模块", "target": URLPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "js_bridge模块", "target": WebBridgePage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "动态行高测量", "target": DynamicTableViewPage.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "基于协议的网络请求", "target": ProtoNetViewController.self]))
        section1.append(TableViewConvertCell.init(cellType: TextCell.Key, cellClazz: TextCell.self, height: 44.0, cellData: ["title": "从Wire学习", "target": WireIndexPage.self]))
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
