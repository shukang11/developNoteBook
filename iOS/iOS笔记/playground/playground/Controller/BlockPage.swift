//
//  BlockPage.swift
//  playground
//
//  Created by tree on 2018/5/9.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class BlockPage: SYViewController {
    //MARK:property
    
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()
        self.createUI()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        block1()
        block2()
    }
    
    func block1() {
        let b1 = { content in
            print(content)
        }
        b1("hi")
    }
    
    func block2() -> Void {
        // block的自动捕获
        var vari = "content"
        let b2: () -> () = {
            print("b2: \(vari)")
            vari = "in block"
        }
        vari = "content changed"
        b2()
        print("\(vari)")
    }
    
    func block3() -> Void {
        var value = "11"
        let b3: () -> () = {
            value = "33"
        }
        b3()
    }
}
