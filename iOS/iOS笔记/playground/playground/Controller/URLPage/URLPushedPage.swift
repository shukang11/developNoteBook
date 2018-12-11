//
//  URLPushedPage.swift
//  playground
//
//  Created by tree on 2018/10/31.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

class URLPushedPage: SYViewController {
    
    @objc var privateV: String = "ori"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor()
        self.title = "\(self.title ?? "Pushed Page") \(privateV)"
    }
}
