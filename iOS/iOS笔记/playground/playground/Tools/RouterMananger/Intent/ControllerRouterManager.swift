//
//  ControllerRouterManager.swift
//  playground
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

public class ControllerRouterManager {
    public static let shared = ControllerRouterManager()
    
    private var manager = RouterManager.shared
    
    private init() { }
    
    @discardableResult public func register(_ url: URL, clazz: URLReceivable.Type) -> Bool {
        return manager.register(url, clazz: clazz)
    }
    
    @discardableResult public func register(filePath: String) -> Bool {
        guard let registers = NSDictionary.init(contentsOfFile: filePath) else {
            return false
        }
        for register in registers {
            guard let urlString = register.key as? String,
                let clazzName = register.value as? String else {
                return false
            }
            if let clazz = NSClassFromString(clazzName) as? URLReceivable.Type,
                let url = URL.init(string: urlString) {
                let r = self.register(url, clazz: clazz)
                if r == false { return r }
            }
            return false
        }
        return true
    }
    
    public func unregister(_ url: URL) {
        manager.unregisterClazz(url)
    }
    
    public func startController(from source: UIViewController, with intent: Intent) -> Void {
        var params = [String: Any]()
        var controllerClazz: URLReceivable.Type?
        
        if let url = intent.url {
            (params, controllerClazz) = manager.searchClazz(url)
        }
        
        if let clazz = intent.receiveClass { controllerClazz = clazz }
        
        guard let clazz: UIViewController.Type = controllerClazz as? UIViewController.Type else { return }
        
        for (k, v) in params { intent.updateExtra(k, value: v) }
        let destination = clazz.init()
        (destination as URLReceivable).setUp?(extras: intent.extras)
        let displayer: ControllerDisplaydelegate = intent.display.fetchDisplayer()
        displayer.displayViewController(from: source, to: destination)
    }
}

extension UIViewController: URLReceivable {
    
    public static func pathIdentifier() -> URL? {
        return URL.init(string: "/page/\(self)")
    }
    
    public func setUp(extras: [String : Any]?) {
        guard let e = extras else { return }
        for (k, v) in e {
            self.setValue(v, forKey: k)
        }
    }
    
    open override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("\(key) -- \(value ?? "")")
    }
}

extension UIViewController {
    func startController(destination controllerName: String, extras: [String: Any]) {
        let clsName = controllerName.getClassString()
        guard let des = NSClassFromString(clsName) as? URLReceivable.Type else { return}
        let intent = Intent.init(clazz: des)
        intent.updateExtras(extras)
        ControllerRouterManager.shared.startController(from: self, with: intent)
    }
}
