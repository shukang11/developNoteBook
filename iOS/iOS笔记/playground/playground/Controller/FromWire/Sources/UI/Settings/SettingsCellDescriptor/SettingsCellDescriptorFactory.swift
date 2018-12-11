//
//  SettingsCellDescriptorFactory.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import SafariServices
extension Notification.Name {
    static let DismissSettings = Notification.Name("DismissSettings")
}
class SettingsCellDescriptorFactory {
    
    static let settingsDevicesCellIdentifier: String = "devices"
    
    let settingsPropertyFactory: SettingsPropertyFactory
    
    class DismissStepDelegate: NSObject {
        var strongCapture: DismissStepDelegate?
        
        @objc func didCompleteFormStep(_ viewController: UIViewController!) {
            NotificationCenter.default.post(name: .DismissSettings, object: nil)
        }
    }
    init(settingsPropertyFactory: SettingsPropertyFactory) {
        self.settingsPropertyFactory = settingsPropertyFactory
    }
    
    func rootGroup() -> SettingsControllerGeneratorType & SettingsInternalGroupCellDescriptorType {
        var rootElement: [SettingsCellDescriptorType] = []

        rootElement.append(self.settingsGroup())
        let topSection: SettingsSectionDescriptor = SettingsSectionDescriptor(cellDescriptors: rootElement)
        return SettingsGroupCellDescriptor.init(items: [topSection], title: "设置")
    }
    
    func settingsGroup() -> SettingsCellDescriptorType & SettingsControllerGeneratorType {
        var topLevels = [SettingsCellDescriptorType]()
        topLevels.append(nameElement())
        topLevels.append(callSoundElement())
        let topSection = SettingsSectionDescriptor(cellDescriptors: topLevels)
        return SettingsGroupCellDescriptor.init(items: [topSection], title: "设置2")
    }
    
    // MARK: - Elements
    func nameElement() -> SettingsCellDescriptorType {
        return SettingsPropertyTextValueCellDescriptor(settingsProperty: settingsPropertyFactory.property(.profileName))
    }

    func callSoundElement() -> SettingsCellDescriptorType {
        return SettingsPropertyTextValueCellDescriptor(settingsProperty: settingsPropertyFactory.property(.callSoundName))
    }
}
