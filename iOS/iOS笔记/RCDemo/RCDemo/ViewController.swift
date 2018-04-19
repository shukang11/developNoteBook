//
//  ViewController.swift
//  RCDemo
//
//  Created by tree on 2018/3/13.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit
import Foundation

func menoryPos(_ obj: Any?) -> String {
    return "\(Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque())"
}
class ViewController: UIViewController {
    
    var button: UIButton = {
        let o = UIButton.init()
        o.frame = CGRect.init(x: 0.0, y: 100.0, width: 100.0, height: 100.0)
        o.setTitle("跳转", for: .normal)
        o.setTitleColor(UIColor.black, for: .normal)
        o.backgroundColor = UIColor.yellow
        o.addTarget(self, action: #selector(jump), for: .touchUpInside)
        return o
    }()
    
    @objc func jump() {
        self.navigationController?.pushViewController(BViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.button)
        print("\(menoryPos(nil))")
        var a: A? = A(name: "a")
        let b: B? = B(name: "b")
        a?.subB = b
        b?.subA = a
        a = nil
        // 如果没有下面的代码，会造成循环引用的问题
        b?.subA = nil
        print("\(menoryPos(a))")
    }
}
/**
 open class func animate(withDuration duration: TimeInterval, delay: TimeInterval, options: UIViewAnimationOptions = [], animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil)
 */

