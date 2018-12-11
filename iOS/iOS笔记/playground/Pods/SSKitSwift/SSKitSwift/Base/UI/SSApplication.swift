//
//  SSApplication.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation
import UIKit

let CFBundleShortVersionString:String = "CFBundleShortVersionString"
let CFBundleVersion:String = "CFBundleVersion"
let CFBundleDisplayName:String = "CFBundleDisplayName"
let CFBundleIdentifier:String = "CFBundleIdentifier"

public extension UIApplication {
    public var infoDictionary: Dictionary<String, Any> {
        get {
            return Bundle.main.infoDictionary!
        }
    }
    //设备的名称
    public var deviceName: String {
        return UIDevice.current.name
    }
    
    /// 系统的名称 例如：xxx的iPhone
    public var systemName: String {
        return UIDevice.current.systemName
    }
    
    /// 系统名称 例如：iPhone OS
    public var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    
    /// 设备标识符
    public var deviceUUID: String {
        return (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    /// 设备的型号 例如：iPhone
    public var deveiceModel: String {
        return UIDevice.current.model
    }
    
    public var modelName: String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
    
    /// 获取app的版本号
    public var appVersion: String {
        return infoDictionary[CFBundleShortVersionString] as! String
    }
    
    /// 获取app的build版本号
    public var appBuildVersion: String {
        return infoDictionary[CFBundleVersion] as! String
    }
    
    /// 获得app名字
    public var appName: String {
        return infoDictionary[CFBundleDisplayName] as! String
    }
    
    /// 获得app的bundleID
    public var bundleIdentifier: String {
        return infoDictionary[CFBundleIdentifier] as! String
    }

}
