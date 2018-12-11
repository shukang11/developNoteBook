//
//  SettingsProperty.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

enum SettingsPropertyValue: Equatable {
    case bool(value: Bool)
    case number(value: NSNumber)
    case string(value: String)
    case none
    
    init(_ bool: Bool) {
        self = .number(value: .init(value: bool))
    }
    
    init(_ uint: UInt) {
        self = .number(value: .init(value: uint))
    }
    
    init(_ int: Int) {
        self = .number(value: NSNumber(value: int))
    }
    
    init(_ int: Int16) {
        self = .number(value: NSNumber(value: int))
    }
    
    init(_ int: UInt32) {
        self = .number(value: NSNumber(value: int))
    }
    
    static func propertyValue(_ object: Any?) -> SettingsPropertyValue {
        switch object {
        case let number as NSNumber:
            return SettingsPropertyValue.number(value: number)
            
        case let stringValue as String:
            return SettingsPropertyValue.string(value: stringValue)
            
        default:
            return .none
        }
    }
    
    func value() -> Any? {
        switch self {
        case .number(let value):
            return value
        case .bool(let value):
            return value
        case .string(let value):
            return value
        case .none:
            return .none
        }
    }
}

protocol SettingsProperty {
    var propertyName: SettingsPropertyName { get }
    func value() -> SettingsPropertyValue
    func set(newValue: SettingsPropertyValue) throws
}

extension SettingsProperty {
    func rawValue() -> Any? {
        return self.value().value()
    }
}

func << (property: inout SettingsProperty, expr: @autoclosure () -> Any) throws {
    let value = expr()
    try property.set(newValue: SettingsPropertyValue.propertyValue(value))
}

func << (property: inout SettingsProperty, expr: @autoclosure () -> SettingsPropertyValue) throws {
    let value = expr()
    try property.set(newValue: value)
}

func << (value: inout Any?, property: SettingsProperty) {
    value = property.rawValue()
}

class SettingsUserDefaultsProperty: SettingsProperty {
    var propertyName: SettingsPropertyName
    
    let userDefaults: UserDefaults
    
    let userDefaultsKey: String
    
    init(propertyName: SettingsPropertyName, userDefaultsKey: String, userDefaults: UserDefaults) {
        self.propertyName = propertyName
        self.userDefaults = userDefaults
        self.userDefaultsKey = userDefaultsKey
    }
    
    func value() -> SettingsPropertyValue {
        switch self.userDefaults.object(forKey: self.userDefaultsKey) as AnyObject? {
        case let numberValue as NSNumber:
            return SettingsPropertyValue.propertyValue(numberValue.intValue)
        case let stringValue as String:
            return SettingsPropertyValue.propertyValue(stringValue)
        default:
        return .none
        }
    }
    
    func set(newValue: SettingsPropertyValue) throws {
        self.userDefaults.setValue(newValue.value(), forKey: self.userDefaultsKey)
        let name = Notification.Name.init(self.propertyName.changeNotificationName)
        NotificationCenter.default.post(name: name, object: self)
    }
}

typealias GetAction = (SettingsBlockProperty) -> SettingsPropertyValue
typealias SetAction = (SettingsBlockProperty, SettingsPropertyValue) throws -> ()

open class SettingsBlockProperty: SettingsProperty {
    var propertyName: SettingsPropertyName
    
    func value() -> SettingsPropertyValue {
        return self.getAction(self)
    }
    
    func set(newValue: SettingsPropertyValue) throws {
        try self.setAction(self, newValue)
        let name = Notification.Name.init(self.propertyName.changeNotificationName)
        NotificationCenter.default.post(name: name, object: self)
    }
    
    fileprivate let getAction: GetAction
    fileprivate let setAction: SetAction
    
    init(propertyName: SettingsPropertyName, getAction: @escaping GetAction, setAction: @escaping SetAction) {
        self.propertyName = propertyName
        self.getAction = getAction
        self.setAction = setAction
    }
}
