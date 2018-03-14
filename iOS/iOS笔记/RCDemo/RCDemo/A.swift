//
//  A.swift
//  RCDemo
//
//  Created by tree on 2018/3/13.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

class A: NSObject {
    var name: String
    var subB: B?
    convenience init(_ name: String) {
        self.init(name)
        self.name = name
    }
    init(name: String) {
        self.name = name
        super.init()
    }
    override var description: String {
        return "\(self.name)\(menoryPos(self))"
    }
}
