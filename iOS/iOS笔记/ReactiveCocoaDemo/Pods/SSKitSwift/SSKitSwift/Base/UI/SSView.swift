//
//  SSView.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/16.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    public var ss_x : CGFloat {
        get {
            return frame.origin.x
        }
        set(newX) {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newX
            frame = tempFrame
        }
    }
    public var ss_left: CGFloat {
        get { return ss_x }
        set(newLeft) { ss_x = newLeft }
    }
    
    public var ss_y : CGFloat {
        get {
            return frame.origin.y
        }
        set(newY) {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newY
            frame = tempFrame
        }
    }
    
    public var ss_top: CGFloat {
        get { return ss_y }
        set(newTop) { ss_y = newTop }
    }
    public var ss_right : CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(newRight) {
            var tempFrame : CGRect = frame
            tempFrame.origin.x = newRight - frame.size.width;
            frame = tempFrame
        }
    }
    public var ss_bottom : CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        
        set(newBottom) {
            var tempFrame : CGRect = frame
            tempFrame.origin.y = newBottom - frame.size.height
            frame = tempFrame
        }
    }
    
    public var ss_width : CGFloat {
        get {
            return frame.size.width
        }
        set(newWidth) {
            var tempFrame : CGRect = frame
            tempFrame.size.width = newWidth
            frame = tempFrame
        }
    }
    public func ss_WidthEqualTo(_ view: UIView) {
        self.ss_width = view.ss_width
    }
    public var ss_height : CGFloat {
        get {
            return frame.size.height
        }
        set(newHeight) {
            var tempFrame : CGRect = frame
            tempFrame.size.height = newHeight
            frame = tempFrame
        }
    }
    public func ss_HeightEqualTo(_ view: UIView) {
        self.ss_height = view.ss_height
    }
    public var ss_centerX : CGFloat {
        get {
            return self.center.x
        }
        set(newCenterX) {
            self.center = CGPoint.init(x: newCenterX, y: self.center.y)
        }
    }
    public func ss_CenterXEqualTo(_ view: UIView) {
        self.ss_centerX = view.ss_centerX
    }
    
    public var ss_centerY : CGFloat {
        get {
            return self.center.y
        }
        set(newCenterY) {
            self.center = CGPoint.init(x: self.center.x, y: newCenterY)
        }
    }
    public func ss_CenterYEqualTo(_ view: UIView) {
        self.ss_centerY = view.ss_centerY
    }
    public func ss_CenterEqualTo(_ view: UIView) {
        self.center = view.center
    }
    
    public var ss_size : CGSize {
        get {
            return self.frame.size
        }
        set(newSize) {
            var tempFrame : CGRect = frame
            tempFrame.size = newSize
            frame = tempFrame
        }
    }
    public func ss_SizeEqualTo(_ view: UIView) {
        self.ss_size =  view.ss_size
    }
    public var ss_origin : CGPoint {
        get {
            return frame.origin
        }
        set(newOrigin) {
            var tempFrame : CGRect = frame
            tempFrame.origin = newOrigin
            frame = tempFrame
        }
    }
    public func ss_FillWidth() {
        if let sv = superview {
            self.ss_width = sv.ss_width
            self.ss_x = 0.0
        }
    }
    public func ss_FillHeight() {
        if let sv = superview {
            self.ss_height = sv.ss_height
            self.ss_y = 0.0
        }
    }
    public func ss_Fill() {
        if let sv = superview {
            self.frame = CGRect.init(origin: CGPoint.zero, size: sv.ss_size)
        }
    }
    
    public var topSuperView: UIView? {
        var top: UIView? = self
        while (top?.superview != nil) {
            top = top?.superview
        }
        return top
        
    }
    // Layout
    
    public func removeAllObjects() {
        while self.subviews.count > 0 {
            self.subviews.last?.removeFromSuperview()
        }
    }
    
    public func backgroundColor(_ image: UIImage) {
        self.backgroundColor = UIColor.init(patternImage: image)
    }
    public func cleanSubColors() {
        for view in self.subviews {
            view.backgroundColor = UIColor.clear
        }
        self.backgroundColor = UIColor.clear
    }
    
    ///调试模式下，将所有视图和其子视图描边显示
    public func debugModeColor() {
        #if DEBUG
        self.backgroundColor = UIColor.randomColor()
        for view in self.subviews {
            if (view.subviews.count > 0) {view.debugModeColor()}
            view.backgroundColor = UIColor.randomColor()
            view.layer.borderColor = UIColor.white.cgColor
            view.layer.borderWidth = 0.5
        }
        #endif
    }
    
    //MARK:animate动画
    public func shake(_ size: CGSize) {
        let layer:CALayer = self.layer;
        let position:CGPoint = layer.position;
        let xPosition:CGPoint = CGPoint.init(x: position.x+size.width, y: position.y+size.height)
        let yPosition:CGPoint = CGPoint.init(x: position.x-size.width, y: position.y-size.height)
        let animate:CABasicAnimation = CABasicAnimation.init(keyPath: "position")
        animate.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionDefault)
        animate.fromValue = NSValue.init(cgPoint: xPosition)
        animate.toValue = NSValue.init(cgPoint: yPosition)
        animate.autoreverses = true
        animate.duration = 0.06
        animate.repeatCount = 1
        layer.add(animate, forKey: nil)
    }
}
