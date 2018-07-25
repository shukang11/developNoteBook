//
//  TableViewConver.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/31.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UIKit

//MARK:-
//MARK:tableview相关

fileprivate struct kTableViewConstant {
    static let header: String = "sectionHeader"// 区头
    static let footer: String = "sectionFooter"// 区尾
    static let sectionCount: String = "sectionCount"// 区数量
    static let numberOfRows: String = "numberOfRows"// 行数
    
    static let cellList: String = "cellList" // 行集合
    static let cellData: String = "cellData"// 行数据
    static let cellType: String = "cellType"// 行样式
    static let cellHeight: String = "cellHeight"// 行高
    
    static let cellDefaultType: String = "cellDefaultType"// 默认的样式

}

protocol DictionaryConvertAble {
    func asDict() -> [String: Any]
}

protocol ArrayConvertAble {
    func asArray() -> [Any]
}

fileprivate protocol TableResponseAble {
    // delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    // DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    func numberOfSections(in tableView: UITableView) -> Int
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

public struct TableViewConvertTable: ArrayConvertAble, TableResponseAble {
   
    private var sectionList: [TableViewConvertSection] = []
    
    var sectionCount: Int { return sectionList.count }
    
    // 会改变属性的值
    mutating func append(_ section: TableViewConvertSection) {
        self.sectionList.append(section)
    }
    
    func asArray() -> [Any] {
        var o = Array<Dictionary<String, Any>>()
        for section in self.sectionList {
            o.append(section.asDict())
        }
        return o
    }
    
    public subscript(_ indexPath: IndexPath) -> TableViewConvertCell? {
        let sect: TableViewConvertSection = self.sectionList[indexPath.section]
        return sect[indexPath.row]
    }
    
    /// TableResponseAble
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sect: TableViewConvertSection = self.sectionList[indexPath.section]
        if let row: TableViewConvertCell = sect[indexPath.row], let result = row.asDict()[kTableViewConstant.cellHeight] as? CGFloat {
            return result
        }
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sectionList.count > 0 else { return 0 }
        let sect: TableViewConvertSection = self.sectionList[section]
        return sect.rowCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        guard let data: TableViewConvertCell = self[indexPath] else { return UITableViewCell.init(style: .value1, reuseIdentifier: kTableViewConstant.cellDefaultType) }
        cell = tableView.dequeueReusableCell(withIdentifier: data.cellType)
        if cell == nil
            && data.cellClass?.isSubclass(of: UITableViewCell.self) == true {
            tableView.register(data.cellClass, forCellReuseIdentifier: data.cellType)
            cell = tableView.dequeueReusableCell(withIdentifier: data.cellType)
        }else if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: kTableViewConstant.cellDefaultType)
        }
        return cell!
    }
}


/// 区头区尾等
public struct TableViewConvertView: DictionaryConvertAble {
    
    var viewType: String = "UITableViewView"
    
    var viewHeight: Float = 44.0
    
    var viewData: Any? = nil
    
    func asDict() -> [String : Any] {
        var o = [String: Any]()
        o[kTableViewConstant.cellType] = viewType
        o[kTableViewConstant.cellHeight] = viewHeight
        if let data = viewData {
            o[kTableViewConstant.cellData] = data
        }
        return o
    }
}

public struct TableViewConvertSection: DictionaryConvertAble {
    //MARK:-
    //MARK:properties
    private var cellList: [TableViewConvertCell] = []
    
    var sectionHeader: TableViewConvertView? = nil
    
    var sectionFooter: TableViewConvertView? = nil
    
    public mutating func append(_ cell: TableViewConvertCell) { cellList.append(cell) }
    
    public mutating func pop() -> TableViewConvertCell? {
        return cellList.popLast()
    }
    
    func rowCount() -> Int { return cellList.count }
    
    public subscript(_ row: Int) -> TableViewConvertCell? {
        return cellList[row]
    }
    
    func asDict() -> [String : Any] {
        var o = [String: Any]()
        if cellList.count > 0 {
            o[kTableViewConstant.cellList] = cellList.map({ (cell) -> [String: Any] in
                return cell.asDict()
            })
        }
        o[kTableViewConstant.numberOfRows] = cellList.count
        if let header = sectionHeader {
            o[kTableViewConstant.header] = header.asDict()
        }
        if let footer = sectionFooter {
            o[kTableViewConstant.footer] = footer.asDict()
        }
        return o
    }
}

public struct TableViewConvertCell: DictionaryConvertAble {
    //MARK:-
    //MARK:properties
    var cellType: String = kTableViewConstant.cellDefaultType
    
    var cellHeight: CGFloat = 44.0
    
    var cellClass: AnyClass?// 对应单元格的类
    
    var cellData: Any? = nil
    
    func asDict() -> [String : Any] {
        var o = [String: Any]()
        o[kTableViewConstant.cellType] = self.cellType
        o[kTableViewConstant.cellHeight] = self.cellHeight
        if let data = cellData {
            o[kTableViewConstant.cellData] = data
        }
        return o
    }
    init(cellType: String, cellClazz: AnyClass?, height: CGFloat, cellData: Any?) {
        self.cellType = cellType
        self.cellHeight = height
        self.cellData = cellData
        self.cellClass = cellClazz
        
    }
}
