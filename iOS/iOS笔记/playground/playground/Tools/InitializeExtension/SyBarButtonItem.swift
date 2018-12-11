//
//  SyBarButtonItem.swift
//  SyncTool
//
//  Created by tree on 2018/3/25.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class func barButtonItem(title: String, titleColor: UIColor, target: Any?, selector: Selector?) -> UIBarButtonItem {
        let button:UIButton = UIButton.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(titleColor, for: .normal)
        if let t = target, let se = selector {
            button.addTarget(t, action: se, for: .touchUpInside)
        }
        let item: UIBarButtonItem = UIBarButtonItem.init(customView: button)
        return item
    }
}
