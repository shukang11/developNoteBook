//
//  SSNavigationBar.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/11/17.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
var key: String = "coverView"

public extension UINavigationBar {
    /// 定义的一个计算属性，如果可以我更希望直接顶一个存储属性。它用来返回和设置我们需要加到
    /// UINavigationBar上的View
    public var coverView: UIView? {
        get {
            //这句的意思大概可以理解为利用key在self中取出对应的对象,如果没有key对应的对象就返回nil
            return objc_getAssociatedObject(self, &key) as? UIView
        }
        
        set {
            //与上面对应是重新设置这个对象，最后一个参数如果学过oc的话很好理解，就是代表这个newValue的属性
            //OBJC_ASSOCIATION_RETAIN_NONATOMIC意味着:strong,nonatomic
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 设置导航条的背景颜色可变
    ///
    /// - parameter color: 颜色参数，可以包含透明度等
    public func setGraduatedBackgroundColor(color: UIColor) {
        if self.coverView != nil {
            self.coverView!.backgroundColor = color
        }else {
            self.setBackgroundImage(UIImage(), for: .default)
            self.shadowImage = UIImage()
            let view = UIView(frame: CGRect(x: 0.0, y: -20.0, width: UIScreen.main.bounds.size.width, height: self.bounds.height+20.0))
            view.isUserInteractionEnabled = false
            view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.insertSubview(view, at: 0)
            
            view.backgroundColor = color
            self.coverView = view
        }
    }
    
    /// 清除导航栏的背景颜色
    public func setBackgroundcolorClean() {
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
