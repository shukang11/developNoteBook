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
        
        if #available(iOS 11, *) {
            for view in subviews {
                for stackView in view.subviews {
                    if stackView is UIStackView {
                        stackView.superview?.layoutMargins = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
                    }
                }
            }
        }else {
            super.layoutSubviews()
        }
    }
    
}

