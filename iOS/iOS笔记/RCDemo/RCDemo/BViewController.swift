//
//  BViewController.swift
//  RCDemo
//
//  Created by tree on 2018/3/13.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
class BViewController: UIViewController {
    //MARK:property
    var block: ((_ content: String) -> Void)?
    var hodler: ResD = {
        let o = ResD.init()
        return o
    }()
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
//        unowned let wS = self
//        self.block = {(content: String) in
//            self.title = content
//        }
        super.viewDidLoad()
        self.createUI()
    }
    //MARK:delegate&dataSource
    
    //MARK:customMethod
    private func createUI() {
        hodler.relay(withDuration: 1, animations: {
            
        }) { (comp) in
            self.title = "改版"
            self.log()
        }
        
//        var a: A? = A(name: "a")
//        let b: B? = B(name: "b")
//        a?.subB = b
//        b?.subA = a
    }
    func log() -> Void {
        print("\(self.title)")
    }
}

class ResD: NSObject {
    var com: ((Bool) -> Void)?
    func relay(withDuration duration: TimeInterval, animations: @escaping ()-> Void, completion: ((Bool) -> Void)?=nil) {
        
        self.com = completion
        completion?(true)
        self.com = nil
    }
    
    override init() {}
}
