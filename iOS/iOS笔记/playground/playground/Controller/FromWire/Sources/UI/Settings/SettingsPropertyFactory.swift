//
//  SettingsPropertyFactory.swift
//  playground
//
//  Created by tree on 2018/11/21.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

protocol SettingsPropertyFactoryDelegate: class {
    func asyncMethodDidStart(_ settingsPropertyFactory: SettingsPropertyFactory)
    func asyncMethodDidComplete(_ settingsPropertyFactory: SettingsPropertyFactory)
}

class SettingsPropertyFactory {
    let userDetaults: UserDefaults
    
    static let userDefaultsPropertiesToKeys: [SettingsPropertyName: String] = [
        SettingsPropertyName.disableMarkdown            : Settings.UserDefaultDisableMarkdown,
        SettingsPropertyName.chatHeadsDisabled          : Settings.UserDefaultChatHeadsDisabled,
        SettingsPropertyName.messageSoundName           : Settings.UserDefaultMessageSoundName,
        SettingsPropertyName.callSoundName              : Settings.UserDefaultCallSoundName,
        SettingsPropertyName.pingSoundName              : Settings.UserDefaultPingSoundName,
        SettingsPropertyName.disableSendButton          : Settings.UserDefaultSendButtonDisabled,
        SettingsPropertyName.mapsOpeningOption          : Settings.UserDefaultMapsOpeningRawValue,
        SettingsPropertyName.browserOpeningOption       : Settings.UserDefaultBrowserOpeningRawValue,
        SettingsPropertyName.tweetOpeningOption         : Settings.UserDefaultTwitterOpeningRawValue,
        SettingsPropertyName.callingProtocolStrategy    : Settings.UserDefaultCallingProtocolStrategy,
        SettingsPropertyName.enableBatchCollections     : Settings.UserDefaultEnableBatchCollections,
        SettingsPropertyName.callingConstantBitRate     : Settings.UserDefaultCallingConstantBitRate,
        SettingsPropertyName.disableLinkPreviews        : Settings.UserDefaultDisableLinkPreviews,
    ]
    
    
    init(userDefaults: UserDefaults) {
        self.userDetaults = userDefaults
    }
    
    func property(_ propertyName: SettingsPropertyName) -> SettingsProperty {
        switch propertyName {
        case .profileName:
            let getAction: GetAction = { (property: SettingsBlockProperty) -> SettingsPropertyValue in
                return SettingsPropertyValue.string(value: "名字哦")
            }
            let setAction: SetAction = { (property: SettingsBlockProperty, value: SettingsPropertyValue) throws -> () in
                switch value {
                case .string(let stringValue):
                    DLog("\(stringValue)")
                default:
                    fatalError()
                }
            }
            return SettingsBlockProperty.init(propertyName: propertyName, getAction: getAction, setAction: setAction)
        default:
            if let userDefaultsKey = type(of: self).userDefaultsPropertiesToKeys[propertyName] {
                return SettingsUserDefaultsProperty(propertyName: propertyName, userDefaultsKey: userDefaultsKey, userDefaults: self.userDetaults)
            }
        }
        fatalError("Cannot create SettingsProperty for \(propertyName)")
    }
}
