//
//  EasingAnimation.swift
//  SSExteionComponents
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

@objc(SSEasingAnimation)
public class EasingAnimation: CAKeyframeAnimation {
    @objc var easing: EasingFunction = .linear {
        didSet {
            timingFunction = easing.timingFunction
        }
    }
    
    @objc public var fromValue: Any? = nil {
        didSet {
            updateValues()
        }
    }
    
    @objc public var toValue: Any? = nil {
        didSet {
            updateValues()
        }
    }
    
    func updateValues() -> Void {
        guard let fromValue = fromValue, let toValue = toValue else {
            values = []
            return
        }
        values = [fromValue, toValue]
    }
}
