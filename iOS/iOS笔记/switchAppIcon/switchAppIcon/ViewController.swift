//
//  ViewController.swift
//  switchAppIcon
//
//  Created by tree on 2018/6/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let btn: UIButton = {
        let o = UIButton.init()
        o.setTitle("更换icon", for: .normal)
        o.setTitleColor(UIColor.black, for: .normal)
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        self.btn.frame = CGRect.init(origin: self.view.center, size: CGSize.init(width: 100.0, height: 40.0))
        self.btn.addTarget(self, action: #selector(switchIcon), for: .touchUpInside)
        self.view.addSubview(self.btn)
    }

    @objc func switchIcon() -> Void {
        print("change")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

