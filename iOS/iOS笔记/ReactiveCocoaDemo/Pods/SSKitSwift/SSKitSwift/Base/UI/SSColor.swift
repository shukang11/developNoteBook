//
//  SSColor.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/10.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
public extension UIColor {
    public class func randomColor() -> UIColor {
        let R = arc4random() % 256
        let B = arc4random() % 256
        let G = arc4random() % 256
        return UIColor.init(red: CGFloat(R)/255.0, green: CGFloat(G)/255.0, blue: CGFloat(B)/255.0, alpha: 1.0)
    }
    
    public class func color(_ hex: String) -> UIColor {
        return self.color(hex, alpha: 1.0)
    }
    
    public class func color(_ hex: String, alpha: CGFloat) -> UIColor {
        var cleanString = hex.replacingOccurrences(of: "#", with: "")
        if cleanString.count == 3 {
            cleanString = (cleanString as NSString).substring(with: NSMakeRange(0, 1)) + (cleanString as NSString).substring(with: NSMakeRange(0, 1)) + (cleanString as NSString).substring(with: NSMakeRange(1, 1)) + (cleanString as NSString).substring(with: NSMakeRange(1, 1)) + (cleanString as NSString).substring(with: NSMakeRange(2, 1)) + (cleanString as NSString).substring(with: NSMakeRange(2, 1))
        }
        
        if cleanString.count == 6 {
            cleanString = cleanString.appending("ff")
        }
        var baseValue: UInt32 = 0
        Scanner.init(string: cleanString).scanHexInt32(&baseValue)
        let red = CGFloat(((baseValue >> 24) & 0xFF))/255.0
        let green = CGFloat(((baseValue >> 16) & 0xFF))/255.0
        let blue = CGFloat(((baseValue >> 8) & 0xFF))/255.0
        return UIColor.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
