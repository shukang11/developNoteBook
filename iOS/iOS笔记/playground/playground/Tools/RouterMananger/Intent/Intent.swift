//
//  Intent.swift
//  playground
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

public class Intent {
    
    public var url: URL?
    
    public var receiveClass: URLReceivable.Type?
    
    // 默认是push
    public var display: IntentDisplayType = .push
    
    public private(set) var extras = [String: Any]()
    
    public init(clazz: URLReceivable.Type) {
        self.receiveClass = clazz
    }
    
    public init(url: URL) {
        self.url = url
    }
    
    public convenience init(pathIdentifier: String) {
        self.init(url: URL.init(string: pathIdentifier)!)
    }
    
    public func updateExtra(_ name: String, value: Any) -> Void {
        self.extras.updateValue(value, forKey: name)
    }
    
    public func updateExtras(_ datas: [String: Any]) -> Void {
        for (k, v) in datas {
            self.updateExtra(k, value: v)
        }
    }
}
