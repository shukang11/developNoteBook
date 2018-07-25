//
//  SSButton.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation
import UIKit
/*
public extension UIButton {
    enum SSButtonEdgeInsetsStyles {
        case Top            //图片在上
        case Bottom         //图片在下
        case Left           //图片在左
        case Right          //图片在又
    }

    public func layoutButton(_ style: SSButtonEdgeInsetsStyles, _ space: CGFloat) {
        let imageWidth: CGFloat = (self.imageView?.frame.size.width)!
        let imageHeight: CGFloat = (self.imageView?.frame.size.height)!
        
        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0
        
        if (UIDevice.systemVersion() >= 8.0) {
            //由于iOS 8中detitleLabel的size为0 ，所以用下面的方法设置
            labelWidth = (self.titleLabel?.intrinsicContentSize.width)!
            labelHeight = (self.titleLabel?.intrinsicContentSize.height)!
        }else {
            labelWidth = (self.titleLabel?.frame.size.width)!
            labelHeight = (self.titleLabel?.frame.size.height)!
        }
        
        /// 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .Top:
            imageEdgeInsets = UIEdgeInsets.init(top: -labelHeight-space/2.0, left: 0.0, bottom: 0.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: 0.0, left: -imageWidth, bottom: -imageHeight-space/2.0, right: 0.0)
            break
        case .Bottom:
            imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: -labelHeight-space/2.0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: -imageHeight-space/2.0, left: -imageWidth, bottom: 0.0, right: 0.0)
            break
        case .Left:
            imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: -space/2.0, bottom: 0.0, right: space/2.0)
            labelEdgeInsets = UIEdgeInsets.init(top: 0.0, left: space/2.0, bottom: 0.0, right: -space/2.0)
            break
        case .Right:
            imageEdgeInsets = UIEdgeInsets.init(top: 0.0, left: labelWidth+space/2.0, bottom: 0.0, right: -labelWidth-space/2.0)
            labelEdgeInsets = UIEdgeInsets.init(top: 0.0, left: -imageWidth-space/2.0, bottom: 0.0, right: imageWidth+space/2.0)
            break
        }
        //赋值
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
*/
