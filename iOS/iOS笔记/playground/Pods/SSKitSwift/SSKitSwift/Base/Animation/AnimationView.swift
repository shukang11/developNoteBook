//
//  AnimationView.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/30.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit

private let key_position = "position"
private let key_bounds = "bounds"
private let key_transform = "transform"
private let key_positionX = "position.x"
private let key_positionY = "position.y"

public extension UIView {
    
    /// 晃动view的动画
    ///
    /// - parameter offsetX: 晃动的X轴幅度
    /// - parameter offsetY: 晃动的Y轴幅度
    public func shake(_ offsetX:CGFloat, offsetY:CGFloat,duration:CFTimeInterval? = 0.06, repeatCount:CGFloat? = 3) {
        let viewLayer = self.layer
        let position = viewLayer.position
        let xPosition = CGPoint(x: position.x+offsetX, y: position.y+offsetY)
        let yPosition = CGPoint(x: position.x-offsetX, y: position.y-offsetY)
        let animation = CABasicAnimation(keyPath: key_position)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        animation.fromValue = NSValue.init(cgPoint: xPosition)
        animation.toValue = NSValue.init(cgPoint: yPosition)
        animation.autoreverses = true
        animation.duration = duration!
        animation.repeatCount = Float(repeatCount!)
        viewLayer.add(animation, forKey: nil)
    }
    
    /// 缩放动画
    ///
    /// - parameter by:       缩放系数
    /// - parameter duration: 时间
    public func scale(_ by:CGFloat, duration:CFTimeInterval? = 0.1) {
        self.layer.bounds = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width*1.1, height: self.frame.size.height*1.1)
        let animation = CABasicAnimation(keyPath: key_bounds)
        animation.duration = duration!
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.toValue = NSValue.init(cgRect: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width*by, height: self.frame.size.height*by))
        self.layer.add(animation, forKey: nil)
    }
    
    /// 在平面内进行旋转
    ///
    /// - parameter rotate:   旋转的角度
    /// - parameter duration: 动画时间，默认为2秒
    public func rotate(_ rotate:CGFloat, duration:CFTimeInterval? = 2.0) {
        let animation = CABasicAnimation(keyPath: key_transform)
        animation.duration = duration!
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.toValue = NSValue.init(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi)*rotate, 0.0, 0.0, 1.0))
        self.layer.add(animation, forKey: nil)
    }
    
    /// 弹簧效果
    @available(iOS 9.0, *)
    public func springAnimation() {
        let spring = CASpringAnimation(keyPath: "position.x")
        spring.damping = 5
        spring.stiffness = 100
        spring.mass = 1
        spring.initialVelocity = 0
        spring.fromValue = self.layer.position.x
        spring.toValue = self.layer.position.x + 50
        spring.duration = spring.settlingDuration;
        self.layer.add(spring, forKey: spring.keyPath);
    }
}
