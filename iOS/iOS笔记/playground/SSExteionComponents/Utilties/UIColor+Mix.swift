//
//  UIColor+Mix.swift
//  SSExteionComponents
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit



public extension UIColor {
    private func mix(v0: CGFloat, v1: CGFloat, progress: Float) -> CGFloat {
        return CGFloat(Float(v0) * (1.0 - progress) + Float(v1) * progress)
    }
    
    /// mix another color
    public func mix(color: UIColor, amount: Float) -> UIColor {
        var r0: CGFloat = 0.0, g0: CGFloat = 0.0, b0: CGFloat = 0.0, a0: CGFloat = 1.0
        
        var r1: CGFloat = 0.0, g1: CGFloat = 0.0, b1: CGFloat = 0.0, a1: CGFloat = 1.0
        
        self.getRed(&r0, green: &g0, blue: &b0, alpha: &a0)
        color.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        let r = mix(v0: r0, v1: r1, progress: amount)
        let g = mix(v0: g0, v1: g1, progress: amount)
        let b = mix(v0: b0, v1: b1, progress: amount)
        let a = mix(v0: a0, v1: a1, progress: amount)
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public func removeAlpha(byBlending color: UIColor) -> UIColor {
        var r0: CGFloat = 0.0, g0: CGFloat = 0.0, b0: CGFloat = 0.0, a0: CGFloat = 1.0
        var r1: CGFloat = 0.0, g1: CGFloat = 0.0, b1: CGFloat = 0.0, a1: CGFloat = 1.0
        
        self.getRed(&r0, green: &g0, blue: &b0, alpha: &a0)
        color.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        
        let r = mix(v0: r0, v1: r1, progress: Float(a0))
        let g = mix(v0: g0, v1: g1, progress: Float(a0))
        let b = mix(v0: b0, v1: b1, progress: Float(a0))
        let a: CGFloat = 1.0
        return UIColor.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public static func color(fromRGBA string: String) -> UIColor? {
        let scanner: Scanner = Scanner.init(string: string)
        var r: Float = 0.0
        var g: Float = 0.0
        var b: Float = 0.0
        var a: Float = 1.0
        scanner.scanFloat(&r)
        scanner.scanFloat(&g)
        scanner.scanFloat(&b)
        scanner.scanFloat(&a)
        if scanner.isAtEnd {
            return UIColor.init(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
        }
        return nil
    }
}
