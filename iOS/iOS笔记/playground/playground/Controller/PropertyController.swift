//
//  PropertyController.swift
//  playground
//
//  Created by tree on 2018/5/7.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

/// 对象和属性
class PropertyController: SYViewController {
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
        
    }
}


class People: NSObject {
    var name = ""
    
}
