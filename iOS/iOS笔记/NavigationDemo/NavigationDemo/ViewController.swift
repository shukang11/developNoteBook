//
//  ViewController.swift
//  NavigationDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var rightItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "导航控件"
        
        let rightButton = UIBarButtonItem.init(customView: {
            let o = UIButton.init()
            o.frame = CGRect.init(x: 20.0, y: 0.0, width: 44.0, height: 44.0)
            o.setTitle("右", for: .normal)
            o.setTitleColor(UIColor.black, for: .normal)
            o.addTarget(self, action: #selector(ViewController.move(_:)), for: .touchUpInside)
            return o
        }())
        self.rightItem = rightButton
        let second = UIBarButtonItem.init(customView: {
            let o = UIButton.init()
            o.setTitle("二", for: .normal)
            o.setTitleColor(UIColor.black, for: .normal)
            return o
        }())
        let fixed = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixed.width = -10;
        self.navigationItem.rightBarButtonItems = [rightButton, fixed, second]
        
        
        let leftButton: UIButton = {
            let o = UIButton.init()
            o.setTitle("左边的", for: .normal)
            o.setTitleColor(UIColor.green, for: .normal)
            return o
        }()
        let leftItem: UIBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func move(_ sender: UIButton) {
        sender.contentEdgeInsets = UIEdgeInsets.init(top: 0.0, left: sender.contentEdgeInsets.left + 10.0, bottom: 0.0, right: 0.0)
        
    }
}

