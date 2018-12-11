//
//  URLRouterManager.swift
//  playground
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

public class URLRouterManager {
    static public let shared = URLRouterManager()
    
    private let manager = RouterManager.shared
    
    private init() {}
    
    @discardableResult
    public func register(_ url: URL, handle: @escaping URLRoutesHandler) -> Bool {
        return manager.register(url, handler: handle)
    }
    
    public func unregister(_ url: URL) {
        return manager.unregisterHandler(url)
    }
    
    public func route(_ url: URL) {
        let (p, handler) = manager.searchHandler(url)
        if let h = handler {
            h(p)
        }
    }
    
    public func canRouter(_ url: URL) -> Bool {
        return manager.hasRegisterHandler(url)
    }
}
