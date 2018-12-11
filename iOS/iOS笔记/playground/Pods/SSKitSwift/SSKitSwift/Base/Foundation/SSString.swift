//
//  SSString.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/9/16.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    
    public var length : Int { return self.count }
    
    
    /// 去除空格和换行之后的字符串
    public var trimString: String {
        let set: NSCharacterSet = NSCharacterSet.whitespacesAndNewlines as NSCharacterSet
        return self.trimmingCharacters(in: set as CharacterSet)
    }
    
    
    /// 将字符串拼接，适应于图片后面的@x
    ///
    /// - Parameter scale: 缩放的倍数
    /// - Returns: 返回拼接后的字符串
    public func stringByAppendingNameScale(_ scale:CGFloat) -> String {
        if (fabs(scale-1) <= 0 || self.length == 0 || self.hasSuffix("/")) {
            return self
        }
        return self.appending("\(scale)@x")
    }
    
    /// 右边填充字符至规定长度
    ///
    /// - Parameters:
    ///   - length: 规定的长度
    ///   - pad: 填充的字符
    /// - Returns: 返回的字符串
    public func aligenRight(totalLength length:Int, pad:String) ->String {
        let amountToPad = length-self.length
        if amountToPad < 1 {
            return self
        }
        var string : String = self
        for _ in 1...amountToPad {
            string = pad + string
        }
        return string
    }
    
    /// 左边填充字符至目标位数
    ///
    /// - Parameters:
    ///   - totalLength: 目标位数
    ///   - pad: 填充的字符串
    /// - Returns: 返回的字符串
    public func alignLeft(totalLength:Int, pad:String) ->String {
        let amountToPad = totalLength-self.length
        if amountToPad < 1 {
            return self
        }
        var string : String = self
        for _ in 1...amountToPad {
            string = string+pad
        }
        return string
    }
    
    
    /// 获得swift中类的全名
    ///
    /// - Returns: 返回类的全名
    public func getClassString() ->String{
        
        let appName:String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String
        let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String
        
        assert(appName == appDisplayName, "CFBundleName must equl to CFBundleDisplayName")
        let classStringName = "_TtC\(appName.length)\(appName)\(self.length)\(self)"
        return classStringName
        
    }
    
    /// 替换字符串中的某一段字符串
    ///
    /// - Parameters:
    ///   - replace: 目标字符串
    ///   - charString: 替换的字符串
    /// - Returns: 新的字符串
    public func replaceString(replace:String, by charString:String) ->String {
        if replace.isEmpty || charString.isEmpty { return self}
        var tempString = self
        tempString = tempString.replacingCharacters(in: range(of: replace)!, with: charString)
        return tempString
    }
    
    
    /// 获得设备的UUID
    ///
    /// - Returns: 返回设备的标识符
    public static func stringWithUUID() -> String {
        let uuid:CFUUID = CFUUIDCreate(nil)
        let string: CFString = CFUUIDCreateString(nil, uuid)
        let nsstring:NSString = string as NSString
        return String.init(nsstring)
    }
    
    //MARK: 尺寸相关
    /// 将字符串的占用大小计算出来并返回
    ///
    /// - Parameters:
    ///   - font: 字体大小，默认是12
    ///   - size: 限制宽高
    ///   - mode: 换行类型
    /// - Returns: 返回的字符串占用宽高
    public func getSize(togolFont font:UIFont?=UIFont.systemFont(ofSize: 12.0), togolSize size:CGSize, breakMode mode:NSLineBreakMode) -> CGSize {
        let string: NSString = self as NSString
        var result:CGSize = CGSize.zero
        if (string.responds(to: #selector(NSString.boundingRect(with:options:attributes:context:)))) {
            var attr:[NSAttributedString.Key: Any] = [.font : font!]
            if (mode != NSLineBreakMode.byWordWrapping) {
                let paragraphStyle = NSMutableParagraphStyle.init()
                paragraphStyle.lineBreakMode = mode
                attr[.paragraphStyle] = paragraphStyle
            }
            let rect: CGRect = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attr , context: nil)
            result = rect.size
        }else {
            result = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [.font: font!], context: nil).size
        }
        
        return result
    }
    
    
    /// 获得字符串的宽度
    ///
    /// - Parameter font: 字体字号
    /// - Returns: 占用宽度
    public func getWidth(togolFont font: UIFont) -> CGFloat {
        let size: CGSize = self.getSize(togolFont: font, togolSize: CGSize.init(width: CGFloat(HUGE), height: CGFloat(HUGE)), breakMode: .byWordWrapping)
        return size.width
    }
    
    /// 获得字体在规定宽度下占用的高度
    ///
    /// - Parameters:
    ///   - font: 字体字号
    ///   - width: 限制宽度
    /// - Returns: 占用的高度
    public func getHeight(togolFont font: UIFont, _ width:CGFloat) -> CGFloat {
        let size: CGSize = self.getSize(togolFont: font, togolSize: CGSize.init(width: width, height: CGFloat(HUGE)), breakMode: .byWordWrapping)
        return size.height
    }
    
    //MAR:转换相关
    func toDouble() -> Double {
        let scanner = Scanner.init(string: self)
        var double: Double = 0
        
        if scanner.scanDouble(&double) {
            return double
        }
        return double
    }
    
    func toFloat() -> Float {
        let scanner = Scanner.init(string: self)
        var float: Float = 0
        scanner.scanFloat(&float)
        return float
    }
}


