//
//  SSDouble.swift
//  Pods
//
//  Created by tree on 2017/7/16.
//
//

import Foundation

public extension Double {
    
    /// 绝对值
    ///
    /// - Returns: 绝对值
    func abs () -> Double {
        return Foundation.fabs(self)
    }
    
    
    /// 开平方根
    ///
    /// - Returns: 平方根
    func sqrt () -> Double {
        return Foundation.sqrt(self)
    }
    
    
    /// 取得整数部分
    ///
    /// - Returns: 整数部分
    func floor () -> Double {
        return Foundation.floor(self)
    }
    
    
    /// 进一法取整
    ///
    /// - Returns: 整数
    func ceil () -> Double {
        return Foundation.ceil(self)
    }
    
    
    /// 取得最近的整数部分
    ///
    /// - Returns: 整数
    func round () -> Double {
        return Foundation.round(self)
    }
    
    
    /// 逼近法获得值
    ///
    /// - Parameters:
    ///   - min: 最小值
    ///   - max: 最大值
    /// - Returns: clamp
    func clamp (min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    
    
    /// 随机数
    ///
    /// - Parameters:
    ///   - min: 最小范围
    ///   - max: 最大范围
    /// - Returns: 随机数
    static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min;
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min;
    }
}
