//
//  ProtoNetViewController.swift
//  playground
//
//  Created by tree on 2019/2/26.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit

class ProtoNetViewController: SYViewController {
    var onMethod = Delegate<String, Void>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onMethod.delegate(on: self) { (self, inp) -> Void in
            Log.print("\(self)\(inp)")
        }
        self.onMethod.call("12")
        let request = PRUserRequest.init(name: "jiazifa")
        PRSession().send(request) { (user) in
            if let u = user {
                print("\(u)")
            }
        }
    }
}

class Delegate<Input, Output> {
    init() {}
    
    private var block:((Input) -> Output?)?
    
    func delegate<T: AnyObject>(on target: T, block:((T, Input) -> Output)?) {
        self.block = { [weak target] input in
            guard let target = target else { return nil }
            return block?(target, input)
        }
    }
    
    func call(_ input: Input) -> Output? {
        return block?(input)
    }
}
