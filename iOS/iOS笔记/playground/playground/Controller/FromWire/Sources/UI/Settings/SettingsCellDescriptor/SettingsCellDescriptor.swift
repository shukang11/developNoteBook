//
//  SettingsCellDescriptor.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
// 描述一个cell
protocol SettingsCellDescriptorType: class {
    
    static var cellType: SettingsTableCell.Type { get }
    
    var visible: Bool { get }
    
    var title: String { get }
    
    var identifier: String? { get }
    
    var group: SettingsGroupCellDescriptorType? { get }
    
    
    func select(_: SettingsPropertyValue?)
    
    func featureCell(_: SettingsCellType)
}

func ==(left: SettingsCellDescriptorType, right: SettingsCellDescriptorType) -> Bool {
    if let leftID = left.identifier,
        let rightID = right.identifier {
        return leftID == rightID
    }
    else {
        return left == right
    }
}

// 行的预览
typealias PreviewGeneratorType = (SettingsCellDescriptorType) -> SettingsCellPreview

// 界面的子协议
protocol SettingsGroupCellDescriptorType: SettingsCellDescriptorType {
    var viewController: UIViewController? { get set }
}

// section的描述
protocol SettingsSectionDescriptorType: class {
    var cellDescriptors: [SettingsCellDescriptorType] { get }
    var visibleCellDescriptors: [SettingsCellDescriptorType] { get }
    var header: String? { get }
    var footer: String? { get }
    var visible: Bool  { get }
}

// section 拓展
extension SettingsSectionDescriptorType {
    func allCellDescriptors() -> [SettingsCellDescriptorType] {
        return cellDescriptors
    }
}

// tableview的样式
enum InternalScreenStyle {
    case plain
    case grouped
}

// 内部的group,以section为单位
protocol SettingsInternalGroupCellDescriptorType: SettingsGroupCellDescriptorType {
    var items: [SettingsSectionDescriptorType] { get }
    var visibleItems: [SettingsSectionDescriptorType] { get }
    var style: InternalScreenStyle { get }
}

extension SettingsInternalGroupCellDescriptorType {
    func allCellDescriptors() -> [SettingsCellDescriptorType] {
        return items.flatMap({ (section: SettingsSectionDescriptorType) -> [SettingsCellDescriptorType] in
            return section.allCellDescriptors()
        })
    }
}

// 外部的协议？
protocol SettingsExternalScreenCellDescriptorType: SettingsGroupCellDescriptorType {
    var presentationAction: () -> (UIViewController?) { get }
}

// 暂时忽略
protocol SettingsPropertyCellDescriptorType: SettingsCellDescriptorType {
    var settingsProperty: SettingsProperty { get }
}

protocol SettingsControllerGeneratorType {
    func generateViewController() -> UIViewController
}

// MARK: Class

// sectionDescriptor
class SettingsSectionDescriptor: SettingsSectionDescriptorType {
    var cellDescriptors: [SettingsCellDescriptorType] = []
    
    var visibleCellDescriptors: [SettingsCellDescriptorType] {
        return self.cellDescriptors.filter { $0.visible }
    }
    
    var header: String?
    
    var footer: String?
    
    var visible: Bool {
        get {
            if let visibilityAction = self.visibilityAction {
                return visibilityAction(self)
            }else { return true }
        }
    }
    
    let visibilityAction: ((SettingsSectionDescriptorType) -> (Bool))?
    
    init(cellDescriptors: [SettingsCellDescriptorType],
         header: String? = .none,
         footer: String? = .none,
         visibilityAction: ((SettingsSectionDescriptorType) -> (Bool))? = .none) {
        self.cellDescriptors = cellDescriptors
        self.header = header
        self.footer = footer
        self.visibilityAction = visibilityAction
    }
}

class SettingsGroupCellDescriptor: SettingsInternalGroupCellDescriptorType, SettingsControllerGeneratorType {
    static let cellType: SettingsTableCell.Type = SettingsTableCell.self
    
    weak var viewController: UIViewController?
    
    var visible: Bool = true
    
    var title: String
    
    let style: InternalScreenStyle
    
    let items: [SettingsSectionDescriptorType]
    
    var identifier: String?
    
    let previewGenerator: PreviewGeneratorType?
    
    weak var group: SettingsGroupCellDescriptorType?
    
    var visibleItems: [SettingsSectionDescriptorType] {
        return self.items.filter {
            $0.visible
        }
    }
    
    init(items: [SettingsSectionDescriptorType],
         title: String,
         style: InternalScreenStyle = .grouped,
         identifier: String? = .none,
         previewGenerator: PreviewGeneratorType? = .none) {
        self.previewGenerator = previewGenerator
        self.identifier = identifier
        self.title = title
        self.items = items
        self.style = style
    }
    
    func select(_: SettingsPropertyValue?) {
        if let navigation = self.viewController?.navigationController {
            let destination = self.generateViewController()
            navigation.pushViewController(destination, animated: true)
        }
    }
    
    func generateViewController() -> UIViewController {
        return SettingsTableViewController(group: self)
    }
    
    func featureCell(_ cell: SettingsCellType) {
        cell.titleText = self.title
        if let pre = self.previewGenerator {
            let p = pre(self)
            cell.preview = p
        }
    }
}
