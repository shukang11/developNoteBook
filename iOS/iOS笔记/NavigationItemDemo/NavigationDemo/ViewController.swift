//
//  ViewController.swift
//  NavigationDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var leftButton: UIButton = {
        let btn = UIButton.init()
        btn.bounds = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 40.0, height: 44.0))
        btn.setTitle("返回", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    private var rightButton: UIButton = {
        let btn = UIButton.init()
        btn.bounds = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 40.0, height: 44.0))
        btn.setTitle("完成", for: .normal)
        btn.backgroundColor = UIColor.red
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "导航控件"
        
        let leftItem: UIBarButtonItem = UIBarButtonItem.init(customView: self.leftButton)
        let rightItem: UIBarButtonItem = UIBarButtonItem.init(customView: self.rightButton)
        var fixedSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = -20
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItems = [fixedSpace, rightItem]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func log() {
    }
    @objc func move(_ sender: UIButton) {
        sender.contentEdgeInsets = UIEdgeInsets.init(top: 0.0, left: sender.contentEdgeInsets.left + 10.0, bottom: 0.0, right: 0.0)
        
    }
}

