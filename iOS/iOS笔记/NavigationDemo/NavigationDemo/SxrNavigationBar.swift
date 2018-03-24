//
//  SxrNavigationBar.swift
//  NavigationDemo
//
//  Created by tree on 2018/3/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    open override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11, *) {
            self.layoutMargins.left = 0.0
            self.layoutMargins.right = 0.0
            self.setBackgroundImage(UIImage.init(), for: .default)
        }else {
            
        }
    }
}
