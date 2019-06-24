//
//  ViewController.swift
//  MacroDemo
//
//  Created by tree on 2019/5/29.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit
import Hello
import HC

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mo = HelloModule.init()
        mo.work()
        let b = BBModel.init()
        b.content = "hhassdf"
        print("\(b)")
        
        let account = Account.init(name: "jack", age: 100)
        print("\(account)")
        
        hcc_print()
    }
}

