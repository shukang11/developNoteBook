//
//  SSFloat.swift
//  Pods
//
//  Created by tree on 2017/7/16.
//
//

import Foundation


public extension Float {
    
    /// 返回数值的绝对值
    ///
    /// - Returns: 绝对值
    func abs() -> Float {
        return fabsf(self)
    }
    
    /// 开平方根(squared root)
    ///
    /// - Returns: 平方根
    func sqrt() -> Float {
        return sqrtf(self)
    }
    
    /// 获得最大整数
    ///
    /// - Returns: 最大的整数
    func floor() -> Float {
        return floorf(self)
    }
    
    /// 进一法取整
    ///
    /// - Returns: 整数
    func ceil() -> Float {
        return ceilf(self)
    }
    
    /// 得到最近的整数
    ///
    /// - Returns: 最近的整数
    func round() -> Float {
        return roundf(self)
    }
    
    /// 获得范围内最靠近自己的值
    ///
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    /// - Returns: 被逼近的值
    func clamp(min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(self, max))
    }
    
    /// 获得一个随机数
    ///
    /// - Parameters:
    ///   - min: 最小范围
    ///   - max: 最大范围
    /// - Returns: 随机数
    static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min
        let rand = Float(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min
    }
}
