//
//  ModuleManager.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/28.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit


/**
 模块管理工具
 
 提供了对AppDelegate的代理方法的实现，并且按照模块划分下去
 也提供了通过类名获得实例的方法
 */
class ModuleManager: NSObject, HookModuleProtocol {
    //MARK:-
    //MARK:properties
    var moduleMap: Dictionary = Dictionary<String, Any>()
    
    var errorMap: Dictionary = Dictionary<String, String>()
    
    var schemeName: String = {
        if let info = Bundle.main.infoDictionary {
            if let o = info["CFBundleName"] as? String { return o }
            return ""
        }
        return ""
    }()
    
    static let `shared` = ModuleManager()
    
    override init() {}
    
    /// register by a plist file
    ///
    /// - Parameter contentPath: path of plist
    public func register(contentPath: String) -> Void {
        guard FileManager.default.fileExists(atPath: contentPath) else {
            print("file do not exists at\(contentPath)")
            return
        }
        guard let sourceArray: Array<String> = NSArray.init(contentsOfFile: contentPath) as? Array else { return }
        for mn: String in sourceArray {
            var m = mn
            // 如果有.说明包含了scheme名
            if m.contains(".") == false { m = schemeName + "." + m }
            register(clazzName: m)
        }
    }
    
    @discardableResult
    public func register(_ module: Any?=nil, clazzName: String) -> Bool {
        if let module = module {
            self.moduleMap.updateValue(module, forKey: clazzName)
        }
        if let obj = patchModule(hookModuleName: clazzName) {
            self.moduleMap.updateValue(obj, forKey: clazzName)
            return true
        }else {
            self.errorMap.updateValue("no instance of \(clazzName)", forKey: clazzName)
            return false
        }
    }
    
    /// create a instance by className
    ///
    /// - Parameter hookModuleName: the name of hook
    /// - Returns: the instance, maybe nil
    public func patchModule(hookModuleName: String) -> Any? {
        if let o = self.moduleMap[hookModuleName] { return o }
        guard let classType = NSClassFromString(hookModuleName) else { return nil }
        var target: Any?
        if let singleton = classType as? ModuleSingleton.Type {
            // 如果是单例，使用设计的单例模块初始化
            target = singleton.singleton
        }else if let ObjectType = classType as? NSObject.Type {
            target = ObjectType.init()
        }
        // 最后都没有找到，使用AnyObject方式初始化
        return target
    }
    
    //MARK:-
    //MARK:delegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(application, didFinishLaunchingWithOptions: launchOptions)
                result = result || r ?? false
            }
        }
        return result
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationWillResignActive?(application)
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationWillTerminate?(application)
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationDidEnterBackground?(application)
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationWillEnterForeground?(application)
            }
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(app, open: url, options: options)
                result = result || r ?? false
            }
        }
        return result
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(application, handleOpen: url)
                result = result || (r ?? false)
            }
        }
        return result
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
                result = result || (r ?? false)
            }
        }
        return result
    }
    
    //MARK:-
    //MARK:Push
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.application?(application, didReceiveRemoteNotification: userInfo)
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
            }
        }
    }
}

