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
    var content: String = "aaa"
    var block: ((_ content: String) -> Void)?
    
    var mod = Singleton.shared
    
    var hodler: ResD? = {
        let o = ResD.init()
        return o
    }()
    //MARK:systemCycle
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
//        unowned let wS = self
        self.block = {[weak self] (content: String) in
            self?.title = content
        }
        UIView.animate(withDuration: 2.0, animations: {}) { (fin) in
            self.title = "延迟设置了"
        }
        super.viewDidLoad()
        self.createUI()
    }
    //MARK:delegate&dataSource
    deinit {
        print("\(self)被释放了")
    }
    //MARK:customMethod
    private func createUI() {
        hodler?.relay(withDuration: 1, animations: {
            
        }) { (comp) in
//            self.title = "改版"
            self.log()
        }
        
    }
    func log() -> Void {
        print("\(self.title)")
    }
}

class ResD: NSObject {
    var posts:[String] = []
    var com: ((Bool) -> Void)?
    func relay(withDuration duration: TimeInterval, animations: @escaping ()-> Void, completion: ((Bool) -> Void)?=nil) {
        
        self.com = completion
        completion?(true)
        self.com = nil
    }
    deinit {
        print("ResD 释放了")
    }
    override init() {
        for _ in 0...10000000 {
            posts.append("crashei ")
        }
    }
}

class Singleton {
    static let `shared` = Singleton()
    
    var name = "hi"
    
    private init() {
        
    }
}
