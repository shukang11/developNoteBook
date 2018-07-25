//
//  SSImage.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 16/10/11.
//  Copyright © 2016年 YD. All rights reserved.
//

import Foundation
import UIKit
public extension UIImage {
    public func toColor() -> UIColor {
        return UIColor.init(patternImage: self)
    }
    
    /// 将一个图片进行裁剪
    ///
    /// - parameter image:   原图片
    /// - parameter cutRect: 裁剪的尺寸
    ///
    /// - returns: 返回的是一个图片
    public class func image(_ image: UIImage, cutRect: CGRect) -> UIImage {
        guard let sourceImageRef = image.cgImage else {
            return UIImage.init()
        }
        let newImageRef = sourceImageRef.cropping(to: cutRect)
        return UIImage.init(cgImage: newImageRef!)
    }
    
    public func base64String(limitQuality limit: CGFloat) -> String {
        var data:Data
        var imgString:String = ""
        if (limit >= 1) {
            data = (UIImagePNGRepresentation(self)?.base64EncodedData(options: Data.Base64EncodingOptions.lineLength64Characters))!
        }else if (limit <= 0) {
            data = UIImageJPEGRepresentation(self, 0.1)!
        }else {
            data = UIImageJPEGRepresentation(self, limit)!
        }
        imgString = data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        return imgString
    }
    
    public class func imageNamed(WithNoScale name: String) -> UIImage? {
        
        guard name.length > 0 else { return nil}
        guard name.hasSuffix("/") else { return nil}
        let tempName: NSString = name as NSString
        let res: String = tempName.deletingPathExtension
        let ext: String = tempName.pathExtension
        var path: String? = nil
        let exts = (ext.length > 0) ? ([ext]) : (["", "png", "gif", "webp", "apng", "jpg", "jpeg"])
        let scales: [Float] = Bundle.main.preferredScales
        for s in scales {
            let scaledName: String = res.stringByAppendingNameScale(CGFloat(s))
            for e in exts {
                path = Bundle.main.path(forResource: scaledName, ofType: e)
                if path != nil { break}
            }
            if path != nil { break}
        }
        guard let p = path else { return nil }
        let data: NSData? = NSData(contentsOfFile: p)
        guard let d: Data = data as Data? else { return nil }
        return UIImage.init(data: d)
    }
}
