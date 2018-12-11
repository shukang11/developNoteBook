//
//  SettingsPropertyTextValueCellDescriptor.swift
//  playground
//
//  Created by tree on 2018/11/21.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

class SettingsPropertyTextValueCellDescriptor: SettingsPropertyCellDescriptorType {
    
    static var cellType: SettingsTableCell.Type = SettingsTableCell.self
    
    var visible: Bool = true
    
    var title: String {
        get {
            return "我是标签,但是你需要通过其他方式来设置"
        }
    }
    
    var identifier: String?
    
    weak var group: SettingsGroupCellDescriptorType?
    
    var settingsProperty: SettingsProperty
    
    func select(_ value: SettingsPropertyValue?) {
        if let stringValue = value?.value() as? String {
            do {
                try self.settingsProperty << SettingsPropertyValue.string(value: stringValue)
            }catch let e as NSError {
                DLog("error \(e)")
            }
        }
    }
    
    func featureCell(_ cell: SettingsCellType) {
        cell.titleText = self.title
        if let textCell = cell as? SettingsTextCell,
            let stringValue = self.settingsProperty.rawValue() as? String {
            textCell.textInput.text = stringValue
        }
    }
    
    init(settingsProperty: SettingsProperty, identifier: String? = .none) {
        self.settingsProperty = settingsProperty
        self.identifier = identifier
    }
}
