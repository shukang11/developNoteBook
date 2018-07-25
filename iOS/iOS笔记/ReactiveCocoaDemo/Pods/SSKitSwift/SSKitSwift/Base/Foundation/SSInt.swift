//
//  SSInt.swift
//  Pods
//
//  Created by tree on 2017/7/16.
//
//

import Foundation

public extension Int {
    
    /// 循环执行次数
    ///
    /// - Parameter function: 循环的回调方法
    func times (function: ()->(Void)) {
        for _ in 0...self {
            function()
        }
        return
    }
    
    
    /// 判断是否是偶数
    ///
    /// - Returns: 是偶数返回true，否则返回false
    func isEven() -> Bool {
        return (self % 2) == 0
    }
    
    /// 判断是否是奇数
    ///
    /// - Returns: 是奇数返回true 否则返回false
    func isOdd() -> Bool {
        return !isEven()
    }
    
    
    /// 判断是否在范围中
    ///
    /// - Parameters:
    ///   - range: 判断的范围
    ///   - strict: 是否包含边界
    /// - Returns: 在范围内返回true
    func isIn (range: Range<Int>, strict: Bool = false) -> Bool {
        if strict {
            return range.lowerBound <= self && self < range.upperBound - 1
        }
        
        return range.lowerBound <= self && self <= range.upperBound - 1
    }
    
    
    /// 获得这个数的绝对值
    ///
    /// - Returns: 绝对值
    func abs () -> Int {
        return Swift.abs(self)
    }
    
    
    /// 获得这个数的最大公约数(Greatest common divisor)
    ///
    /// - Parameter n: n
    /// - Returns: 最大公约数
    func gcd (_ n: Int) -> Int {
        return n == 0 ? self : n.gcd(self % n)
    }
    
    /// 获得这个数的最小公倍数(Least common multiple)
    ///
    /// - Parameter n: n
    /// - Returns: 最小公倍数
    func lcm (_ n: Int) -> Int {
        return (self * n).abs() / gcd(n)
    }
    
    /// 获得这个数的阶乘
    ///
    /// - Returns: 阶乘(factorial)
    func factorial () -> Int {
        return self == 0 ? 1 : self * (self - 1).factorial()
    }
    
    func random (min: Int = 0, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
    
}

// MARK: - 时间相关的便利拓展
public extension Int {
    var years: TimeInterval {
        return 365 * self.days
    }
    
    var year: TimeInterval {
        return self.years
    }
    
    var days: TimeInterval {
        return 24 * self.hours
    }
    
    var day: TimeInterval {
        return self.days
    }
    
    var hours: TimeInterval {
        return 60 * self.minutes
    }
    
    var hour: TimeInterval {
        return self.hours
    }
    
    var minutes: TimeInterval {
        return 60 * self.seconds
    }
    
    var seconds: TimeInterval {
        return self.second
    }
    
    var second: TimeInterval {
        return TimeInterval(self)
    }
}
