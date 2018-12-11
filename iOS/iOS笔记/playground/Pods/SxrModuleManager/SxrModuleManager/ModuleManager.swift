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
open class ModuleManager: NSObject, HookModuleProtocol {
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
    
    public static let `shared` = ModuleManager()
    
    override init() {}
    
    
    @discardableResult
    public func register(_ module: HookModuleProtocol) -> Bool {
        let clzName = NSStringFromClass(type(of: module))
        return register(module, identifier: clzName)
    }
    
    public func register(_ module: HookModuleProtocol, identifier: String) -> Bool {
        self.moduleMap.updateValue(module, forKey: identifier)
        return true
    }
    
    public func removeAll() {
        self.moduleMap.removeAll()
        self.errorMap.removeAll()
    }
    
    public func remove(_ module: HookModuleProtocol) -> Void {
        let clzName = NSStringFromClass(type(of: module)) as String
        self.moduleMap.removeValue(forKey: clzName)
        self.errorMap.removeValue(forKey: clzName)
    }
    
    func removeModule(forKey identifier: String) -> Void {
        self.moduleMap.removeValue(forKey: identifier)
        self.errorMap.removeValue(forKey: identifier)
    }
    /// create a instance by className
    ///
    /// - Parameter hookModuleName: the name of hook
    /// - Returns: the instance, maybe nil
    @discardableResult
    public func patchModule(hookModuleName: String) -> Any? {
        if let o = self.moduleMap[hookModuleName] { return o }
        var m = hookModuleName
        if m.contains(".") == false { m = schemeName + "." + m }
        guard let classType = NSClassFromString(m) else { return nil }
        var target: Any?
        
        if let ObjectType = classType as? NSObject.Type {
            // 最后都没有找到，使用AnyObject方式初始化
            target = ObjectType.init()
        }
        return target
    }
}

extension ModuleManager {
    //MARK:-
    //MARK:delegate
    @discardableResult
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(application, didFinishLaunchingWithOptions: launchOptions)
                result = result || r ?? false
            }
        }
        return result
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationWillResignActive?(application)
            }
        }
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationWillTerminate?(application)
            }
        }
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationDidEnterBackground?(application)
            }
        }
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.applicationWillEnterForeground?(application)
            }
        }
    }
    
    @available(iOS 9.0, *)
    @discardableResult
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(app, open: url, options: options)
                result = result || r ?? false
            }
        }
        return result
    }
    
    @discardableResult
    public func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        var result: Bool = false
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                let r = hookModule.application?(application, handleOpen: url)
                result = result || (r ?? false)
            }
        }
        return result
    }
    
    @discardableResult
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
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
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.application?(application, didReceiveRemoteNotification: userInfo)
            }
        }
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
            }
        }
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        for (_ , module) in self.moduleMap {
            if let hookModule = module as? HookModuleProtocol {
                hookModule.application?(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
            }
        }
    }
}

